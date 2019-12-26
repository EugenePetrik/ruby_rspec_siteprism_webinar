# frozen_string_literal: true

class CoursesController < ApplicationController
  skip_before_action :require_user, except: %i[new create]

  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      flash[:notice] = t(:success_create, course_name: @course.name)
      redirect_to @course
    else
      render 'new'
    end
  end

  private

  def course_params
    params.require(:course).permit(:name, :short_name, :description)
  end
end
