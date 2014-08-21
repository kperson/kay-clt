require 'optparse'

require_relative '../util/struct'

module Kay

  class ScaleParse

    @@branch = '--branch <branch>'
    @@app = '--app <app>'
    @@instances = '--instances <instances>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: kay register [options]'

        opts.on(@@branch, String, 'the branch name') do |name|
          options.branch = name
        end

        opts.on(@@app, String, 'the app name') do |name|
          options.app = name
        end

        opts.on(@@instances, OptionParser::DecimalInteger, 'the number of instances') do |instances|
          options.instances = instances
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@branch] if options[:branch].nil?
      raise '%s required' % [@@app] if options[:app].nil?
      raise '%s required' % [@@instances] if options[:instances].nil?
    end

  end



end
