module Kay

  class DockerParse

    @@image = '--image <image>'
    @@opts = '--opts <opts>'
    @@env_keys = '--env_keys <env_keys>'
    @@env_values = '--env_values <env_values>'
    @@cmd = '--cmd <command>'
    @@num_ports = '--num_ports <num_ports>'

    def self.parse(args)

      options = base_struct
      opt_parser = OptionParser.new do |opts|
        opts.banner = 'Usage: kay docker [options]'

        opts.on(@@image, String, 'name of image (required)') do |image|
          options.image = image
        end

        opts.on(@@opts, Array, 'marathon options') do |opts|
          options.opts = opts
        end

        opts.on(@@cmd, String, 'command to run') do |cmd|
          options.cmd = cmd
        end

        opts.on(@@env_keys, Array, 'env keys') do |keys|
          options.env_keys = keys
        end

        opts.on(@@env_values, Array, 'env values') do |values|
          options.env_values = values
        end

        opts.on(@@num_ports, OptionParser::DecimalInteger, 'the number of ports to allocate') do |num_ports|
          options.num_ports = num_ports
        end

      end

      opt_parser.parse!(args)
      self.cleanse(options)
      self.validate(options)

      kv_array = options.env_keys.zip(options.env_values)
      env_hash = { }
      kv_array.each{ |x| env_hash[x[0]] = x[1] }
      options.env = env_hash
      options
    end


    def self.validate(options)
      raise 'env_keys and env_values must be the same length' if options.env_keys.length != options.env_values.length
    end

    def self.cleanse(options)
      if !options.opts
        options.opts = []
      end
      if !options.env_keys
        options.env_keys = []
      end
      if !options.env_values
        options.env_values = []
      end

      if !options.num_ports
        options.num_ports = 0
      end

      if !options.cmd
        options.cmd = ""
      end

    end

  end

end
