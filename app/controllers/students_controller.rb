class StudentsController < ApplicationController
	before_filter :check_admin, only: [:index]

  def index
    @students = Student.all
  end

  private

  def check_admin
    if teacher_signed_in?
      true
    else
      redirect_to root_path, alert: "Sorry, only teachers can see this page."
    end
  end

end