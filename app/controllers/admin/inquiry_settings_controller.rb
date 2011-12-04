class Admin::InquirySettingsController < Admin::BaseController

  crudify :refinery_setting,
          :title_attribute => "name",
          :order => 'name ASC',
          :redirect_to_url => "admin_inquiries_url"

  before_filter :set_url_override?, :only => [:edit, :update]
  after_filter :save_subject_for_confirmation?, :only => :update
  after_filter :save_message_for_confirmation?, :only => :update
  around_filter :rewrite_flash?, :only => :update

  def update
    if /^inquiry_notification_(.*)_email/ =~ params[:id]
      body_name = params[:id] + '_body'
      subject_name = params[:id] + '_subject'
      params[:body_n].each do |locale, value|
        RefinerySetting.set( (body_name + '_' + locale).to_sym, value)
      end
      params[:subject_n].each do |locale, value|
        RefinerySetting.set( (subject_name + '_' + locale).to_sym, value)
      end
    end
    render :text => "<script>parent.window.location = '#{admin_inquiries_url}';</script>"
  end

protected
  def rewrite_flash?
    yield

    flash[:notice] = flash[:notice].to_s.gsub(/(\'.*\')/) {|m| m.titleize}.gsub('Inquiry ', '')
  end

  def save_subject_for_confirmation?
    InquirySetting.confirmation_subject = params[:subject] if params.keys.include?('subject')
  end
  
  def save_message_for_confirmation?
    InquirySetting.confirmation_message = params[:message] if params.keys.include?('message')
  end

  def set_url_override?
    @url_override = admin_inquiry_setting_url(@refinery_setting, :dialog => from_dialog?)
  end

  def find_refinery_setting
    # ensure that we're dealing with the name of the setting, not the id.
    begin
      if params[:id].to_i.to_s == params[:id]
        params[:id] = RefinerySetting.find(params[:id]).name.to_s
      end
    rescue
    end

    if /^inquiry_notification_.*_email/ =~ params[:id]
      @body = params[:id] + "_body_#{locale}"
      @id = params[:id]
      @subject = params[:id] + "_subject_#{locale}"
      @body_setting = RefinerySetting.find_or_set(@body.to_sym, '')
      @subject_setting = RefinerySetting.find_or_set(@subject.to_sym, '')
    else

      # prime the setting first, if it's valid.
      if InquirySetting.methods.map(&:to_sym).include?(params[:id].to_s.gsub('inquiry_', '').to_sym)
        InquirySetting.send(params[:id].to_s.gsub('inquiry_', '').to_sym)
      end
      @refinery_setting = RefinerySetting.find_by_name(params[:id])
    end

  end

end
