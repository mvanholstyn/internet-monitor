class DashboardController < ApplicationController
  def index
    @checks = Check.where(up: false).last(10)
  end
end
