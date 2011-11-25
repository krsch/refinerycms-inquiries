class CreateInquiries < ActiveRecord::Migration
  def self.up
    unless ::Inquiry.table_exists?
      create_table ::Inquiry.table_name, :force => true do |t|
        t.string   "name"
        t.string   "email"
        t.text     "message"
        t.text     "recipient"
        t.text     "answer"
        t.string   "status"
        t.boolean  "isprivate"
        t.boolean  "isapproved"
        t.boolean  "isclosed"
        t.integer  "inquiry_category_id"
        t.datetime "created_at"
        t.datetime "updated_at"
      end

      add_index ::Inquiry.table_name, :id
    end
    
    unless ::InquiryCategory.table_exists?
      create_table ::InquiryCategory.table_name, :force => true do |t|
        t.string "name"
      end
    end

    ::Page.reset_column_information if defined?(::Page)

    load(Rails.root.join('db', 'seeds', 'pages_for_inquiries.rb').to_s)
  end

  def self.down
     drop_table ::Inquiry.table_name

     ::Page.delete_all({
       :link_url => ("/contact" || "/contact/thank_you" || "/questions")
     }) if defined?(::Page)
  end
end
