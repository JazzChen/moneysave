namespace :email do
  desc "TODO"
  task send: :environment do
    BidlistMailer.send_daily_message('gjazz@163.com').deliver_now
  end

end
