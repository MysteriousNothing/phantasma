### Account - get_account
- **Endpoint**: `/api/v1/GetAccount`
- **Method**: `GET`
- **Parameters**:
  - `account`: string
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_account({account: 'string', extended: true})
```

### Account - get_accounts
- **Endpoint**: `/api/v1/GetAccounts`
- **Method**: `GET`
- **Parameters**:
  - `accounts`: string
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_accounts({accounts: 'string', extended: true})
```

### Account - look_up_name
- **Endpoint**: `/api/v1/LookUpName`
- **Method**: `GET`
- **Parameters**:
  - `name`: string
- **Ruby Example**:
```ruby
api.look_up_name({name: 'string'})
```

### Account - get_addresses_by_symbol
- **Endpoint**: `/api/v1/GetAddressesBySymbol`
- **Method**: `GET`
- **Parameters**:
  - `symbol`: string
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_addresses_by_symbol({symbol: 'string', extended: true})
```

### Auction - get_auctions_count
- **Endpoint**: `/api/v1/GetAuctionsCount`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `symbol`: string
- **Ruby Example**:
```ruby
api.get_auctions_count({chainAddressOrName: 'string', symbol: 'string'})
```

### Auction - get_auctions
- **Endpoint**: `/api/v1/GetAuctions`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `symbol`: string
  - `page`: integer, `default`: 1
  - `pageSize`: integer
- **Ruby Example**:
```ruby
api.get_auctions({chainAddressOrName: 'string', symbol: 'string', page: 1, pageSize: 'integer'})
```

### Auction - get_auction
- **Endpoint**: `/api/v1/GetAuction`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `symbol`: string
  - `IDtext`: string
- **Ruby Example**:
```ruby
api.get_auction({chainAddressOrName: 'string', symbol: 'string', IDtext: 'string'})
```

### Block - get_block_height
- **Endpoint**: `/api/v1/GetBlockHeight`
- **Method**: `GET`
- **Parameters**:
  - `chainInput`: string
- **Ruby Example**:
```ruby
api.get_block_height({chainInput: 'string'})
```

### Block - get_block_transaction_count_by_hash
- **Endpoint**: `/api/v1/GetBlockTransactionCountByHash`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `blockHash`: string
- **Ruby Example**:
```ruby
api.get_block_transaction_count_by_hash({chainAddressOrName: 'string', blockHash: 'string'})
```

### Block - get_block_by_hash
- **Endpoint**: `/api/v1/GetBlockByHash`
- **Method**: `GET`
- **Parameters**:
  - `blockHash`: string
- **Ruby Example**:
```ruby
api.get_block_by_hash({blockHash: 'string'})
```

### Block - get_raw_block_by_hash
- **Endpoint**: `/api/v1/GetRawBlockByHash`
- **Method**: `GET`
- **Parameters**:
  - `blockHash`: string
- **Ruby Example**:
```ruby
api.get_raw_block_by_hash({blockHash: 'string'})
```

### Block - get_block_by_height
- **Endpoint**: `/api/v1/GetBlockByHeight`
- **Method**: `GET`
- **Parameters**:
  - `chainInput`: string
  - `height`: string
- **Ruby Example**:
```ruby
api.get_block_by_height({chainInput: 'string', height: 'string'})
```

### Block - get_raw_block_by_height
- **Endpoint**: `/api/v1/GetRawBlockByHeight`
- **Method**: `GET`
- **Parameters**:
  - `chainInput`: string
  - `height`: string
- **Ruby Example**:
```ruby
api.get_raw_block_by_height({chainInput: 'string', height: 'string'})
```

### Block - get_latest_block
- **Endpoint**: `/api/v1/GetLatestBlock`
- **Method**: `GET`
- **Parameters**:
  - `chainInput`: string
- **Ruby Example**:
```ruby
api.get_latest_block({chainInput: 'string'})
```

### Block - get_raw_latest_block
- **Endpoint**: `/api/v1/GetRawLatestBlock`
- **Method**: `GET`
- **Parameters**:
  - `chainInput`: string
- **Ruby Example**:
```ruby
api.get_raw_latest_block({chainInput: 'string'})
```

### Chain - get_chains
- **Endpoint**: `/api/v1/GetChains`
- **Method**: `GET`
- **Parameters**:
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_chains({extended: true})
```

