require 'json'
require 'fileutils'

require_relative '../util/rest'
require_relative '../util/file_io'
require_relative '../util/git_utils'
require_relative '../util/user_context'

module Kay

  include Rest
  include FileIO
  include GitUtils
  include UserContext

  class Register

    def initialize(host)
      @host = host
    end

    def print_prompt(message)
      prompt = '> '
      puts message
      print prompt
    end

    def validate
      check_for_git_repo
      prepare_git_ignore
    end

    def run
      validate
      print_prompt 'Username:'
      user_name = STDIN.gets.chomp()

      begin
        `stty -echo`
        print_prompt 'Password:'
        password = STDIN.gets.chomp()
      ensure
        `stty echo`
        puts ""
      end

      begin
        `stty -echo`
        print_prompt 'Confirm Password:'
        confirm_password = STDIN.gets.chomp()
      ensure
        `stty echo`
         puts ""
      end
      if password == confirm_password
        register_user(user_name, password)
      else
        raise 'passwords do not match'
      end
    end

    def register_user(user_name, password)
      req = JSON.load(http_request(File.join(@host, '/user/'), 'POST', { 'user_name' => user_name, 'password' => password }))
      if !req['error'].nil?
        raise req['error']
      else
        data = user_context
        data[:host] = @host
        data[:token] = req['response']['token']
        write_file_at('.kay', JSON.generate(data))
      end
    end

  end

end
