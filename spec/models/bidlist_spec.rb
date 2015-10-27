require 'rails_helper'

describe Bidlist do

  describe '.update_or_create' do
    let(:data) do
      [
        { site_id: 1,
          bid_id: '13243142434131',
          bid_type: 'A',
          name: 'lighting bid',
          bid_amount: 1_000_00,
          tenor: '1m',
          interest_rate: 10.5 }
      ]
    end

    it 'should set site id' do
      Bidlist.update_or_create(data, :honglingchuangtou)
      expect(Bidlist.first.site_id).to eq Bidlist::ORIGIN_SITES[:honglingchuangtou]
    end

    it 'should create new data' do
      Bidlist.update_or_create(data, :honglingchuangtou)
      expect(Bidlist.count).to eq 1
    end

    it 'should insert unique data' do
      data << data[0]
      Bidlist.update_or_create(data, :honglingchuangtou)
      expect(Bidlist.count).to eq 1
    end

    it 'should update old data' do
      Bidlist.update_or_create(data, :honglingchuangtou)
      new_data = [{ name: 'flash loan', bid_id: '13243142434131'}]
      Bidlist.update_or_create(new_data, :honglingchuangtou)

      expect(Bidlist.count).to eq 1
      expect(Bidlist.first.name).to eq 'flash loan'
    end
  end

end
