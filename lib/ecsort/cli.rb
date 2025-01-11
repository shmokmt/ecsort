require "json"
require "optparse"

module Ecsort
  class CLI
    def initialize
      @options = {}
      OptionParser.new do |opts|
        opts.banner = <<~BANNER
          Usage: ecsort [--recursive, -r] [target]
            --recursive, -r
                  Also process files in subdirectories. By default, only the given directroy (or current directroy) is processed.
        BANNER

        opts.on("-r", "--recursive", "Process directories recursively") do |r|
          @options[:recursive] = r
        end
      end.parse!

      @path = ARGV[0]
      @recursive = @options[:recursive] || false
    end

    def run
      @path = "." if @path.nil?

      if File.directory?(@path)
        process_directory(@path)
      elsif File.file?(@path)
        process_file(@path)
      else
        raise InvalidPathError
      end
    end

    def process_directory(directory_path)
      pattern = if directory_path == "."
                  "*.json"
                elsif @recursive
                  File.join(directory_path, "**", "*.json")
                else
                  File.join(directory_path, "*.json")
                end
      Dir.glob(pattern).each do |file|
        process_file(file)
      end
    end

    def process_file(file_path)
      file_content = File.read(file_path)
      sorted_content = Ecsort.sort_ecs_task_definition(file_content)
      File.write(file_path, sorted_content)
      puts file_path if file_content != sorted_content
    rescue JSON::ParserError
      puts "Skipping invalid JSON file: #{file_path}"
    rescue StandardError => e
      puts "Error processing file: #{file_path}, Error: #{e.message}"
    end
  end

  def self.sort_ecs_task_definition(json_input)
    ecs_task_definition = JSON.parse(json_input)

    if ecs_task_definition["containerDefinitions"]
      ecs_task_definition["containerDefinitions"].each do |container|
        if container["environment"]
          container["environment"] = container["environment"].sort_by { |entry| entry["name"] }
        end

        container["secrets"] = container["secrets"].sort_by { |entry| entry["name"] } if container["secrets"]
      end
    end

    JSON.pretty_generate(ecs_task_definition)
  end
end
