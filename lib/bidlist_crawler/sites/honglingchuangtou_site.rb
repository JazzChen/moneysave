module BidlistCrawler
  module Sites
    module Honglingchuangtou

      SITE_URL = 'http://www.my089.com'

      def run(&block)
        begin
          (1..total_page_count).each do |page_num|
            logger.info "===============Getting bid list of Honglingchuangtou at #{page_num}th page=========="
            data = get_data(generate_page_url(page_num))
            yield(data)
          end
        rescue Mechanize::ResponseCodeError => e
          logger.info "[HonglingchuangtouResponseError] #{e.message}"
        end
      end

      def site_encode
        'utf-8'
      end

      private

      def get_data(page_url)
        # get() defined in BidlistCrawler::Crawler module
        page = get(page_url)
        parse(page)
      end

      def parse(page)
        bids = page.search('div.Loan_box dl.LoanList')
        data ||= []
        bids.each do |tr|
          bid = {
            bid_open_at: tr.search('.user_time span.lf').text.to_time,
            bid_type: tr.search('.txt_tou b')[0]['title'].split('，')[0].strip,
            bid_id: tr.search('.txt_tou a.lf').first['href'].split('=')[1].strip,
            url_address: URI.join(page.uri, tr.search('.txt_tou a.lf').first['href']).to_s,
            name: tr.search('.txt_tou a.lf').text.strip,
            bid_amount: tr.search('.dd_3 span.number')[0].children[1].text.gsub(',', '').to_f,
            interest_rate: tr.search('.dd_2 span.number')[0].text.to_f
          }
          parse_for_detail(bid)
          data << bid
        end
        data
      end

      def parse_for_detail(bid)
        begin
          page = get(bid[:url_address])
          form = page.search('.Bid_rt')
          binfo = form.search('.biao_info li')
          bid[:tenor] = binfo[2].children[1].text.strip
          bid[:repayment_method] = binfo[3].children[1].text.strip
          strs = binfo[4].children[1].text.gsub(/(￥|元|,)/, '').split('~')
          bid[:min_invest_amount] = strs[0].to_f
          bid[:max_invest_amount] = strs[1].to_f
          bid[:risk_level] = 1
          bid[:remaining_amount] = page.search('.time span')[1].text.gsub(/,/, '')[/\d+\.*\d+/].to_f
#          unless str = page.search('.time span')[2].text.split('：')[1].strip == '已结束'
#            bid[:bid_closed_at] = str.to_datetime
#          end
        rescue Mechanize::ResponseCodeError => e
          logger.info "[HonglingchuangtouResponseError] #{e.message}, #{data}"
        end
      end

      def generate_page_url(page_num)
        "#{SITE_URL}/loan/default.aspx?pid=#{page_num}"
      end

      def total_page_count
        page = get("#{SITE_URL}/loan")
        parse_for_total_page_count(page)
      end

      def parse_for_total_page_count(page)
        if num = page.search('div.yema span.z_page')
          num.text[/\d+/].to_i
        else
          1
        end
      end
    end
  end
end
