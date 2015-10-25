require 'rails_helper'

describe BidlistCrawler::Sites::Honglingchuangtou do
  let(:crawler) { BidlistCrawler::Cralwer.new(:honglingchuangtou) }

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
end
