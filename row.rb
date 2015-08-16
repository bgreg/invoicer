class Row < Struct.new(:description, :date, :hours)
  attr_accessor :rate

  def to_s
    string = ""
    if line_count <= 1
      string = "\t| #{ description + (" " * (49 - description.length).abs) } | #{ date } |  #{ rate }   |  #{ hours.round(2) }  |  #{ total }    |"
    else
      lines.first(lines.size - 1).each do |line|
        string <<  "\t| #{ line + (" " * (49 - line.length).abs) }#{blank_row}\n"
      end
      string << "\t| #{ lines.last + (" " * (49 - lines.last.length).abs) } | #{ date } |  #{ rate }   | #{ hours.round(2) }    |  #{ total }    |"
    end

    "#{string}\n#{end_line}"
  end

  private

  def line_count
    lines.count
  end

  def lines
    @lines ||= description.chars.each_slice(48).map(&:join)
  end

  def total
    (rate * hours).round(2)
  end

  def blank_row
    " |            |        |        |           |"
  end

  def end_line
    "\t+---------------------------------------------------+------------+--------+--------+-----------+"
  end
end

