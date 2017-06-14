#require 'date'

module GetReal
  class Ready
    @dir = "tmp"
    @filename = "#{@dir}/page_#{DateTime.now.strftime('%Y%m%d%H%M%S')}"

    def self.filename
      Dir.mkdir @dir unless Dir.exist? @dir
      #del_old_file
      @filename
    end

    def self.del_old_file
      File.delete "#{@dir}/*"
    end
  end
end
