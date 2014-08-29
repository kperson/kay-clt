require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'
require_relative '../util/file_io'

module Kay

  include Rest
  include UserContext
  include FileIO

  class Create

    def initialize(name)
      @name = name
    end

    def run
      req = JSON.load(http_request('%s/%s' % [user_host, '/project/'], 'POST', { :name => @name }))
      if !req['error'].nil?
        raise req['error']
      else
        add_to_project(req['response']['git_url'])
        data = user_context
        raise 'please register or login' if user_token.nil? || user_host.nil?
        data['project_id'] = req['response']['project_id']
        write_file_at('.kay', JSON.generate(data))
      end
    end

    def add_to_project(git_url)
      if has_git_remote('kay')
        system 'git remote remove kay'
      end
      command = 'git remote add kay %s' % [git_url]
      system command
      puts 'Remote added'
    end

  end

end
