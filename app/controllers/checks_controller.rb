class ChecksController < ApplicationController
  def index
    checks = Check.where("created_at >= ?", 30.days.ago)
    render :json => {
      labels: checks.map(&:created_at),
      data: checks.map(&:up)
    }
  end
end
