require 'json'

module JsonManipulator
  class Manipulator
    def initialize(string)
      @json_string = string.strip.gsub('\"', '"')

      if @json_string[0] == @json_string[-1] && ['"', "'"].include?(@json_string[0])
        @json_string = @json_string[1..-2]
      end

      begin
        @json_string = JSON(@json_string)
      rescue
        @json_string = string
      end

      @indentation = Vim.evaluate('indent(line("."))')
    end

    def pretty_print(input: @json_string)
      pretty_print_hash(input: input) if input.is_a?(Hash)
      pretty_print_array(input: input) if input.is_a?(Array)
      write_out(input) if input.is_a?(String)
    end

    def pretty_print_array(input: @json_string, last_key: false)
      return unless input

      open_array
      input.each do |value|
        if value == input[-1]
          pretty_print_array(input: value, last_key: true) if value.is_a?(Array)
          pretty_print_hash(input: value, last_key: true) if value.is_a?(Hash)
          if value.is_a?(String)
            (@indentation * 2).times { value.insert(0, " ")}
            write_out(value)
          end
        else
          pretty_print_array(input: value) if value.is_a?(Array)
          pretty_print_hash(input: value) if value.is_a?(Hash)
          if value.is_a?(String)
            (@indentation * 2).times { value.insert(0, " ")}
            write_out(value + ",")
          end
        end

        new_line
      end
      close_array(last_key)
    end

    def open_array
      write_out("[")
      new_line
      @indentation += 1
    end

    def close_array(last_key)
      @indentation -= 1
      last_key ? end_hash = "]" : end_hash = "],"
      (@indentation * 2).times { end_hash.insert(0, " ")}
      write_out(end_hash)
    end

    def pretty_print_hash(input: @json_string, last_key: false)
      return unless input

      open_hash
      keys = input.keys
      keys.each do |key|
        write_key(key)
        value = input[key]
        key == keys[-1] ? write_value_no_comma(value) : write_value_with_comma(value)
        new_line
      end

      close_hash(last_key)
    end

    def write_value_with_comma(value)
      write_out(value + ",") if value.is_a?(String)
      pretty_print_array(input: value) if value.is_a?(Array)
      pretty_print_hash(input: value) if value.is_a?(Hash)
    end

    def write_value_no_comma(value)
      write_out(value) if value.is_a?(String)
      pretty_print_array(input: value, last_key: true) if value.is_a?(Array)
      pretty_print_hash(input: value, last_key: true) if value.is_a?(Hash)
    end

    def write_key(key)
      written_key = "\"#{key}\": "
      (@indentation * 2).times { written_key.insert(0, " ")}
      write_out(written_key)
    end

    def open_hash
      current_line = Vim.evaluate('getline(line("."))')
      open_hash = "{"
      if current_line.length == 0
        (@indentation * 2).times { open_hash.insert(0, " ")}
      end
      write_out(open_hash)
      new_line
      @indentation += 1
    end

    def close_hash(last_key)
      @indentation -= 1
      last_key ? end_hash = "}" : end_hash = "},"
      (@indentation * 2).times { end_hash.insert(0, " ")}
      write_out(end_hash)
    end

    private

      def write_out(string)
        command = "normal! a#{string}"
        Vim.command(command)
      end

      def new_line
        command = 'call append(line("."), "")'
        Vim.command(command)
        command = "normal! j0"
        Vim.command(command)
      end
  end
end

