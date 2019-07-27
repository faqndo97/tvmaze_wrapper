# frozen_string_literal: true

module TvmazeWrapper
  module Search
    def search_by_name(name)
      params = {
        q: name
      }

      get('search/shows', params)
    end

    def single_search_by_name(name)
      params = {
        q: name
      }

      get('singlesearch/shows', params)
    end
  end
end
