# frozen_string_literal: true

RSpec::Expectations.configuration.on_potential_false_positives = :nothing

RSpec.describe Phantasma::API::Request do
  let(:api_url) { 'http://testnet.phantasma.io:5101' }
  let(:api_version) { 'v1' }
  let(:request) { Phantasma::API::Request.new(url: api_url, api_version: api_version, debug: true) }
  let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }
  let(:chain_type) { 'main' }
  let(:contract_name) { 'governance' }
  let(:governance_address) { 'S3dKT1eHWjcUHdhE6ahxCZhi3CWHRkWaYFuHpoyEbtecvAM' }
  let(:hex_regex) { /\A[\da-fA-F]+\z/ }
  # show response result
  let(:debug) { true }

  describe 'Should go trough allowed method list' do
    let(:request) { Phantasma::API::Request.new(url: api_url, api_version: api_version, debug: true) }

    Phantasma::API::ALLOWED_METHODS.each do |method_name|
      method_name_snake_cased = Phantasma::Helpers.camel_to_snake(method_name.strip)
      it "Snake case method should exists - #{method_name_snake_cased}?" do
        expect(request.respond_to?(method_name_snake_cased)).to be true
        expect{request.send(method_name_snake_cased)}.not_to raise_exception(NoMethodError)
      end

      next if %w[rpc health abci_query net_info status request_block].include?(method_name)
      it "Camel case method check should fail - #{method_name}" do
        expect(request.respond_to?(method_name)).to be false
        expect{request.send(method_name)}.to raise_exception(NoMethodError)
      end
    end
  end

  describe 'AccountApi' do
    let(:wallet_address) { 'P2KLjs2Ykj8Ub1MMyFg5JWMaYk1aQPeDZa87YReVw3EifoS' }

    describe '#get_account' do
      it 'receive account information for a given account' do
        response = request.get_account({account: wallet_address})
        puts response if debug
        expect(response.to_s).to include('"address"=>"P2KLjs2Ykj8Ub1MMyFg5JWMaYk1aQPeDZa87YReVw3EifoS"')
        # We don't want add expected json body which is massive and changes day by day. if walled address is included response should be correct
      end

      it 'give invalid address error' do
        response = request.get_account({account: wallet_address + "1"})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid address"}')
      end
    end

    describe '#get_accounts' do
      it 'receive accounts information for a given accounts' do
        response = request.get_accounts({accounts: [wallet_address]})
        puts response if debug
        expect(response.to_s).to include('"address"=>"P2KLjs2Ykj8Ub1MMyFg5JWMaYk1aQPeDZa87YReVw3EifoS"')
      end

      it 'give invalid address error' do
        response = request.get_accounts({accounts: [wallet_address + "1"]})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid address"}')
      end
    end

    describe '#get_addresses_by_symbol' do
      ticker = 'SOUL'
      let(:response) { request.get_addresses_by_symbol({symbol: ticker, extended: false}) }
      it 'receive addressed by symbol' do
        puts response if debug
        expect(response.to_s).to include('address')
      end

      it 'should request symbol which does not exist and return empty array' do
        ticker += '1'
        puts response if debug
        expect(response.to_s).to eq('[]')
      end
    end

    describe '#look_up_name' do
      it 'receive account information for a given account' do
        response = request.look_up_name({name: 'test'})
        puts response if debug
        expect(response.to_s).to eq('P2KD3uqv7CTMPKDQfv39WgiKSCAbBJU1oHcMFeRW7cGGAoT')
      end

      it 'should get invalid name error' do
        response = request.look_up_name({name: 'SOUL'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid name"}')
      end
    end
  end

  describe 'AuctionApi' do
    let(:wallet_address) { 'P2KD3uqv7CTMPKDQfv39WgiKSCAbBJU1oHcMFeRW7cGGAoT' }

    describe '#get_auction' do
      # it 'receive auction information for a given wallet' do
      #   params = {
      #       chain_address_or_name: wallet_address,
      #       symbol: 'SOUL',
      #       IDtext: 1
      #   }
      #   expect(request).to receive(:get_auction).with(params).and_return('{"creatorAddress":"string","chainAddress":"string","startDate":0,"endDate":0,"baseSymbol":"string","quoteSymbol":"string","tokenId":"string","price":"string","endPrice":"string","extensionPeriod":"string","type":"string","rom":"string","ram":"string","listingFee":"string","currentWinner":"string"}')
      # end

      it 'receive Constraint failed error' do
        params = {  chain_address_or_name: wallet_address,
                    symbol: 'SOUL',
                    IDtext: 1
        }
        response = request.get_auction(params)
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"Constraint failed: nft SOUL 1 does not exist"}')
      end

      it 'give invalid ID error' do
        params = {  chain_address_or_name: 'chain_address_or_name_example',
                    symbol: 'SOUL',
                    i_dtext: 'i_dtext_example'
        }
        response = request.get_auction(params)
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid ID"}')
      end
    end

    describe '#get_accounts' do
      it 'receive accounts information for a given accounts' do
        response = request.get_accounts({accounts: [wallet_address]})
        puts response if debug
        expect(response.to_s).to include('[{"address"')
      end

      it 'give invalid address error' do
        response = request.get_accounts({accounts: [wallet_address + "1"]})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid address"}')
      end
    end

    describe '#get_addresses_by_symbol' do
      it 'receive addressed by symbol' do
        response = request.get_addresses_by_symbol({symbol: 'SOUL', extended: false})
        puts response if debug
        expect(response.to_s).to include('address')
      end

      it 'should request symbol which does not exist and return empty array' do
        response = request.get_addresses_by_symbol({symbol: 'SOUL1', extended: false})
        puts response if debug
        expect(response.to_s).to eq('[]')
      end
    end

    describe '#look_up_name' do
      it 'receive account information for a given account' do
        response = request.look_up_name({name: 'test'})
        puts response if debug
        expect(response.to_s).to eq('P2KD3uqv7CTMPKDQfv39WgiKSCAbBJU1oHcMFeRW7cGGAoT')
      end

      it 'should get invalid name error' do
        response = request.look_up_name({name: 'SOUL'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid name"}')
      end
    end
  end

  describe 'BlockApi' do
    let (:block_hash) { "DA44AFCCD72AEFCD10D4B408CEEC32552F6358D64C9A8AE0702EDF506B6CFE44" }

    describe '#get_block_height' do
      it 'receive block height' do
        response = request.get_block_height({ chainInput: chain_type })
        puts response if debug
        expect(response.to_i).to be_an(Integer)
      end

      it 'get invalid chain error' do
        response = request.get_block_height({chainInput: chain_type+"1"})
        puts response if debug
        expect(response.to_s).to eq('invalid chain')
      end
    end

    describe '#get_block_transaction_count_by_hash' do
      it 'receive block height' do
        response = request.get_block_transaction_count_by_hash({chainAddressOrName: chain_type, blockHash: block_hash })
        puts response if debug
        expect(response).to eq(1)
      end

      it 'receive invalid block hash error' do
        response = request.get_block_transaction_count_by_hash({chainAddressOrName: chain_type, blockHash: block_hash+"1"})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid block hash"}')
      end

      it 'get Chain not found error' do
        response = request.get_block_transaction_count_by_hash({chainAddressOrName: chain_type+"1", blockHash: block_hash})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"Chain not found"}')
      end
    end

    describe '#get_block_by_hash' do
      it 'receive get_block_by_hash' do
        response = request.get_block_by_hash({blockHash: block_hash})
        puts response if debug
        expect(response.to_s).to include('hash')
        expect(response.to_s).to include('previousHash')
        expect(response.to_s).to include('timestamp')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('chainAddress')
        expect(response.to_s).to include('protocol')
        expect(response.to_s).to include('txs')
        expect(response.to_s).to include('validatorAddress')
        expect(response.to_s).to include('reward')
        expect(response.to_s).to include('events')
        expect(response.to_s).to include('oracles')
      end

      it 'get invalid block hash error' do
        response = request.get_block_by_hash({blockHash: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid block hash"}')
      end
    end

    describe '#get_raw_block_by_hash' do
      it 'receive get_raw_block_by_hash' do
        response = request.get_block_by_height({chainInput: chain_type, height: 1})
        puts response if debug
        expect(response.to_s).to include('hash')
        expect(response.to_s).to include('previousHash')
        expect(response.to_s).to include('timestamp')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('chainAddress')
        expect(response.to_s).to include('protocol')
        expect(response.to_s).to include('txs')
        expect(response.to_s).to include('validatorAddress')
        expect(response.to_s).to include('reward')
        expect(response.to_s).to include('events')
        expect(response.to_s).to include('oracles')
      end

      it 'get chain not found error' do
        response = request.get_block_by_height({chainInput: 'string', height: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"chain not found"}')
      end

      it 'get nvalid number error' do
        response = request.get_block_by_height({chainInput: chain_type, height: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid number"}')
      end
    end

    describe '#get_raw_block_by_height' do
      it 'receive get_raw_block_by_height' do
        response = request.get_raw_block_by_height({chainInput: chain_type, height: 1})
        puts response if debug
        expect(response.to_s).to match(/\A[\da-fA-F]+\z/)
      end

      it 'get chain not found error' do
        response = request.get_raw_block_by_height({chainInput: 'string', height: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"chain not found"}')
      end

      it 'get nvalid number error' do
        response = request.get_raw_block_by_height({chainInput: chain_type, height: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"invalid number"}')
      end
    end

    describe '#get_latest_block' do
      it 'receive get_latest_block' do
        response = request.get_latest_block({chainInput: chain_type})
        puts response if debug
        expect(response.to_s).to include('hash')
        expect(response.to_s).to include('previousHash')
        expect(response.to_s).to include('timestamp')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('chainAddress')
        expect(response.to_s).to include('protocol')
        expect(response.to_s).to include('txs')
        expect(response.to_s).to include('validatorAddress')
        expect(response.to_s).to include('reward')
        expect(response.to_s).to include('events')
        expect(response.to_s).to include('oracles')
      end

      it 'get chain not found error' do
        response = request.get_latest_block({chainInput: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"chain not found"}')
      end
    end

    describe '#get_raw_latest_block' do
      it 'receive get_raw_latest_block' do
        response = request.get_raw_latest_block({chainInput: chain_type})
        puts response if debug
        expect(response.to_s).to match(hex_regex)
      end

      it 'get chain not found error' do
        response = request.get_raw_latest_block({chainInput: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"chain not found"}')
      end
    end

  end

  describe 'ChainApi' do

    let (:block_hash) { "DA44AFCCD72AEFCD10D4B408CEEC32552F6358D64C9A8AE0702EDF506B6CFE44" }

    describe '#get_chains' do
      it 'receive chains with extended true' do
        response = request.get_chains({extended: true})
        puts response if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('organization')
        expect(response.to_s).to include('contracts')
        expect(response.to_s).to include('dapps')
      end

      it 'receive chains with extended info false' do
        response = request.get_chains({extended: false})
        puts response if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('organization')
        expect(response.to_s).to include('contracts')
        expect(response.to_s).to include('dapps')
      end

      it 'receive Bad Request error' do
        response = request.get_chains({extended: 'string'})
        puts response if debug
        expect(response.to_s).to include("Bad Request")
      end
    end

    describe '#get_chain' do
      it 'receive chain' do
        response = request.get_chain({name: chain_type, extended: true})
        puts response.to_json if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('organization')
        expect(response.to_s).to include('contracts')
        expect(response.to_s).to include('dapps')
      end

      it 'get invalid chain error' do
        response = request.get_chain({name: chain_type+'1', extended: true})
        puts response if debug
        # Todo: report this as bug, should return invalid chain or better error.
        expect(response.to_s).to eq("{message: 'Internal Server Error', body: '', error: 'Net::HTTPInternalServerError'}")
      end
    end
  end

  describe 'ConnectionApi' do
    describe '#abci_query' do
      it 'receive abci_query' do
        response = request.abci_query({path: 'string', data: 'string', height: 0, prove: false})
        puts response if debug
        expect(response.to_s).to include('response')
        expect(response.to_s).to include('code')
        expect(response.to_s).to include('log')
        expect(response.to_s).to include('info')
        expect(response.to_s).to include('index')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('codespace')
      end
    end

    describe '#health' do
      it 'receive health' do
        response = request.health
        puts response if debug
        expect(response.to_s).to eq('{}')
      end
    end

    describe '#status' do
      it 'receive status' do
        response = request.status
        puts response.to_json if debug
        expect(response.to_s).to include('nodeInfo')
        expect(response.to_s).to include('syncInfo')
        expect(response.to_s).to include('validatorInfo')
      end
    end

    describe '#net_info' do
      it 'receive net_info' do
        response = request.net_info
        puts response.to_json if debug
        expect(response.to_s).to include('listening')
        expect(response.to_s).to include('listeners')
        expect(response.to_s).to include('nPeers')
        expect(response.to_s).to include('peers')
      end
    end

    describe '#request_block' do
      it 'receive request_block' do
        response = request.request_block({height: 0})
        puts response.to_json if debug
        expect(response.to_s).to include('response')
        expect(response.to_s).to include('info')
        expect(response.to_s).to include('value')
      end

      it 'block height does dont exists and get response' do
        response = request.request_block({height: 99999})
        puts response if debug
        expect(response.to_s).to include('response')
        expect(response.to_s).to include('code')
        expect(response.to_s).to include('info')
        expect(response.to_s).to include('height')
        expect(response.to_s).to include('codespace')
        expect(response.to_s).to eq('{"response"=>{"code"=>1, "log"=>"", "info"=>"Block get", "index"=>"0", "height"=>"0", "codespace"=>""}}')
      end

      it 'receive request_block bigint is not allowed' do
        response = request.request_block({height: 999999999999})
        puts response.to_json if debug
        expect(response.to_s).to include('Net::HTTPBadRequest')
      end
    end

    describe '#get_validators_settings' do
      it 'receive get_validators_settings' do
        response = request.get_validators_settings
        puts response.to_json if debug
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('kind')
        expect(response.to_s).to include('isSystem')
        expect(response.to_s).to include('isInterop')
        expect(response.to_s).to include('isUser')
        expect(response.to_s).to include('tendermintAddress')
        expect(response.to_s).to include('tendermintPublicKey')
        expect(response.to_s).to include('text')
        expect(response.to_s).to include('platformID')
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('host')
        expect(response.to_s).to include('port')
        expect(response.to_s).to include('url')
      end
    end
  end

  describe 'ContractApi' do
    describe '#get_contracts' do
      it 'receive get_contracts with extended true' do
        response = request.get_contracts({chainAddressOrName: chain_type, extended: true})
        puts response.to_json if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('script')
        expect(response.to_s).to include('events')
      end

      it 'receive get_contracts with extended false' do
        response = request.get_contracts({chainAddressOrName: chain_type, extended: false})
        puts response.to_json if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('script')
        expect(response.to_s).to include('events')
      end

      it 'receive Chain not found error' do
        response = request.get_contracts({chainAddressOrName: 'string', extended: true})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"Chain not found"}')
      end
    end

    describe '#get_contract' do
      it 'receive get_contract' do
        response = request.get_contract({chainAddressOrName: chain_type, contractName: contract_name})
        puts response.to_json if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('script')
        expect(response.to_s).to include('events')
      end

      it 'receive Contract not found error' do
        response = request.get_contract({chainAddressOrName: chain_type, contractName: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"Contract not found"}')
      end

      it 'receive Chain not found error' do
        response = request.get_contract({chainAddressOrName: 'string', contractName: 'string'})
        expect(response.to_s).to eq('{"error"=>"Chain not found"}')
      end
    end

    describe '#get_contract_by_address' do
      it 'receive get_contract_by_address' do
        response = request.get_contract_by_address({chainAddressOrName: chain_type, contractAddress: governance_address})
        puts response.to_json if debug
        expect(response.to_s).to include('name')
        expect(response.to_s).to include('address')
        expect(response.to_s).to include('script')
        expect(response.to_s).to include('events')
      end

      it 'receive Invalid contract address error' do
        response = request.get_contract_by_address({chainAddressOrName: chain_type, contractAddress: 'string'})
        puts response if debug
        expect(response.to_s).to eq('{"error"=>"Invalid contract address"}')
      end

      it 'receive Chain not found error' do
        response = request.get_contract_by_address({chainAddressOrName: 'string', contractAddress: 'string'})
        expect(response.to_s).to eq('{"error"=>"Chain not found"}')
      end
    end
  end

end
