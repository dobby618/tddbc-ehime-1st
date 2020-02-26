class ClosedSection
  attr_reader :lower, :upper

  def initialize(lower:, upper:)
    # エラーメッセージに引数値（具体値）を入れてあげると親切かも。
    raise ("下端点(#{lower})は上端点(#{upper})より小さくしてください") if lower > upper 
    @lower = lower
    @upper = upper
  end

  def to_s
    "[#{@lower},#{@upper}]"
  end

  # メソッド名は Ruby の組込みクラスを参考にすると良い。その言語らしさもでる。
  # 今回は Range を参考に cover?, members? とかの方が良かった。
  def between?(number:)
    number.between?(@lower, @upper)
  end

  def equal?(closed_section:)
    closed_section.lower == self.lower && closed_section.upper == self.upper
  end

  def include?(closed_section:)
    between?(number: closed_section.lower) && between?(number: closed_section.upper)
  end

  alias_method :==, :equal? # 等価は普通 == を使うので、どちらでも使えると良い（使いやすさ重視）
end