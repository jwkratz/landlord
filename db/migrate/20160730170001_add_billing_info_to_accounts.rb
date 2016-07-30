class AddBillingInfoToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :landlord_accounts, :card_name, :string
    add_column :landlord_accounts, :card_brand, :string
    add_column :landlord_accounts, :card_last4, :string
    add_column :landlord_accounts, :card_exp_month, :integer
    add_column :landlord_accounts, :card_exp_year, :integer
  end
end
