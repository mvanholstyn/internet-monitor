class ChecksController < ApplicationController
  def index
    checks = Check.where("created_at >= ?", 8.days.ago)
    render :json => {
      labels: checks.map(&:created_at),
      data: checks.map(&:up)
    }
  end
end
