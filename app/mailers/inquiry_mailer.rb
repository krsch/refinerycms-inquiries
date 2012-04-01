class InquiryMailer < ActionMailer::Base
  def notification(inquiry, request)
    subject     InquirySetting.notification_subject
    recipients  InquirySetting.notification_recipients
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    sent_on     Time.now
    @inquiry =  inquiry
  end
  
  def change_notification(inquiry, request, reason)
    subject     RefinerySetting.find_by_name(reason + '_subject_' + Globalize.locale.to_s).value
    recipients  inquiry.email
    from        "\"#{RefinerySetting[:site_name]}\" <no-reply@#{request.domain(RefinerySetting.find_or_set(:tld_length, 1))}>"
    reply_to    InquirySetting.notification_recipients.split(',').first
    sent_on     Time.now
    text = RefinerySetting.find_by_name(reason + '_body_' + Globalize.locale.to_s ).value
    text.gsub! /%([^%=]+)%/, "<%=inquiry.\\1%>"
    logger.warn "Text: #{text}"
    mail do |format|
      format.text { render :inline => text, :locals => {:inquiry => inquiry} }
    end
  end

end
