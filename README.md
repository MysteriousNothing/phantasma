# Phantasma Ruby SDK

This gem is community edition of Phantasma Blockchain SDK in Ruby.

Allowed endpoints are copied from here:  
https://github.com/phantasma-io/Phantasma-Py#documentation-for-api-endpoints

## Install
```
gem "phantasma", :git => "git://github.com/MysteriousNothing/phantasma.git"
```

## Test API URL
http://testnet.phantasma.io:5101
## Live API URL
https://phantasma.gitbook.io/developers/overview/quick-start

The Ruby version does not use different classes, we use Ruby metaprogramming.
This means adding new endpoint means updating `ALLOWED_METHOD` const in  

#### AccountApi
```
api = Phantasma::API::Request.new(url: 'http://testnet.phantasma.io:5101')
api.get_account({account: '1231313'})
api.get_accounts({accounts: ['1231313']})
api.get_addresses_by_symbol({symbol: 'SOUL', extended: false})
api.look_up_name({name: 'SOUL'})
```
#### AuctionApi
```
api = Phantasma::API::Request.new(url: 'http://testnet.phantasma.io:5101')
params = {  chain_address_or_name: 'chain_address_or_name_example',
            symbol: 'SOUL',
            IDtext: 'i_dtext_example'
}
api.get_auction(params)
params = {  chain_address_or_name: 'chain_address_or_name_example',
            symbol: 'SOUL'
}
api.get_auctions_count(params)
params = {  chain_address_or_name: 'chain_address_or_name_example',
            symbol: 'SOUL',
            page: 1,
            page_size: 99999
}
api.get_auctions(params)
```

### BlockApi
```
api = Phantasma::API::Request.new(url: 'http://testnet.phantasma.io:5101')
api.get_block_by_hash({block_hash: 'block_hash'})
api.get_block_by_height({chain_input: 'chain_input_example', height: 'height'})
api.get_block_height({chain_input: 'chain_input_example'})
params = { chain_address_or_name: 'chain_address_or_name_example',
           block_hash: 'block_hash_example'
}
api.get_block_transaction_count_by_hash(params)
api.get_latest_block({chain_input: 'chain_input'})
api.get_raw_block_by_hash({block_hash: 'block_hash_example'})
api.get_raw_block_by_height({chain_input: 'chain_input_example', height: 'height'})
api.get_raw_latest_block({chain_input: 'chain_input_example'})
```

### ChainApi
```
api = Phantasma::API::Request.new(url: 'http://testnet.phantasma.io:5101')
# you can add params = {extended} api.get_chains(params), works both ways.
api.get_chains
params = {name: 'main', extended: true}
api.get_chain(params)
```

### ConnectionApi
```
api = Phantasma::API::Request.new(url: 'http://testnet.phantasma.io:5101')
params = {
    path: 'path_example',
    data: 'data_example',
    height: 0,
    prove: false
}
api.abci_query(params)

# To be continued...

```

# Documentation for API Endpoints
https://testnet.phantasma.io/swagger/index.html

## Todo
[ ] Finish documentation and tests (https://github.com/phantasma-io/Phantasma-Py/tree/main/docs - Some request have incorrect params names)

[ ] RPC or eRPC(Google RPC, http2)

[ ] Phantasma VM in Ruby

[ ] Add API command line support

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MysteriousNothing/phantasma.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
