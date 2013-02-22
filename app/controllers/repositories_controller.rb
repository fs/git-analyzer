class RepositoriesController < ApplicationController
  def new
  end

  def create
    @repo = Repository.new(params[:repository])
    @analyzer = GitAnalyzer.new(@repo.url, @repo.time_zone, @repo.workday_start)
    @worktime = @analyzer.work2unwork
    @overtime = @analyzer.over2weekend
    render :show
  end
end
