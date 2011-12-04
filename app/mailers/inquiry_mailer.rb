class InquiryMailer < ActionMailer::Base

  def confirmation(inquiry, request)
    subject     InquirySetting.confirmation_subject(Globalize.locale)
    recipients  inquiry.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    InquirySetting.notification_recipients.split(',').first
    sent_on     Time.now
    @inquiry =  inquiry
  end

  def notification(inquiry, request)
    subject     InquirySetting.notification_subject
    recipients  InquirySetting.notification_recipients
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @inquiry =  inquiry
  end
  
  def change_notification(inquiry, request, reason)
    subject     RefinerySetting.find( (@reason + '_subject_' + Globalize.locale).to_sym )
    recipients  inquiry.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    InquirySetting.notification_recipients.split(',').first
    sent_on     Time.now
    @inquiry =  inquiry
    @reason  =  reason
  end

end
