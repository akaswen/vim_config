require 'date'

module TmuxSessions
  class Sessions
    attr_accessor :sessions, :session_name

    def initialize(new_session_name)
      @sessions = `tmux ls`.split("\n")
      if @sessions.length > 0 && @sessions[0].include?(":")
        @sessions.map! do |session_string|
          Session.new(
                      name: session_string.split(":").first,
                      date: DateTime.parse(session_string.scan(/\(created (.*\d)\)/).first.first)
          )
        end
        @sessions.sort_by! { |ses| ses.date }.reverse!
      else
        @sessions = []
      end
      @sessions.unshift(Session.new(name: 'new session', date: nil))
      @sessions.push(Session.new(name: 'close', date: nil))
      @session_name = new_session_name
    end

    def create_popup
      Vim.command("call popup_clear()")
      current_width = 1
      @sessions.map(&:name).each_with_index do |name, i|
        highlight = 'Comment'
        highlight = 'Search' if name == @session_name
        Vim.command("call popup_create('#{name}', {'col': #{current_width}, 'line': 999, 'highlight': '#{highlight}'})")
        current_width += name.length + 2
      end
    end

    def increment_session_name
      index = @sessions.index { |ses| ses.name == @session_name }
      @session_name = @sessions[index + 1]&.name
      @session_name ||= @sessions[0].name
      Vim.command("let t:current_session = '#{@session_name}'")
    end
  end

  class Session
    attr_accessor :name, :date

    def initialize(name:, date:)
      @name = name
      @date = date
    end
  end
end
