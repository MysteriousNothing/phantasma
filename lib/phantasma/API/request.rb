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
GetRawLatestBlock GetChains GetChain abci_query GetValidatorsSettings health net_info request_block status GetContractByAddress GetContract
GetLeaderboard GetNexus GetOrganizationByName GetOrganization GetOrganizations GetInterop GetPlatform GetPlatforms rpc
GetLatestSaleHash GetSale GetNFT GetNFTs GetTokenBalance GetTokenData GetToken GetTokens GetAddressTransactionCount
GetAddressTransactions GetTransactionByBlockHashAndIndex GetTransaction InvokeRawScript SendRawTransaction GetValidators GetValidators/{type}].freeze

    def self.allowed_methods_hash
      hash = {}
      ALLOWED_METHODS.each { |value| hash["#{Phantasma::Helpers.camel_to_snake(value.strip)}"] = "#{value}" }
      hash
    end

    class Request
      attr_accessor :url, :api_version, :debug

      def initialize(url:, api_version: 'v1', debug: false)
        @url = url
        @api_version = api_version
        @debug = debug
        @allowed_methods_hash = Phantasma::API.allowed_methods_hash
      end

      def respond_to_missing?(method_name, include_private = false)
        @allowed_methods_hash.include?(method_name.to_s) || super
      end

      def method_missing(method_name, *args, &block)
        return super method_name, *args, &block unless @allowed_methods_hash.include?(method_name.to_s)
        self.class.send(:define_method, method_name) do |*method_args|
          build_request(method_name, method_args)
        end
        self.send method_name, *args, &block
      end

      private

      def build_request(method_name, method_args)
        uri = URI("#{@url}/api/#{@api_version}/#{@allowed_methods_hash[method_name.to_s]}".freeze)
        puts uri if @debug
        uri.query = URI.encode_www_form(method_args.first) unless method_args.empty?
        response = Net::HTTP.get_response(uri)
        if response.is_a?(Net::HTTPSuccess)
          JSON.parse(response.body)
        else
          raise PhantasmaResponseError, "{message: '#{response.message}', body: '#{response.body}', error: '#{response.class}'}"
        end
      rescue PhantasmaResponseError => e
        e
      end
    end
  end
end
