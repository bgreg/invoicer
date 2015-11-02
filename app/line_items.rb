#
# This will hold a collection of row objects, and perform
# calculations ass they are added.
#
class LineItems
  attr_reader :items, :rows

  def initialize
    @hours = []
    @rows  = []
  end

  def total_hours
    @hours.inject(:+)
  end

  def add_row(row)
    @hours << row.hours
    @rows << row.to_a
    @rows << :separator
  end
end
