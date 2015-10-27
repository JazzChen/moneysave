class Bidlist < ActiveRecord::Base

  ORIGIN_SITES = { honglingchuangtou: 1, renrendai: 2, jingrongquan: 3 }

  def site_name
    ORIGIN_SITES.key(self.site_id)
  end

  def self.update_or_create(data, site_name)
    new_rows = []
    site_id = ORIGIN_SITES[site_name]
    data.each do |row|
      next if row[:bid_id].blank?
      row[:site_id] = site_id
      if bidlist = Bidlist.where(site_id: site_id, bid_id: row[:bid_id]).first
        bidlist.update(row)
      else
        new_rows << row
      end
    end
    new_rows.uniq! { |row| row[:site_id] && row[:bid_id] }
    Bidlist.create(new_rows)
  end

end
