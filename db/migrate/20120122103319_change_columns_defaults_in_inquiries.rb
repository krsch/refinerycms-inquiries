class ChangeColumnsDefaultsInInquiries < ActiveRecord::Migration
  def self.up
    Inquiry.update_all({:isclosed => false}, {:isclosed => nil})
    Inquiry.update_all({:isprivate => false}, {:isprivate => nil})
    Inquiry.update_all({:isapproved => false}, {:isapproved => nil})
    change_column :inquiries, :isprivate, :boolean, :null=>false, :default => false
    change_column :inquiries, :isapproved, :boolean, :null=>false, :default => false
    change_column :inquiries, :isclosed, :boolean, :null=>false, :default => false
  end

  def self.down
    change_column :inquiries, :isprivate, :boolean, :null=>true
    change_column :inquiries, :isapproved, :boolean, :null=>true
    change_column :inquiries, :isclosed, :boolean, :null=>true
  end
end