### Chain - get_chain
- **Endpoint**: `/api/v1/GetChain`
- **Method**: `GET`
- **Parameters**:
  - `name`: string, `default`: main
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_chain({name: 'main', extended: true})
```

### Connection - abci_query
- **Endpoint**: `/api/v1/abci_query`
- **Method**: `GET`
- **Parameters**:
  - `path`: string
  - `data`: string
  - `height`: integer, `default`: 0
  - `prove`: boolean, `default`: false
- **Ruby Example**:
```ruby
api.abci_query({path: 'string', data: 'string', height: 0, prove: false})
```

### Connection - health
- **Endpoint**: `/api/v1/health`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.health
```

### Connection - status
- **Endpoint**: `/api/v1/status`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.status
```

### Connection - net_info
- **Endpoint**: `/api/v1/net_info`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.net_info
```

### Connection - request_block
- **Endpoint**: `/api/v1/request_block`
- **Method**: `GET`
- **Parameters**:
  - `height`: integer, `default`: 0
- **Ruby Example**:
```ruby
api.request_block({height: 0})
```

### Connection - get_validators_settings
- **Endpoint**: `/api/v1/GetValidatorsSettings`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.get_validators_settings
```

### Contract - get_contracts
- **Endpoint**: `/api/v1/GetContracts`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_contracts({chainAddressOrName: 'string', extended: true})
```

### Contract - get_contract
- **Endpoint**: `/api/v1/GetContract`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `contractName`: string
- **Ruby Example**:
```ruby
api.get_contract({chainAddressOrName: 'string', contractName: 'string'})
```

### Contract - get_contract_by_address
- **Endpoint**: `/api/v1/GetContractByAddress`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `contractAddress`: string
- **Ruby Example**:
```ruby
api.get_contract_by_address({chainAddressOrName: 'string', contractAddress: 'string'})
```

### Leaderboard - get_leaderboard
- **Endpoint**: `/api/v1/GetLeaderboard`
- **Method**: `GET`
- **Parameters**:
  - `name`: string
- **Ruby Example**:
```ruby
api.get_leaderboard({name: 'string'})
```

### Nexus - get_nexus
- **Endpoint**: `/api/v1/GetNexus`
- **Method**: `GET`
- **Parameters**:
  - `extended`: boolean, `default`: false
- **Ruby Example**:
```ruby
api.get_nexus({extended: false})
```

### Organization - get_organization
- **Endpoint**: `/api/v1/GetOrganization`
- **Method**: `GET`
- **Parameters**:
  - `id`: string
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_organization({id: 'string', extended: true})
```

### Organization - get_organization_by_name
- **Endpoint**: `/api/v1/GetOrganizationByName`
- **Method**: `GET`
- **Parameters**:
  - `name`: string
  - `extended`: boolean, `default`: true
- **Ruby Example**:
```ruby
api.get_organization_by_name({name: 'string', extended: true})
```

### Organization - get_organizations
- **Endpoint**: `/api/v1/GetOrganizations`
- **Method**: `GET`
- **Parameters**:
  - `extended`: boolean, `default`: false
- **Ruby Example**:
```ruby
api.get_organizations({extended: false})
```

### Platform - get_platforms
- **Endpoint**: `/api/v1/GetPlatforms`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.get_platforms
```

### Platform - get_platform
- **Endpoint**: `/api/v1/GetPlatform`
- **Method**: `GET`
- **Parameters**:
  - `platform`: string
- **Ruby Example**:
```ruby
api.get_platform({platform: 'string'})
```

### Platform - get_interop
- **Endpoint**: `/api/v1/GetInterop`
- **Method**: `GET`
- **Parameters**:
  - `platform`: string
- **Ruby Example**:
```ruby
api.get_interop({platform: 'string'})
```

### Rpc - rpc
- **Endpoint**: `/rpc`
- **Method**: `POST`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.rpc
```

### Sale - get_latest_sale_hash
- **Endpoint**: `/api/v1/GetLatestSaleHash`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.get_latest_sale_hash
```

### Sale - get_sale
- **Endpoint**: `/api/v1/GetSale`
- **Method**: `GET`
- **Parameters**:
  - `hashText`: string
- **Ruby Example**:
```ruby
api.get_sale({hashText: 'string'})
```

### Storage - read_image
- **Endpoint**: `/api/v1/ReadImage`
- **Method**: `GET`
- **Parameters**:
  - `hashText`: string
  - `format`: string, `default`: png
- **Ruby Example**:
```ruby
api.read_image({hashText: 'string', format: 'png'})
```

