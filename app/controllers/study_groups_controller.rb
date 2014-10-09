class StudyGroupsController < ApplicationController

  def index
    @study_groups = StudyGroup.all
  end

  def new
    @study_group = StudyGroup.new
  end

  def create
    @study_group = StudyGroup.create(study_group_params)
    if @study_group.save
      name = @study_group.name
      redirect_to study_groups_path
      flash[:notice] = "#{name} created"
    else
      render 'new'
      flash[:error] = "Unable to create study group. Please try again"
    end
  end

  def destroy
    @study_group = StudyGroup.find(params[:id])
    @study_group.destroy
    redirect_to study_groups_path
  end

  def edit
    @study_group = StudyGroup.find(params[:id])
  end

  def update
    @study_group = StudyGroup.find(params[:id])
    @study_group.update study_group_params
    if @study_group.save
      flash[:notice] = "Your study group was updated succesfully"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

    def study_group_params
      params.require(:study_group).permit(:name, :delete)
    end

end
