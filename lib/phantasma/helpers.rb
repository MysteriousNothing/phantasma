module Phantasma
  class Helpers
    def self.camel_to_snake(str)
      str.to_s.gsub(/::/, '/')
          .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
          .gsub(/([a-z\d])([A-Z])/, '\1_\2')
          .tr('-', '_')
          .downcase
    end

    # this is for linux system to check if any new endpoints vs ALLOWED_ENDPOINTS
    def self.test_api_endpoints
      cmd = `curl -v --silent https://testnet.phantasma.io/swagger/v1/swagger.json 2>&1 |  grep -oP '(?<=\/api\/v1/)(.+)(?=\".+$)'`
      endpoints = cmd&.gsub(/\n/, ' ').strip.split(' ')
      endpoints&.push('rpc')
    end

  end
end
