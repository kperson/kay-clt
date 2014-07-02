require 'json'

require_relative '../util/rest'

module Kay

  include Rest

  class Register

    def initialize(host)
      @host = host
    end

    def print_prompt(message)
      prompt = '> '
      puts message
      print prompt
    end

    def run

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
      end
    end

  end

end
