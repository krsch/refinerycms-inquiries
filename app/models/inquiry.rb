class Inquiry < ActiveRecord::Base

  validates :name, :presence => true
  validates :message, :presence => true
  validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  acts_as_indexed :fields => [:name, :email, :message]

  default_scope :order => 'created_at DESC' # previously scope :newest

  attr_accessible :name, :message, :email, :isprivate, :inquiry_category_id
  attr_accessible :status, :answer, :recipient, :created_at, :updated_at, :isapproved, :isclosed, :as => :admin
  
  belongs_to :inquiry_category

  def self.latest(number = 7)
    limit(number)
  end

end
