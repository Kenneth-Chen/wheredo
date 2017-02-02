class AddSubscriptionStateToUsers < ActiveRecord::Migration
  def up
    add_column :users, :subscription_state, :integer, null: false, default: 0
    add_column :users, :pause_until, :datetime
    remove_column :users, :sms_opt_out
  end

  def down
    add_column :users, :sms_opt_out, :boolean, null: false, default: false    
    remove_column :users, :pause_until
    remove_column :users, :subscription_state
  end
end
