require_relative '../util/file_io'

module Kay

  class KeyAdd

    include FileIO

    def initialize(file)
      @file = file
    end

    def run
      ssh_file = File.expand_path(@file)
      if system('ssh-keygen -lf %s > /dev/null' % [ssh_file])
        key_contents = file_at(ssh_file)
        key_info = `ssh-keygen -lf #{ssh_file}`
        puts 'uploading key with fingerprint %s' % [key_info.split(' ')[1]]
      else
        raise '"%s" is not a valid public key' % [@file]
      end
    end

  end

end
