require_dependency "landlord/application_controller"

module Landlord
  class AccountsController < ApplicationController

    def new
      @account = Account.new
    end

    def create
      @account = Account.new(account_params)

      respond_to do |format|
        if @account.save
          format.html { redirect_to account_dashboard_path @account, notice: 'Account was successfully created.' }
          format.json { render :show, status: :created, location: @account }
        else
          format.html { render :new }
          format.json { render json: @account.errors, status: :unprocessable_entity }
        end
      end
    end

    private

      def account_params
        params.require(:account).permit(:name)
      end

  end
end
