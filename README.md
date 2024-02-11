# Phantasma Ruby SDK
[Phantasma](https://phantasma.io/) - A Smart NFT Carbon Negative Blockchain for Gaming, dApp

This gem is community edition of Phantasma Blockchain SDK in Ruby.

## Install
```
gem "phantasma", :git => "https://github.com/MysteriousNothing/phantasma.git"
```

#### Test API URL
http://testnet.phantasma.io:5101
## Live API URL
https://phantasma.gitbook.io/developers/overview/quick-start

The Ruby version does not use different classes, we use Ruby metaprogramming.
This means adding new endpoint means updating `ALLOWED_METHOD` const in [lib/phantasma/API/api.rb](lib/phantasma/API/request.rb)

#### Examples how to use API:
```
api = Phantasma::API::Request.new(url: 'http://testnet.phantasma.io:5101')
api.get_account({account: '1231313'})
api.get_accounts({accounts: ['1231313']})
api.get_addresses_by_symbol({symbol: 'SOUL', extended: false})
api.look_up_name({name: 'SOUL'})
```

## Full API documentation is here:
[docs/api_documentation.md](docs/api_documentation.md)

### Generate documentation after API update:

```
ruby lib/phantasma/documentation.rb
```

# Phantasma Documentation for API Endpoints with responses
https://testnet.phantasma.io/swagger/index.html

## Helpers
Find missing or deprecated API endpoints by calling

```
Phantasma::API.find_missing_endpoints
Phantasma::API.find_deprecated_endpoints
```

## Running tests

```
# All tests
rspec spec/
# Specific
rspec spec/API/api_spec.rb
```

## Todo
- [ ] Finish documentation and tests (https://github.com/phantasma-io/Phantasma-Py/tree/main/docs - Some request have incorrect params names)

- [ ] RPC or eRPC(Google RPC, http2)

- [ ] Phantasma VM in Ruby

- [ ] Add API command line support

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MysteriousNothing/phantasma.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
