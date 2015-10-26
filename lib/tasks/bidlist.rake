namespace :bidlist do

  desc "crawl bidlist honglingchuangtou site"
  task crawl_honglingchuangtou: :environment do
    if Rails.env.production?
      crawler = BidlistCrawler::Crawler.new(:honglingchuangtou)
      crawler.run { |data| Bidlist.update_or_create(data, :honglingchuangtou) }
    end
  end

end
