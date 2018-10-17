require 'mandrill_mailer/template_mailer'
module MandrillMailer
  class MandrillTemplateJob < ActiveJob::Base
    queue_as { MandrillMailer.config.deliver_later_queue_name }

    def perform(template_name, template_content, message, async, ip_pool, send_at, api_key=nil, mailer='MandrillMailer::TemplateMailer')
      MandrillMailer.configure do |config|
        config.api_key = api_key
      end if api_key
      mailer = mailer.constantize.new
      mailer.template_name = template_name
      mailer.template_content = template_content
      mailer.message = message
      mailer.async = async
      mailer.ip_pool = ip_pool
      mailer.send_at = send_at
      mailer.deliver_now
    end
  end
end
