require 'test_helper'

module Landlord
  class ReceiptTest < ActiveSupport::TestCase

    test "should not save receipt without stripe_id" do
      receipt = Landlord::Receipt.new
      assert_not receipt.save, "Saved the receipt without a stripe_id"
    end

    test "should not save receipt without account" do
      receipt = Landlord::Receipt.new
      receipt.stripe_id = "stripe_id"
      assert_not receipt.save, "Saved the receipt without an account"
    end

    test "should save valid receipt" do
      receipt = Landlord::Receipt.new
      receipt.stripe_id = "stripe_id"
      receipt.account = Landlord::Account.first
      assert receipt.save, "Saved the receipt"
    end

  end
end