### Token - get_tokens
- **Endpoint**: `/api/v1/GetTokens`
- **Method**: `GET`
- **Parameters**:
  - `extended`: boolean, `default`: false
- **Ruby Example**:
```ruby
api.get_tokens({extended: false})
```

### Token - get_token
- **Endpoint**: `/api/v1/GetToken`
- **Method**: `GET`
- **Parameters**:
  - `symbol`: string
  - `extended`: boolean
- **Ruby Example**:
```ruby
api.get_token({symbol: 'string', extended: 'boolean'})
```

### Token - get_token_data
- **Endpoint**: `/api/v1/GetTokenData`
- **Method**: `GET`
- **Parameters**:
  - `symbol`: string
  - `IDtext`: string
- **Ruby Example**:
```ruby
api.get_token_data({symbol: 'string', IDtext: 'string'})
```

### Token - get_nft
- **Endpoint**: `/api/v1/GetNFT`
- **Method**: `GET`
- **Parameters**:
  - `symbol`: string
  - `IDtext`: string
  - `extended`: boolean, `default`: false
- **Ruby Example**:
```ruby
api.get_nft({symbol: 'string', IDtext: 'string', extended: false})
```

### Token - get_nfts
- **Endpoint**: `/api/v1/GetNFTs`
- **Method**: `GET`
- **Parameters**:
  - `symbol`: string
  - `IDText`: string
  - `extended`: boolean, `default`: false
- **Ruby Example**:
```ruby
api.get_nfts({symbol: 'string', IDText: 'string', extended: false})
```

### Token - get_token_balance
- **Endpoint**: `/api/v1/GetTokenBalance`
- **Method**: `GET`
- **Parameters**:
  - `account`: string
  - `tokenSymbol`: string
  - `chainInput`: string
- **Ruby Example**:
```ruby
api.get_token_balance({account: 'string', tokenSymbol: 'string', chainInput: 'string'})
```

### Transaction - get_transaction_by_block_hash_and_index
- **Endpoint**: `/api/v1/GetTransactionByBlockHashAndIndex`
- **Method**: `GET`
- **Parameters**:
  - `chainAddressOrName`: string
  - `blockHash`: string
  - `index`: integer
- **Ruby Example**:
```ruby
api.get_transaction_by_block_hash_and_index({chainAddressOrName: 'string', blockHash: 'string', index: 'integer'})
```

### Transaction - get_address_transactions
- **Endpoint**: `/api/v1/GetAddressTransactions`
- **Method**: `GET`
- **Parameters**:
  - `account`: string
  - `page`: integer, `default`: 1
  - `pageSize`: integer, `default`: 99999
- **Ruby Example**:
```ruby
api.get_address_transactions({account: 'string', page: 1, pageSize: 99999})
```

### Transaction - get_address_transaction_count
- **Endpoint**: `/api/v1/GetAddressTransactionCount`
- **Method**: `GET`
- **Parameters**:
  - `account`: string
  - `chainInput`: string, `default`: main
- **Ruby Example**:
```ruby
api.get_address_transaction_count({account: 'string', chainInput: 'main'})
```

### Transaction - send_raw_transaction
- **Endpoint**: `/api/v1/SendRawTransaction`
- **Method**: `GET`
- **Parameters**:
  - `txData`: string
- **Ruby Example**:
```ruby
api.send_raw_transaction({txData: 'string'})
```

### Transaction - invoke_raw_script
- **Endpoint**: `/api/v1/InvokeRawScript`
- **Method**: `GET`
- **Parameters**:
  - `chainInput`: string
  - `scriptData`: string
- **Ruby Example**:
```ruby
api.invoke_raw_script({chainInput: 'string', scriptData: 'string'})
```

### Transaction - get_transaction
- **Endpoint**: `/api/v1/GetTransaction`
- **Method**: `GET`
- **Parameters**:
  - `hashText`: string
- **Ruby Example**:
```ruby
api.get_transaction({hashText: 'string'})
```

### Validator - get_validators
- **Endpoint**: `/api/v1/GetValidators`
- **Method**: `GET`
- **Parameters**:
  - None
- **Ruby Example**:
```ruby
api.get_validators
```

### Validator - get_validator_by_type
- **Endpoint**: `/api/v1/GetValidators/{type}`
- **Method**: `GET`
- **Parameters**:
  - `type`: string
- **Ruby Example**:
```ruby
api.get_validator_by_type({type: 'string'})
```

