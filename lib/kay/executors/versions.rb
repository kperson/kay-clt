require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'

module Kay

  include Rest
  include UserContext

  class Versions

    def initialize(branch)
      @branch = branch
    end

    def run
      versions_url = '%s/versions/%s/%s/' % [user_host, project_id, @branch]
      req = JSON.load(http_request(versions_url, 'GET', { }))
      if !req['error'].nil?
        raise req['error']
      else
        current_version = req['response']['current_version']
        versions = req['response']['versions']
        puts "current version: %s" % [current_version]
        puts "versions: \n%s" % [versions.join("\n")]
      end
    end

  end

end
