require_relative '../util/rest'
require_relative '../util/user_context'

require 'json'

module Kay

  class EnvAdd

    def initialize(branch, options)
      @branch = branch
      @options = options
    end

    def run
      if @options.keys.length != @options.values.length
        raise 'keys and values must be the same length'
      else
        url = '%s/env/%s/%s/' % [user_host, project_id, @branch]
        env_fetch = JSON.load(http_request(url, 'GET'))
        if !env_fetch['error'].nil?
          raise env_fetch['error']
        end
        kv_array = @options.keys.zip(@options.values)
        kv_hash = env_fetch['response']
        kv_array.each{ |x| kv_hash[x[0]] = x[1] }

        env_fetch = JSON.load(http_request('%s/env/' % [user_host] , 'POST', { 'project_id' => project_id, 'branch' => @branch }, { }, JSON.generate(kv_hash)))
      end
    end

  end

end
