require 'rails_helper'

describe BidlistCrawler::Crawler do

  describe "#initailze" do
    it "set agent" do
      crawler = BidlistCrawler::Crawler.new(:honglingchuangtou)
      expect(crawler.instance_variable_get(:@agent)).not_to be_nil
    end
  end

  describe "#get" do
    let(:crawler) { BidlistCrawler::Crawler.new(:honglingchuangtou) }
    let(:agent) { crawler.instance_variable_get(:@agent) }

    before(:each) do
      allow(agent).to receive(:get)
      allow(crawler).to receive(:respond_to?).with(:site_encode).and_return(false)
    end

    it 'should send get request' do
      expect(agent).to receive(:get)
      crawler.get('http://example.com')
    end

    it 'should set last_got_at' do
      crawler.get('http://example.com')
      expect(crawler.instance_variable_get(:@last_got_at)).not_to be_nil
    end
  end

  describe "#make_time_peice" do
    let(:crawler) { BidlistCrawler::Crawler.new(:honglingchuangtou) }

    it 'should return nil when @last_got_at is nil' do
      expect(crawler.make_time_piece(1)).to be_nil
    end

    it 'should sleep if over time piece since last_got_at' do
      allow(crawler).to receive(:sleep)
      crawler.instance_variable_set(:@last_got_at, Time.now - 60)

      expect(crawler).not_to receive(:sleep)
      crawler.make_time_piece(5)
    end

    it 'should sleep if not over time piece since last_got_at' do
      allow(crawler).to receive(:sleep)
      crawler.instance_variable_set(:@last_got_at, Time.now)

      expect(crawler).to receive(:sleep)
      crawler.make_time_piece(60)
    end
  end

  describe '#logger' do
    it 'should return Logger instance' do
      crawler = BidlistCrawler::Crawler.new(:honglingchuangtou)
      expect(crawler.logger).to be_kind_of Logger
    end
  end

end
