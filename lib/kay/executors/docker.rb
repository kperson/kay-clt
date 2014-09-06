require 'json'

require_relative '../util/rest'
require_relative '../util/user_context'

module Kay

  include Rest
  include UserContext
  include FileIO

  class Docker

    def initialize(image, options, cmd, env, num_ports, name, id)
      @image = image
      @options = options
      @env = env
      @cmd = cmd
      @num_ports = num_ports
      @name = name
      @id = id
    end

    def run
      deploy_command = {
        :cmd => @cmd,
        :container => { :image => 'docker:///' + @image, :options => @options },
        :mem => 512,
        :cpus => 0.5,
        :instances => 1,
        :executor => "",
        :uris => [],
        :env => @env,
        :ports => (0...@num_ports).map { |x| 0 },
        :name => @name,
        :id => @id
      }
      body = JSON.generate(deploy_command)
      JSON.load(http_request('%s/docker/' % [user_host] , 'POST', { }, { }, body))
      puts 'deploying image: %s' % [@image]
    end

  end

end
