class InquiriesController < ApplicationController

  before_filter :find_page, :only => [:create, :new]

  def thank_you
    @page = Page.find_by_link_url("/contact/thank_you", :include => [:parts, :slugs])
  end

  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(params[:inquiry])
    @inquiry.status = 'Queued'
    @inquiry.answer = ''
    @inquiry.created_at = Time.now
    @inquiry.updated_at = Time.now
    @inquiry.recipient = ''

    if @inquiry.save
      begin
        InquiryMailer.notification(@inquiry, request).deliver
      rescue
        logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
        logger.warn $!.message
        logger.warn $!.backtrace
      end

      begin
        InquiryMailer.change_notification(@inquiry, request, 'inquiry_notification_new_email').deliver
      rescue
        logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
        logger.warn $!.message
        logger.warn $!.backtrace
      end

      redirect_to thank_you_inquiries_url
    else
      render :action => 'new'
    end
  end
  
  def index
#    @page = Page.find_by_link_url("/contact/thank_you", :include => [:parts, :slugs])
    if params[:inquiry_category_id] and params[:inquiry_category_id].to_i > 0
      @inquiries = Inquiry.where(:isprivate => false, :isclosed => true, :inquiry_category_id => params[:inquiry_category_id]).paginate(:page => params[:page])
      @category = params[:inquiry_category_id].to_i
    else
      @inquiries = Inquiry.where("(isprivate is NULL or isprivate != 't') and isclosed == 't'").paginate(:page => params[:page], :per_page => 5)
      @category = 0
    end
    @categories = InquiryCategory.all;
    #    @inquiries = Inquiry.where(:isprivate => nil)
  end
  
  def show
    @inquiry = Inquiry.find(params[:id])
  end

protected

  def find_page
    @page = Page.find_by_link_url('/contact', :include => [:parts, :slugs])
  end

end
