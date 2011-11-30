class Admin::InquiriesController < Admin::BaseController

  crudify :inquiry, :title_attribute => "name", :order => "created_at DESC"
  helper_method :group_by_date

  before_filter :find_all_ham, :only => [:index]
  before_filter :find_all_spam, :only => [:spam]
  #before_filter :get_spam_count, :only => [:index, :spam]

  def index
    @inquiries = @inquiries.with_query(params[:search]) if searching?
    @inquiries = @inquiries.paginate({:page => params[:page]}) if @inquiries.any?
  end
  
  def update
    #@inquiry = Inquiry.new(params[:inquiry])
    #@inquiry.updated_at = Time.now
    #@inquiry.status = params[:inquiry][:status]
    @inquiry.isapproved = params[:inquiry][:status].to_i > 0
    @inquiry.isclosed = params[:inquiry][:status].to_i > 1
    @inquiry.inquiry_category_id = params[:inquiry][:inquiry_category_id]
    @inquiry.answer = params[:inquiry][:answer]
    @inquiry.recipient = params[:inquiry][:recipient]
    @inquiry.updated_at = Time.now
    #if @inquiry.update_attributes(params[:inquiry])
    if @inquiry.save
      begin
        InquiryMailer.change_notification(@inquiry, request).deliver
      rescue
        logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
      end

      redirect_to admin_inquiry_url(@inquiry)
    else
      logger.warn('could not save')
      render :action => 'edit'
    end
  end

  def spam
    self.index
    render :action => 'index'
  end

  def toggle_spam
    find_inquiry
    @inquiry.toggle!(:spam)

    redirect_to :back
  end

protected

  def find_all_ham
    @inquiries = Inquiry
  end

  def find_all_spam
    @inquiries = Inquiry.spam
  end

  def get_spam_count
    @spam_count = Inquiry.count(:conditions => {:spam => true})
  end

end
