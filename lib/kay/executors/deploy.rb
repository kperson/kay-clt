require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'

module Kay

  include Rest
  include UserContext

  class Deploy

    def initialize(branch, version)
      @branch = branch
      @version = version
    end

    def run
      req = JSON.load(http_request('%s/%s' % [user_host, '/deploy/'], 'POST', { :version => @version, :branch => @branch, :project_id => project_id }))
      if !req['error'].nil?
        raise req['error']
      else
        puts 'deploying %s of %s' % [@version, project_id]
      end
    end

  end

end
