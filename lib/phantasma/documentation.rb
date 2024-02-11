require_relative 'helpers'
require 'uri'
require 'net/http'
require 'json'

module Phantasma
  class Documentation
    # Based on test swagger json generate documentation
    # https://testnet.phantasma.io/swagger/v1/swagger.json
    SWAGGER_URL = 'https://testnet.phantasma.io/swagger/v1/swagger.json'

    def self.generate_documentation
      api_data = http_request
      # Start generating the documentation
      File.open(documentation_dir, 'w') do |file|
        api_data['paths'].each do |path, methods|
          methods.each do |method, details|
            endpoint = path.gsub('/api/v1/', '')
            if endpoint == 'GetValidators/{type}'
              # special case
              endpoint = 'GetValidatorByType'
            end
            ruby_method_name = Phantasma::Helpers.camel_to_snake(endpoint.split('/').last)
            parameters = details['parameters'] || []

            file.puts "### #{details['tags'].first} - #{ruby_method_name}"
            file.puts "- **Endpoint**: `#{path}`"
            file.puts "- **Method**: `#{method.upcase}`"
            file.puts '- **Parameters**:'
            if parameters.empty?
              file.puts '  - None'
            else
              parameters.each do |param|
                if param.dig('schema', 'default').nil?
                  file.puts "  - `#{param['name']}`: #{param.dig('schema', 'type')}"
                else
                  file.puts "  - `#{param['name']}`: #{param.dig('schema',
                                                                 'type')}, `default`: #{param.dig('schema', 'default')}"
                end
              end
            end
            file.puts '- **Ruby Example**:'
            file.puts '```ruby'
            if parameters.empty?
              file.puts "api.#{ruby_method_name}"
            else
              file.puts "api.#{ruby_method_name}(#{generate_ruby_hash(parameters) unless parameters.empty?})"
            end
            file.puts '```'
            file.puts ''
          end
        end
      end

      puts "Documentation generated in #{documentation_dir}"
    end

    def self.http_request
      url = URI(SWAGGER_URL)
      https = Net::HTTP.new(url.host, url.port)
      https.use_ssl = true
      request = Net::HTTP::Get.new(url)
      response = https.request(request)
      json_data = response.read_body
      JSON.parse(json_data)
    end

    def self.documentation_dir
      "#{Dir.pwd.gsub('lib/phantasma', 'docs')}/api_documentation.md"
    end

    def self.generate_ruby_hash(parameters)
      params = parameters.map do |param|
        if param.dig('schema', 'default').nil?
          "#{param['name']}: '#{param.dig('schema', 'type')}'"
        else
          if %w(boolean integer).include?(param.dig('schema', 'type'))
            "#{param['name']}: #{param.dig('schema', 'default')}"
          else
            "#{param['name']}: '#{param.dig('schema', 'default')}'"
          end
        end
      end
      "{#{params.join(', ')}}"
    end
  end
end

Phantasma::Documentation.generate_documentation
