require 'json'

require_relative '../util/rest'

module Kay

  include Rest

  class Create

    def initialize(name)
      @name = name
    end

    def run
      req = JSON.load(http_request('%s/%s' % [base_url, '/project/'], 'POST', { :name => @name }))
      if !req['error'].nil?
        raise req['error']
      else
        add_to_project(req['response']['git_url'])
      end
    end

    def add_to_project(git_url)
      command = 'git remote add kay %s' % [git_url]
      system command
    end

    def base_url
      "http://192.168.59.103:49152"
    end

  end

end
