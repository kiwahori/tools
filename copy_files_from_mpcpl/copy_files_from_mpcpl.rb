require "fileutils"

# Constant Variables
OUTPUT_DIR = "_output"

def main(args)
  # Check input arguments
  if args.size == 0
    puts "Error: Please set mpcpl file name"
    return 1
  end

  mpcpl_file = args[0]
  file_list = []

  # Input all file paths
  File.open(mpcpl_file, "r") do |mpcpl_data|
    mpcpl_data.each_line do |mpcpl_line|
      if mpcpl_line.include?(",filename,")
        if mpcpl_line.split(",").size == 3
          file_list.push(mpcpl_line.split(",").last.chomp)
        else
          mpcpl_line_array = mpcpl_line.split(",")
          mpcpl_line_array.slice!(0,2)
          file_list.push(mpcpl_line_array.join(',').chomp)
        end
      end
    end
  end

  # Copy files
  file_list.each do |file_path_src|
    puts "Copying file path: #{file_path_src}"
    FileUtils.cp(file_path_src, OUTPUT_DIR)
  end

  puts "Copied complete!!"
end

main(ARGV)
