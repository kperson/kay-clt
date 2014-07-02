require 'fileutils'

module FileIO

  # Reads the contents of file
	#
	# @param file [String] the file location
	# @return [String] the file contents
	def file_at(file)
    path = File.open(file, "rb")
    contents = path.read
    path.close
    contents
	end

  # Writes the contents of a file
  #
  # @param file [String] the file location
  # @param content [String] the desired file contents
	def write_file_at(file, content)
		FileUtils.mkdir_p(File.dirname(file))
		File.open(file, 'w') do |file|
			file.write(content)
		end
	end

  # Deletes a file
  #
  # @param file [String] the file location
  def delete_file_at(file)
    if File.exist?(file)
      File.delete(file)
    end
  end

end
