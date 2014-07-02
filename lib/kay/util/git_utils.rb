require 'fileutils'

require_relative 'file_io'

module GitUtils

  include FileIO

  # Returns if the current directory is a git repo
  #
  # @return [Fixnum] whether this directory is a git repo
  def is_git_repo
    system 'git rev-parse'
  end

  #Raises an error if the current directory is not a git repo
  def check_for_git_repo
    raise 'this is not a valid git repo' if !is_git_repo
  end


  def prepare_git_ignore
    contents = File.exists?('.gitignore') ? file_at('.gitignore') : ''
    if !contents.split("\n").include?('.kay')
      git_contents = contents + "\n.kay"
      write_file_at('.gitignore', git_contents)
    end
  end

end
