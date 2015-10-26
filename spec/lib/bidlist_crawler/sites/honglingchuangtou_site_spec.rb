require 'rails_helper'
require 'bidlist_crawler/crawler'

describe BidlistCrawler::Sites::Honglingchuangtou do
  let(:crawler) { BidlistCrawler::Crawler.new(:honglingchuangtou) }

  describe "#run" do
    it "should execute block" do
      flag = 0
      allow(crawler).to receive(:total_page_count).and_return(1)
      allow(crawler).to receive(:get_data).and_return(1)
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

  describe "#parse_more_detail"

  describe "#parse" do
    it 'should return array' do
      page = double('page')
      allow(page).to receive(:search).and_return([])

      expect(crawler.send(:parse, page)).to eq []
    end
  end

  describe "#parse_for_total_page_count" do
    it "should return number" do
      page = double('page')
      item = double('item')
      allow(page).to receive(:search).and_return(item)
      allow(item).to receive(:text).and_return('total 10 pages')

      expect(crawler.send(:parse_for_total_page_count, page)).to eq 10
    end
  end

end
