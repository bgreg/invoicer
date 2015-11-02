class Row < Struct.new(:description, :date, :hours, :rate)
  def to_a
    [wrap(description), date, rate, hours, total]
  end

  private

  def total
    (rate * hours).round(2)
  end

  def wrap(string)
    string.scan(/.{1,50}/).join("\n")
  end
end
