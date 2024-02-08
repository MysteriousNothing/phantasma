# frozen_string_literal: true
require_relative '../helpers'
require 'uri'
require 'net/http'
require 'json'

module Phantasma
  module API

    # Copied from here: https://github.com/phantasma-io/Phantasma-Py#documentation-for-api-endpoints
    ALLOWED_METHODS = %w[GetAccount GetAccounts GetAddressesBySymbol LookUpName GetAuction GetAuctionsCount GetAuctions
GetBlockByHash GetBlockByHeight GetBlockHeight GetBlockTransactionCountByHash GetLatestBlock GetRawBlockByHash GetRawBlockByHeight
GetRawLatestBlock GetChains GetChain abci_query GetValidatorsSettings health net_info request_block status GetContractByAddress GetContract GetContracts
GetLeaderboard GetNexus GetOrganizationByName GetOrganization GetOrganizations GetInterop GetPlatform GetPlatforms rpc
GetLatestSaleHash GetSale ReadImage GetNFT GetNFTs GetTokenBalance GetTokenData GetToken GetTokens GetAddressTransactionCount
GetAddressTransactions GetTransactionByBlockHashAndIndex GetTransaction InvokeRawScript SendRawTransaction GetValidators GetValidatorByType].freeze

    def self.allowed_methods_hash
      hash = {}
      ALLOWED_METHODS.each { |value| hash["#{Phantasma::Helpers.camel_to_snake(value.strip)}"] = "#{value}" }
      hash
    end

    def self.find_missing_endpoints
      endpoints = (Phantasma::Helpers.test_api_endpoints - ALLOWED_METHODS)
      # Special case, defined as GetValidatorByType int this gem
      endpoints.delete('GetValidators/{type}')
      endpoints
    end

    def self.find_deprecated_endpoints
      endpoints = []
      test_endpoints = Phantasma::Helpers.test_api_endpoints
      ALLOWED_METHODS.each do |endpoint|
        next if endpoint == 'GetValidatorByType'
        unless test_endpoints.include?(endpoint.to_s)
          endpoints << endpoint
        end
      end
      endpoints
    end

  end
end
