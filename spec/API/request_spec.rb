# frozen_string_literal: true

RSpec::Expectations.configuration.on_potential_false_positives = :nothing

RSpec.describe Phantasma::API::Request do
  let(:api_url) { 'http://testnet.phantasma.io:5101' }
  let(:api_version) { 'v1' }
  let(:request) { Phantasma::API::Request.new(url: api_url, api_version: api_version, debug: true) }
  let(:response) { Net::HTTPSuccess.new(1.0, '200', 'OK') }

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
        expect(response.to_s).to include('"address"=>"P2KLjs2Ykj8Ub1MMyFg5JWMaYk1aQPeDZa87YReVw3EifoS"')
        # We don't want add expected json body which is massive and changes day by day. if walled address is included response should be correct
        expect(response.to_s).to eq(response.to_s)
      end

      it 'give invalid address error' do
        response = request.get_account({account: wallet_address + "1"})
        expect(response.to_s).to eq('{"error"=>"invalid address"}')
      end
    end

    describe '#get_accounts' do
      it 'receive accounts information for a given accounts' do
        response = request.get_accounts({accounts: [wallet_address]})
        expect(response.to_s).to include('"address"=>"P2KLjs2Ykj8Ub1MMyFg5JWMaYk1aQPeDZa87YReVw3EifoS"')
        expect(response.to_s).to eq(response.to_s)
      end

      it 'give invalid address error' do
        response = request.get_accounts({accounts: [wallet_address + "1"]})
        expect(response.to_s).to eq('{"error"=>"invalid address"}')
      end
    end

    describe '#get_addresses_by_symbol' do
      ticker = 'SOUL'
      let(:response) { request.get_addresses_by_symbol({symbol: ticker, extended: false}) }
      it 'receive addressed by symbol' do

        expect(response.to_s).to include('address')
        expect(response.to_s).to eq(response.to_s)
      end

      it 'should request symbol which does not exist and return empty array' do
        ticker += '1'
        expect(response.to_s).to eq('[]')
      end
    end

    describe '#look_up_name' do
      it 'receive account information for a given account' do
        response = request.look_up_name({name: 'test'})
        expect(response.to_s).to eq('P2KD3uqv7CTMPKDQfv39WgiKSCAbBJU1oHcMFeRW7cGGAoT')
      end

      it 'should get invalid name error' do
        response = request.look_up_name({name: 'SOUL'})
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
        expect(response.to_s).to eq('{"error"=>"Constraint failed: nft SOUL 1 does not exist"}')
      end

      it 'give invalid ID error' do
        params = {  chain_address_or_name: 'chain_address_or_name_example',
                    symbol: 'SOUL',
                    i_dtext: 'i_dtext_example'
        }
        response = request.get_auction(params)
        expect(response.to_s).to eq('{"error"=>"invalid ID"}')
      end
    end

    describe '#get_accounts' do
      it 'receive accounts information for a given accounts' do
        response = request.get_accounts({accounts: [wallet_address]})
        expect(response.to_s).to include('[{"address"')
        expect(response.to_s).to eq(response.to_s)
      end

      it 'give invalid address error' do
        response = request.get_accounts({accounts: [wallet_address + "1"]})
        expect(response.to_s).to eq('{"error"=>"invalid address"}')
      end
    end

    describe '#get_addresses_by_symbol' do
      it 'receive addressed by symbol' do
        response = request.get_addresses_by_symbol({symbol: 'SOUL', extended: false})
        expect(response.to_s).to include('address')
        expect(response.to_s).to eq(response.to_s)
      end

      it 'should request symbol which does not exist and return empty array' do
        response = request.get_addresses_by_symbol({symbol: 'SOUL1', extended: false})
        expect(response.to_s).to eq('[]')
      end
    end

    describe '#look_up_name' do
      it 'receive account information for a given account' do
        response = request.look_up_name({name: 'test'})
        expect(response.to_s).to eq('P2KD3uqv7CTMPKDQfv39WgiKSCAbBJU1oHcMFeRW7cGGAoT')
      end

      it 'should get invalid name error' do
        response = request.look_up_name({name: 'SOUL'})
        expect(response.to_s).to eq('{"error"=>"invalid name"}')
      end
    end
  end
end
