# -*- coding: utf-8 -*-

# Gemfile.lock から OSS 名と version を記載した csv を吐き出す
def main(file_path)

  # Gemfile.lock 以外は受け付けない
  if file_path.nil? or (not file_path.include?('Gemfile.lock'))
    puts 'ERROR: Input illegal file path.'
    puts 'ERROR: Set path of Gemlfile.lock'
    return 1
  end

  csv_data = []
  b_gemlist_start = false

  File.open(file_path, mode = 'rt') do |gemfile_lock|
    gemfile_lock.each_line do |line|
      line_str = line.chomp
      if line_str.chomp == 'GEM'
        b_gemlist_start = true
        next
      end

      if b_gemlist_start
        if line_str.empty?
          break
        end

        if line_str.match?(/^ {4}[a-zA-z]+/)
          oss_name = line_str.slice(/ .* /).strip
          version = line_str.slice(/\(.*\)/).delete('(').delete(')')
          csv_data.push("#{oss_name},#{version}")
        end
      end
    end
  end

  File.open("result.csv", mode = "w") do |csv_file|
    csv_data.each do |csv_line|
      csv_file.write("#{csv_line}\n")
    end
  end

  puts 'Finish output csv!!'
end

if __FILE__ == $0
  main(ARGV[0])
end

