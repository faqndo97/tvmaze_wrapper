# frozen_string_literal: true

# require_relative '.../configuration'
# require_relative '.../version'

module TvmazeWrapper
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
