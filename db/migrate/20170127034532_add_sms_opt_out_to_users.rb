class AddSmsOptOutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sms_opt_out, :boolean, null: false, default: false
  end
end
