class RepositoriesController < ApplicationController
  def new
  end

  def create
    @repo = Repository.find_or_initialize_by_url(params[:repository].delete(:url))
    if @repo.update_attributes(params[:repository])
      redirect_to repository_path(@repo)
    else
      render :new
    end
  end

  def show
    @repo = Repository.find_by_name(params[:id])
    @analyzer = GitAnalyzer.new(@repo)
  end
end
