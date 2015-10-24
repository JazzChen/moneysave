module BidlistCrawler
  module Sites
    module Honglingchuangtou

      SITE_URL = 'http://www.my089.com'

      def run(&block)
        date ||= {}
        yield(data)
      end

      def site_encode
        'utf-8'
      end

      private

    end
  end
end
