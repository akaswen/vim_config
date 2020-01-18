require 'date'

module TmuxSessions
  class Sessions
    attr_accessor :sessions

    def initialize
      @sessions = `tmux ls`.split("\n")
      if @sessions.length > 1 || @sessions[0].include?(":")
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
