class CoursesController < ApplicationController
	def index
	 @courses = Course.all	
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new
	end

	def show
		@course = Course.find(params[:id])
	end
end