class GitAnalyzer
  attr_reader :host, :owner, :repo

  def initialize(url)
    uri = URI url
    nodes = uri.path.split('/')
    @host = uri.host
    @owner = nodes[1]
    @repo = nodes[2]
    if Net::HTTP.new(@host).head("/#{@owner}/#{@repo}").code.to_i == 404
      raise 'Page is not found'
    end
  rescue
    'URL is invalid'
  end
end
