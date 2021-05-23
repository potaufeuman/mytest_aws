class ApplicationMailer < ActionMailer::Base
  default from: "noreply@example.com"
  layout 'mailer'

  def default_url_options(options = {})
    { locale: I18n.locale }.merge ActionMailer::Base.default_url_options
  end
end
