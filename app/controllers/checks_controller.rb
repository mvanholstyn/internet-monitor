class ChecksController < ApplicationController
  def index
    checks = Check.all
    render :json => {
      labels: checks.map(&:created_at),
      data: checks.map(&:up)
    }
  end
end
