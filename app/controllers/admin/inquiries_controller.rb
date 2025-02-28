class Admin::InquiriesController < Admin::BaseController

  crudify :inquiry, :title_attribute => "name", :order => "created_at DESC"
  helper_method :group_by_date

  before_filter :find_all_ham, :only => [:index]
  before_filter :add_status, :only => [:edit]
  before_filter :set_status, :only => [:create]

  def index
    @inquiries = @inquiries.with_query(params[:search]) if searching?
    @inquiries = @inquiries.where_status(params[:status]) if params[:status]
    @status = params[:status] if params[:status]
    @inquiries = @inquiries.paginate({:page => params[:page]}) if @inquiries.any?
  end

  def update
    #@inquiry = Inquiry.new(params[:inquiry])
    #@inquiry.updated_at = Time.now
    #@inquiry.status = params[:inquiry][:status]
    if params[:inquiry][:status].to_i > 0 and not @inquiry.isapproved
      recipient_added = true
    else
      recipient_added = false
    end
    if params[:inquiry][:status].to_i > 1 and not @inquiry.isclosed
      answer_added = true
    else
      answer_added = false
    end
    @inquiry.isapproved = params[:inquiry][:status].to_i > 0
    @inquiry.isclosed = params[:inquiry][:status].to_i > 1
    @inquiry.inquiry_category_id = params[:inquiry][:inquiry_category_id]
    @inquiry.answer = params[:inquiry][:answer]
    @inquiry.message = params[:inquiry][:message] || params[:inquiry][:question]
    @inquiry.recipient = params[:inquiry][:recipient]
    @inquiry.updated_at = Time.now
    #if @inquiry.update_attributes(params[:inquiry])
    if @inquiry.save
      if recipient_added
        begin
          InquiryMailer.change_notification(@inquiry, request, 'inquiry_notification_recipient_email').deliver
        rescue
          logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
        end
      end
      if answer_added
        begin
          InquiryMailer.change_notification(@inquiry, request, 'inquiry_notification_answer_email').deliver
        rescue
          logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
        end
      end

      redirect_to admin_inquiry_url(@inquiry)
    else
      logger.warn('could not save')
      render :action => 'edit'
    end
  end

  def export
    #@inquiry = Inquiry.find(params[:id])
    @inquiries = Inquiry
    @inquiries = @inquiries.where_status(params[:status]) if params[:status]
    @categories = InquiryCategory.find(params[:category])
    @start_date = Date.civil(params[:date]["from(1i)"].to_i,
                            params[:date]["from(2i)"].to_i,
                            params[:date]["from(3i)"].to_i)
    @inquiries = @inquiries.where('created_at >= ?', @start_date)
    @end_date = Date.civil(params[:date]["to(1i)"].to_i,
                            params[:date]["to(2i)"].to_i,
                            params[:date]["to(3i)"].to_i)
    @inquiries = @inquiries.where('created_at <= ?', @end_date)
    render :layout => false
  end

  def new_export
    @status = params[:status]
    @first_date = Inquiry.unscoped.order('created_at ASC').select(:created_at).first.created_at
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

  def add_status
    if @inquiry.isclosed
      @inquiry.status = 2;
    elsif @inquiry.isapproved
      @inquiry.status = 1;
    else
      @inquiry.status = 0;
    end
  end

  def set_status
    params[:inquiry][:isprivate] = false
    params[:inquiry][:isapproved] = true
    params[:inquiry][:isclosed] = true
  end
end
