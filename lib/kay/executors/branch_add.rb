require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'

module Kay

  include Rest
  include UserContext
  include FileIO

  class BranchAdd

    def initialize(branch)
      @branch = branch
    end

    def run
      req = JSON.load(http_request('%s/%s' % [user_host, '/branch/'], 'POST', { :branch => @branch, :project_id => project_id }))
      if !req['error'].nil?
        raise req['error']
      end
    end

  end

end
