class LecturesController < ApplicationController
	before_action :authenticate_user!, except:[:show]
	before_action :set_course

	def new
		@lecture = Lecture.new
	end

	def create
		@lecture = @course.lectures.create(lecture_params)
		if @lecture.save
			redirect_to @course
		else
			render :new
		end
	end

	def show
		@lecture = @course.lectures.find(params[:id])
	end

	def edit
		@lecture = @course.lectures.find(params[:id])
	end

	def update
		@lecture = @course.lectures.find(params[:id])
		if @lecture.update(lecture_params)
			redirect_to [@course, @lecture]
		else
			render :edit
		end
	end

	def destroy
		@lecture = @course.lectures.find(params[:id])
		@lecture.destroy
		redirect_to @course
	end

	private

	def set_course
		@course = Course.find(params[:course_id])
	end

	def lecture_params
		params.require(:lecture).permit(:issue, :description, :date, support_materials:[])
	end
end