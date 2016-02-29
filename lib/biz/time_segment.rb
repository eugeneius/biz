module Biz
  class TimeSegment

    include Comparable

    def self.before(time)
      new(Time.big_bang, time)
    end

    def self.after(time)
      new(time, Time.heat_death)
    end

    def initialize(start_time, end_time)
      @start_time = start_time
      @end_time   = end_time
    end

    attr_reader :start_time,
                :end_time

    def duration
      Duration.new(end_time - start_time)
    end

    def endpoints
      [start_time, end_time]
    end

    def empty?
      start_time >= end_time
    end

    def contains?(time)
      (start_time..end_time).cover?(time)
    end

    def &(other)
      self.class.new(
        lower_bound(other),
        [lower_bound(other), upper_bound(other)].max
      )
    end

    def <=>(other)
      return unless other.is_a?(self.class)

      [start_time, end_time] <=> [other.start_time, other.end_time]
    end

    private

    def lower_bound(other)
      [self, other].map(&:start_time).max
    end

    def upper_bound(other)
      [self, other].map(&:end_time).min
    end

  end
end
