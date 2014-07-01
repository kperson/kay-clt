require 'optparse'

require_relative '../util/struct'

module Kay

  class CreateParse

    @@project_name = '--name <project_name>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: kay create [options]'

        opts.on(@@project_name, String, 'name of project') do |name|
          options.name = name
        end


      end

      opt_parser.parse!(args)

      self.validate(options)

      options

    end

    def self.validate(options)
      raise '%s required' % [@@project_name] if options[:name].nil?
    end

  end



end
