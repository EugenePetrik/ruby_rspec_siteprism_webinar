# frozen_string_literal: true

module ApplicationHelper
  def session_link
    if logged_in?
      link_to t('.log_out'), logout_path, method: :delete
    else
      link_to t('.log_in'), login_path
    end
  end
end
