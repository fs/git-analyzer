class GitAnalyzer

  WEEKEND = { saturday: 6, sunday: 0 }

  def initialize url, time_zone, workday_start
    uri = URI url
    nodes = uri.path.split '/'
    @host = uri.host
    @owner = nodes[1]
    @repo = nodes[2]
    @time_zone = time_zone
    @workday_start = workday_start
    if Net::HTTP.new(@host).head("/#{@owner}/#{@repo}").code.to_i == 404
      raise 'Page is not found'
    end
    @gs = Ghee.access_token 'dc7d9f2ca0a00a453fba36e75c07c22a45359932'
  rescue
    'URL is invalid'
  end

  def work2unwork
    [worktime_commits.count, unworktime_commits.count]
  end

  def over2weekend
    [overtime_commits.count, weekend_commits.count]
  end

  private

  def commits
    @commits ||= @gs.repos(@owner, @repo).commits
  end

  def date_for commit
    commit.commit.author.date.to_time
  end

  def worktime_commits
    commits.select do |commit|
      date = date_for commit
      date.hour < 20 && WEEKEND.values.exclude?(date.wday)
    end
  end

  def unworktime_commits
    commits.reject do |commit|
      date = date_for commit
      date.hour < 20 && WEEKEND.values.exclude?(date.wday)
    end
  end

  def weekend_commits
    unworktime_commits.select do |commit|
      date = date_for commit
      WEEKEND.values.include? date.wday
    end
  end

  def overtime_commits
    unworktime_commits - weekend_commits
  end
end
