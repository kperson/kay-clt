require 'optparse'

require_relative '../util/struct'

module Kay

  class KeyAddParse

    @@file = '--file <ssh_file>'
    @@name = '--name <name>'
    def self.parse(args)
      options = base_struct
      opt_parser = OptionParser.new do |opts|

        opts.banner = "Usage: kay key-add [options]\n('kay key-add --file ~/.ssh/id_rsa.pub --name macbook' is probobly what you want if you have ssh already setup)"

        opts.on(@@file, String, 'the ssh key') do |name|
          options.file = name
        end

        opts.on(@@name, String, 'the name of the key') do |name|
          options.name = name
        end

      end

      opt_parser.parse!(args)
      self.validate(options)
      options
    end

    def self.validate(options)
      raise '%s required' % [@@file] if options[:file].nil?
      raise '%s required' % [@@name] if options[:name].nil?
    end

  end

end
