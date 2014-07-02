require 'json'

require_relative 'file_io'

module UserContext

  include FileIO

  def user_token
    vars = JSON.load(file_at('.kay'))
    vars['token']
  end

  def user_host
    vars = JSON.load(file_at('.kay'))
    vars['host']
  end

end
