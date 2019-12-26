# frozen_string_literal: true

class LoginsController < ApplicationController
  skip_before_action :require_user, only: %i[new create]

  def new; end

  def create
    student = Student.find_by(email: params[:logins][:email].downcase)

    if student&.authenticate(params[:logins][:password])
      session[:student_id] = student.id
      flash[:notice] = t('.success_log_in')
      redirect_to student
    else
      flash.now[:notice] = t('.something_was_wrong')
      render 'new'
    end
  end

  def destroy
    session[:student_id] = nil
    flash[:notice] = t('.success_log_out')
    redirect_to root_path
  end
end
