class GitAnalyzer

  WEEKEND = { saturday: 6, sunday: 0 }

  def initialize(url, time_zone, workday_start)
    uri = URI url
    nodes = uri.path.split('/')
    @host = uri.host
    @owner = nodes[1]
    @repo = nodes[2]
    @time_zone = time_zone
    @workday_start = workday_start
    if Net::HTTP.new(@host).head("/#{@owner}/#{@repo}").code.to_i == 404
      raise 'Page is not found'
    end
    @gs = Ghee.basic_auth 'login', 'password'
  rescue
    'URL is invalid'
  end

  def worktime_commits
    commits = gs.repos(@owner, @repo).commits
    worktime_commits = commits.select do |commit|
      date = commit.commit.author.date.to_time
      date.hour < 20 && WEEKEND.values.exclude?(date.wday)
    end
    unworktime_commits = commits - worktime_commits
    [worktime_commits.count, unworktime_commits.count]
  end

  def unworktime_commits
    commits = gs.repos(@owner, @repo).commits
    unworktime_commits = commits.reject do |commit|
      date = commit.commit.author.date.to_time
      date.hour < 20 && WEEKEND.values.exclude?(date.wday)
    end
    weekend_commits = unworktime_commits do |commit|
      date = commit.commit.author.date.to_time
      WEEKEND.values.include? date.wday
    end
    overtime_commits = unworktime_commits - weekend_commits
    [overtime_commits.count, unworktime_commits.count]
  end
end
