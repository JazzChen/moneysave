require 'mechanize'
require 'logger'
require 'active_support/inflector'
Dir[File.expand_path('sites/*.rb', File.dirname(__FILE__))].each { |f| require f }

module BidlistCrawler
  class Crawler

    def initialize(site)
      # includes instance methods ('run' and 'site_encode') defined in 'sites' module
      self.extend "BidlistCrawler::Sites::#{site.to_s.classify}".constantize
      # logger is a method defined below
      @agent = Mechanize.new { |a| a.log = logger }
      @pages = {}
    end

    def logger
      if defined? Rails
        Logger.new(File.join(Rails.root, 'log', 'crawler.log'))
      else
        Logger.new('crawler.log')
      end
    end

    def make_time_piece(seconds)
      return unless @last_got_at
      sleep seconds if Time.now - @last_got_at < seconds
    end

    # download the page in memory
    def get(url)
      return @pages[url] unless @pages[url].nil?
      # wait 1 seconds preventing download pages too frequently
      make_time_piece(1)
      @agent.get(url)
      # site_encode method defined in BidlistCrawler::Sites::~
      @agent.page.encoding = site_encode if respond_to? :site_encode
      @last_got_at = Time.now
      @pages[url] = @agent.page
    end
  end

end
