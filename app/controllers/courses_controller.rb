class CoursesController < ApplicationController
	def index
	 @courses = Course.all	
	end

	def new
		@course = Course.new
	end

	def create
		@course = Course.new(course_params)
		#redirect_to @course
		if @course.save
	      redirect_to @course
	    else
	      flash[:alert] = 'Verifique os erros:'
	      render :new
	    end
	end

	def show
		@course = Course.find(params[:id])
	end

	def edit
		@course = Course.find(params[:id])
	end

	def update
		@course = Course.find(params[:id])

		if @course.update(course_params)
	      redirect_to @course
	    else
	      flash[:alert] = 'Verifique os erros:'
	      render :edit
	    end
	end

	def destroy
		@course = Course.find(params[:id])
		@course.destroy
		redirect_to courses_path
	end

	private

	def course_params
		params.require(:course).permit(:name, :description, :code, :price, :enrollment_deadline, :teacher_id)
	end
end