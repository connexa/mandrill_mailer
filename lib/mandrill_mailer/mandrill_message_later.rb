require 'mandrill_mailer/message_mailer'
module MandrillMailer
  class MandrillMessageJob < ActiveJob::Base
    queue_as { MandrillMailer.config.deliver_later_queue_name }

    def perform(message, async, ip_pool, send_at, api_key=nil, mailer='MandrillMailer::MessageMailer')
      MandrillMailer.configure do |config|
        config.api_key = api_key
      end if api_key
      mailer = mailer.constantize.new
      mailer.message = message
      mailer.async = async
      mailer.ip_pool = ip_pool
      mailer.send_at = send_at
      mailer.deliver_now
    end
  end
end
