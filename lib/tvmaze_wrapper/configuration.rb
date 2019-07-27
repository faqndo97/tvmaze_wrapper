module TvmazeWrapper
  class Configuration
    attr_accessor :api_base, :client_id, :client_secret

    def initialize
      @api_base       = nil
      @client_id      = nil
      @client_secret  = nil
    end
  end
end
