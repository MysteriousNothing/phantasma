# frozen_string_literal: true

require_relative 'phantasma/API/request'
require_relative 'phantasma/helpers'
require_relative "phantasma/version"

module Phantasma
  class Error < StandardError; end
  class PhantasmaResponseError < StandardError; end

end
