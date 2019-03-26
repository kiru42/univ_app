class StudentCoursesController < ApplicationController
  def create
    course_to_add = Course.find(params[:course_id])
    unless current_user.courses.include?(course_to_add)
      flash[:notice] = "You have successfully enrolled in #{course_to_add.name}"
      current_user.courses << course_to_add
      redirect_to current_user
    else
      flash[:notice] = "Something was wrong with your enrollment"
      redirect_to root_path
    end
  end
end