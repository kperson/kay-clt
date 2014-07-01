require 'ostruct'

module Kay

  def base_struct
    options = OpenStruct.new
    options.library = []
    options.inplace = false
    options.encoding = 'utf8'
    options.transfer_type = :auto
    options.verbose = false
    options
  end

end
