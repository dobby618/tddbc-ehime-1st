class ClosedSection
  attr_reader :lower, :upper

  def initialize(lower:, upper:)
    raise ("下端点は上端点より小さくしてください") if lower > upper 
    @lower = lower
    @upper = upper
  end

  def to_s
    "[#{@lower},#{@upper}]"
  end

  def between?(number:)
    number.between?(@lower, @upper)
  end

  def equal?(closed_section:)
    closed_section.lower == self.lower && closed_section.upper == self.upper
  end

  def include?(closed_section:)
    between?(number: closed_section.lower) && between?(number: closed_section.upper)
  end
end