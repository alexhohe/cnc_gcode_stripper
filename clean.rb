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

if ARGV.length < 1
  puts "You must supply a file path"
  exit
end

clean_file(ARGV[0])
