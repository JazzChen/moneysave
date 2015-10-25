require 'rails_helper'
require 'bidlist_crawler/crawler'

describe BidlistCrawler::Sites::Honglingchuangtou do
  let(:crawler) { BidlistCrawler::Crawler.new(:honglingchuangtou) }

  describe "#run" do
    it "should execute block" do
      flag = 0
      crawler.run { |x| flag += x}
      expect(flag).to eq 1
    end
  end

  describe "#get_data" do
    it 'should send get request' do
      allow(crawler).to receive(:get).and_return(1)
      allow(crawler).to receive(:parse)
    end
  end

  describe "#get_more_detail" do
    pending
  end

  describe "#parse" do
    it 'should return array' do
      page = double('page')
      allow(page).to receive(:search).and_return([])
      expect(crawler.send(:parse, page)).to eq []
    end
  end

  describe "#parse_for_total_page_count" do
    pending
  end

end
