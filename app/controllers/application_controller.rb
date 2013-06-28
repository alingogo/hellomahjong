class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    @meeting = Meeting.find_by_id(session[:meeting_id])
    @tm      = session[:tm]
    if @tm
      return true
    else
      return false
    end
  end
end
