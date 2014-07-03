require 'optparse'

require_relative '../util/struct'

module Kay

  class KeyAddParse

    @@file = '--file <ssh_file>'
    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = "Usage: kay key-add [options]\n('kay key-add --file ~/.ssh/id_rsa.pub' is probobly what you want if you have git already setup)"

        opts.on(@@file, String, 'the ssh key') do |name|
          options.file = name
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@file] if options[:file].nil?
    end

  end

end
