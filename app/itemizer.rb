class Itemizer
  attr_reader :items, :rows

  def initialize(rate)
    @rate  = rate or fail("Please set rate so rows can be calculated")
    @hours = []
    @rows  = []
  end

  def total_hours
    @hours.inject(:+)
  end

  def add_row(row)
    row.rate = @rate
    @hours << row.hours
    @rows << row.to_a
    @rows << :separator
  end
end
