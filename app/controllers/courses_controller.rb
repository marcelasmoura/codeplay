class CoursesController < ApplicationController
	def index
	 @courses = Course.all	
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.create(course_params)
		redirect_to @course
	end

	def show
		@course = Course.find(params[:id])
	end

	private

	def course_params
		params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline)
	end
end