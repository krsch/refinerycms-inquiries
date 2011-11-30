class InquiryCategory < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  acts_as_indexed :fields => [:name]
  has_many :inquiries
  attr_accessible :name
end
