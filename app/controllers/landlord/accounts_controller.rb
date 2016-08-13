require_dependency "landlord/application_controller"

module Landlord
  class AccountsController < ApplicationController
    prepend_before_action :set_account_id, only: [:show]
    before_action :authenticate_user!, only: [:index]
    before_action :require_active_account, only: [:show]

    # List the signed-in user's accounts
    # GET /
    def index
      @accounts = current_user.accounts.not_canceled
      if @accounts.size == 1
        redirect_to account_path @accounts.first
      end
    end

    # Show the new account signup form
    # GET /new
    def new
      @account = Account.new
      @account.memberships.build.build_user
      @plans = Plan.all
    end

    # Create a new account
    # POST /
    def create
      @account = Account.new(account_params)

      if @account.save
        AccountMailer.welcome(@account).deliver_later

        if current_user && @account.owner == current_user
          # User is already signed in; take them directly to the account dashboard
          redirect_to @account, notice: 'Welcome to your new account!'
        else
          # User is not signed in; take them to the success page
          redirect_to new_account_success_path
        end
      else
        @plans = Plan.all
        render :new
      end
    end

    # Account created success page
    # GET /new/success
    def success
    end

    # Show a single account's dashboard page
    # GET /1
    def show
    end

    private

      # The application controller needs the :id resource to be named :account_id
      def set_account_id
        params[:account_id] = params[:id]
      end

      def account_params
        params.require(:account).permit(:name, :plan_id, memberships_attributes: [ user_attributes: [ :first_name, :last_name, :email, :password ] ])
      end

  end
end
