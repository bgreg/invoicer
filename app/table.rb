require 'terminal-table'

class Table
  HEADING = %w{ DESCRIPTION DATE RATE HOURS AMOUNT }

  def self.build_table(itemizer, rate)
    new(itemizer, rate).generate
  end

  def initialize(itemizer, rate)
    @itemizer = itemizer
    @rate     = rate
  end

  def generate
   Terminal::Table.new(
      headings: HEADING,
      rows:     build_rows,
      style:    {width: 120})
  end

  private

  def build_rows
    @itemizer.rows << total
  end

  def total
    ["TOTAL", nil, nil, nil, "#{(@itemizer.total_hours * @rate).round(2)}"]
  end
end
