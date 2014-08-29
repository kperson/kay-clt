require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'

module Kay

  include Rest
  include UserContext
  include FileIO

  class Docker

    def initialize(image, options, cmd, env, num_ports)
      @image = image
      @options = options
      @env = env
      @cmd = cmd
      @num_ports = num_ports
    end

    def run
      puts @num_ports
      deploy_command = {
        :cmd => @cmd,
        :container => { :image => 'docker:///' + @image, :options => @options },
        :mem => 512,
        :cpus => 1,
        :instances => 1,
        :executor => "",
        :uris => [],
        :env => @env,
        :ports => (0...@num_ports).map { |x| 0 }
      }
      body = JSON.generate(deploy_command)
      puts body
    end

  end

end
