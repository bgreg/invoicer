require 'terminal-table'

class Table
  HEADING = %w{ DESCRIPTION DATE RATE HOURS AMOUNT }
  STYLE = { width: 120 }

  def self.build_table(line_items, rate)
    new(line_items, rate).generate
  end

  def initialize(line_items, rate)
    @line_items = line_items
    @rate       = rate
  end

  def generate
   Terminal::Table.new(
      headings: HEADING,
      rows:     build_rows,
      style:    STYLE)
  end

  private

  def build_rows
    @line_items.rows << total
  end

  def total
    ["TOTAL", nil, nil, nil, "#{(@line_items.total_hours * @rate).round(2)}"]
  end
end
