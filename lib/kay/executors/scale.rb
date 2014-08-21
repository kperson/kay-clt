require_relative '../util/rest'
require_relative '../util/user_context'

require 'json'

module Kay

  class Scale

    def initialize(branch, app, instances)
      @branch = branch
      @app = app
      @instances = instances
    end

    def run
      url = '%s/scale/' % [user_host]
      env_fetch = JSON.load(http_request(url, 'POST',  { 'project_id' => project_id, 'branch' => @branch, 'instances' => @instances, 'app' => @app }))
      if !env_fetch['error'].nil?
        raise env_fetch['error']
      end
    end

  end

end
