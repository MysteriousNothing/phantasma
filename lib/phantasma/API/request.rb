# frozen_string_literal: true
require_relative 'api'
require 'uri'
require 'net/http'
require 'json'

module Phantasma
  module API
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
        return super(method_name, *args, &block) unless @allowed_methods_hash.include?(method_name.to_s)
        self.class.send(:define_method, method_name) do |*method_args|
          build_request(method_name, method_args)
        end
        self.send(method_name, *args, &block)
      end

      private

      def build_request(method_name, method_args)
        # Special case GetValidator/{type}
        uri = URI("#{@url}/api/#{@api_version}/#{@allowed_methods_hash[method_name.to_s]}".freeze)
        if method_name == 'get_validator_by_type'
          raise PhantasmaResponseError, 'GetValidator type not specified' if method_args[:type].nil?

          type = method_args[:type]
          uri = URI("#{@url}/api/#{@api_version}/GetValidator/#{type}".freeze)
        end
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
