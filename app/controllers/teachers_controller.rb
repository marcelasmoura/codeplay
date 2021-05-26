class TeachersController < ApplicationController
	def index
		@teachers = Teacher.all
	end

	def show
		@teacher = Teacher.find(params[:id])
	end

	def new
		@teacher = Teacher.new
	end

	def create
		@teacher = Teacher.new(teacher_params)
		if @teacher.save
	      redirect_to @teacher
	    else
	      render :new
	    end
	end

	def edit
		@teacher = Teacher.find(params[:id])
	end

	def update
		@teacher = Teacher.find(params[:id])

		if @teacher.update(teacher_params)
	      redirect_to @teacher
	    else
	      render :new
	    end
	end

	def destroy
		@teacher = Teacher.find(params[:id])
		if @teacher.destroy
			redirect_to teachers_path
		else
			render :show
		end
	end

	private

	def set_teachers
		@teacher = Teacher.find(params[:id])
	end

	def teacher_params
		params.require(:teacher).permit(:name, :bio, :email, :profile_picture)
	end
	
end