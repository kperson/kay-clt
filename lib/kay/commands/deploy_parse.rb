require 'optparse'

require_relative '../util/struct'

module Kay

  class DeployParse

    @@branch = '--branch <branch>'
    @@version = '--version <version>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: kay deploy [options]'

        opts.on(@@branch, String, 'name of branch') do |branch|
          options.branch = branch
        end

        opts.on(@@version, String, 'version to deploy') do |version|
          options.version = version
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@branch] if options[:branch].nil?
      raise '%s required' % [@@version] if options[:version].nil?
    end

  end



end
