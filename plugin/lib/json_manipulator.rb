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
        @json_string = nil
      end
      @indentation = Vim.evaluate('indent(line("."))')
    end

    def pretty_print(input: @json_string)
      pretty_print_hash(input: input) if input.is_a?(Hash)
    end

    def pretty_print_hash(input: @json_string, last_key: false)
      return unless input

      write_out("{")
      new_line
      @indentation += 1

      keys = input.keys

      keys.each do |key|
        written_key = "\"#{key}\": "
        (@indentation * 2).times { written_key.insert(0, " ")}
        write_out(written_key)

        value = input[key]
        if key == keys[-1]
          write_out(value) if value.is_a?(String)
          write_out(value.inspect) if value.is_a?(Array)
          pretty_print_hash(input: value, last_key: true) if value.is_a?(Hash)
        else
          write_out(value + ",") if value.is_a?(String)
          write_out(value.inspect + ",") if value.is_a?(Array)
          pretty_print_hash(input: value) if value.is_a?(Hash)
        end
        new_line
      end

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

