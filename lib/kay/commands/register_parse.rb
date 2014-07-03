require 'optparse'

require_relative '../util/struct'

module Kay

  class RegisterParse

    @@host_name = '--host <host_url>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: kay register [options]'

        opts.on(@@host_name, String, 'the kay host') do |name|
          options.host = name
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@host_name] if options[:host].nil?
    end

  end



end
