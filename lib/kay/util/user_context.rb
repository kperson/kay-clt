require 'json'
require 'fileutils'

require_relative 'file_io'

module UserContext

  include FileIO

  def user_context
    File.exist?('.kay') ? JSON.load(file_at('.kay')) : { }
  end

  def user_token
    user_context['token']
  end

  def user_host
    user_context['host']
  end

  def project_id
    user_context['project_id']
  end

end
