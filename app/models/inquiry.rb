class Inquiry < ActiveRecord::Base

  validates :name, :presence => true
  validates :message, :presence => true
  validates :email, :format=> { :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i }

  alias_attribute :question, :message

  acts_as_indexed :fields => [:name, :email, :message]

  default_scope :order => 'created_at DESC' # previously scope :newest

  attr_accessible :name, :message, :email, :isprivate, :inquiry_category_id
  attr_accessible :status, :answer, :recipient, :created_at, :updated_at, :isapproved, :isclosed, :as => :admin
  
  belongs_to :inquiry_category

  STATUSES = ['new', 'approved', 'closed']

  def self.latest(number = 7)
    limit(number)
  end

  def self.where_status(stat)
    if stat == 'new'
        where(:isclosed => false, :isapproved => false)
    elsif stat == 'approved'
        where(:isclosed => false, :isapproved => true)
    elsif stat == 'closed'
        where(:isclosed => true, :isapproved => true)
    end
  end

  #class << self
    def inquiry_status()
      if self.isclosed
        'closed'
      elsif self.isapproved
        'approved'
      else
        'new'
      end
    end

    def inquiry_status=(stat)
      if stat == 'new'
        self.isclosed = false
        self.isapproved = false
      elsif stat == 'approved'
        self.isclosed = false
        self.isapproved = true
      elsif stat == 'closed'
        self.isclosed = true
        self.isapproved = true
      end
    end
  #end
end
