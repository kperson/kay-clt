require 'optparse'

require_relative '../util/struct'

module Kay

  class BranchAddParse

    @@branch = '--branch <branch>'

    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = 'Usage: kay branch-add [options]'

        opts.on(@@branch, String, 'name of branch') do |name|
          options.branch = name
        end


      end

      opt_parser.parse!(args)
      self.validate(options)

      options

    end

    def self.validate(options)
      raise '%s required' % [@@branch] if options[:branch].nil?
    end

  end



end
