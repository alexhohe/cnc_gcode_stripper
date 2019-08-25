def conatins_unwanted_gcode?(line)
  contains_return_to_home_position?(line) ||
  contains_tool_change?(line)
end

def contains_return_to_home_position?(line)
  line.match?(/\AG28\s/)
end

def contains_tool_change?(line)
  line.match?(/\AT\d+\sM/)
end

def clean_file(input_path)
  output_path = "cleaned.#{input_path}"
  dropped_line_count = 0

  puts '---'
  puts "Cleaning File: #{input_path}"

  File.open(output_path, "w") do |output_file|  
    File.foreach(input_path).with_index do |line, line_number|
      if conatins_unwanted_gcode?(line)
        puts "Dropping line ##{line_number}: #{line}"
        dropped_line_count += 1
        next
      else
        output_file.write(line)  
      end
    end
  end

  puts "Completed with #{dropped_line_count} lines removed"
  puts "Wrote File: #{output_path}"
end

def clean_current_directory
  puts "Cleaning current directory, reading *.nc"
  Dir.glob('*.nc') do |filename|
    # Do process our own output files
    next if filename.start_with?('cleaned.')
    # Do not overwrite existing output files
    if File.exists?("cleaned.#{filename}")
      puts "Skipping #{filename} because it's output already exists."
      next
    end

    clean_file(filename)
  end
end

if ARGV.length > 0
  clean_file(ARGV[0])
else
  puts 'Called without arguments, processing all files in current directory.'
  clean_current_directory
end
