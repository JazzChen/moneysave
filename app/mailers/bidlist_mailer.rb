class BidlistMailer < ApplicationMailer
  def send_daily_message(address = 'jazz.chen@wolaidai.com')
    @bidlist = Bidlist.first(10)
    mail(to: address, subject: 'Today Top 3 bids')
  end
end
