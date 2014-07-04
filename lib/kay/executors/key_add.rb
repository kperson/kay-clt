require_relative '../util/file_io'
require_relative '../util/rest'
require_relative '../util/user_context'

module Kay

  class KeyAdd

    include FileIO
    include Rest
    include UserContext

    def initialize(file, key_name)
      @key_name = key_name
      @file = file
    end

    def run
      ssh_file = File.expand_path(@file)
      if system('ssh-keygen -lf %s > /dev/null' % [ssh_file])
        key_contents = file_at(ssh_file)
        key_info = `ssh-keygen -lf #{ssh_file}`
        puts 'uploading key with fingerprint %s' % [key_info.split(' ')[1]]
        req = JSON.load(http_request(File.join(user_host, '/key/'), 'POST', { 'token' => user_token, 'key' => key_contents, 'key_name' => @key_name }))
        raise req['error'] if !req['error'].nil?
      else
        raise '"%s" is not a valid public key' % [@file]
      end
    end

  end

end
