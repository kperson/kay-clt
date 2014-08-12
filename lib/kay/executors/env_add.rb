module Kay

  class EnvAdd

    def initialize(branch, options)
      @branch = branch
      @options = options
    end

    def run
      if @options.keys.length != @options.values.length
        raise 'keys and values must be the same length'
      else
        kv_array = @options.keys.zip(@options.values)
        kv_hash = { }
        kv_array.each{ |x| kv_hash[x[0]] = x[1] }
        puts kv_hash
      end
    end

  end

end
