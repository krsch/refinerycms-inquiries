class Admin::InquiryCategoriesController < Admin::BaseController

  crudify :inquiry_category,
	:only => [:index, :create],
        :title_attribute => "name",
	:order => 'name ASC'
#	:redirect_to_url => "admin_inquiries_url"

  def index
    @inquiry_categories = InquiryCategory.all
    @inquiry_category = InquiryCategory.new
  end

  def create
    @inquiry_category = InquiryCategory.new(params[:inquiry_category])
    if @inquiry_category.save
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
end
