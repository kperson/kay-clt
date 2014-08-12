require 'optparse'

require_relative '../util/struct'

module Kay

  class EnvAddParse

    @@branch = '--branch <project_name>'
    @@keys = '--keys <keys>'
    @@values = '--values <values>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: kay env-add [options]'

        opts.on(@@branch, String, 'name of branch') do |branch|
          options.branch = branch
        end

        opts.on(@@keys, Array, 'keys for env') do |keys|
          options.keys = keys
        end

        opts.on(@@values, Array, 'values for env') do |values|
         options.values = values
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)

      raise '%s required' % [@@branch] if options[:branch].nil?
      raise '%s required' % [@@keys] if options[:keys].nil?
      raise '%s required' % [@@values] if options[:values].nil?
    end

  end



end
