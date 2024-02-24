# frozen_string_literal: true
require_relative 'api'
require 'uri'
require 'net/http'
require 'json'
require 'openssl'

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
        uri, get_method = construct_uri(method_name, method_args)
        request = create_request(uri, method_args, get_method)
        response = execute_request(request, uri)
        parse_response(response)
      rescue PhantasmaResponseError => e
        e
      end

      def construct_uri(method_name, method_args)
        base_uri = "#{@url}/api/#{@api_version}/"
        case method_name.to_s
        when 'get_validator_by_type' && !method_args.empty?
          raise PhantasmaResponseError, 'GetValidator type not specified' if method_args.first[:type].nil?
          [URI("#{base_uri}GetValidators/#{method_args.first[:type]}"), true]
        when 'rpc'
          [URI("#{@url}/#{method_name.to_s}"), false]
        else
          [URI("#{base_uri}#{@allowed_methods_hash[method_name.to_s]}"), true]
        end
      end

      def create_request(uri, method_args, get_method)
        if get_method
          uri.query = URI.encode_www_form(method_args.first) unless method_args.empty?
          request = Net::HTTP::Get.new(uri)
        else
          request = Net::HTTP::Post.new(uri)
          request.body = JSON.dump(method_args.first)
        end
        request['Content-Type'] = 'application/json'
        request['Accept'] = 'application/json'
        request
      end

      def execute_request(request, uri)
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.scheme == 'https'
          http.use_ssl = true
          # http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
        http.request(request)
      end

      def parse_response(response)
        if response.is_a?(Net::HTTPSuccess)
          JSON.parse(response.body)
        else
          raise PhantasmaResponseError, "{message: '#{response.message}', body: '#{response.body}', error: '#{response.class}'}"
        end
      end
    end
  end
end
