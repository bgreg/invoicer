class Table
  def initialize(itemizer, rate)
    @itemizer = itemizer
    @rate     = rate
  end

  def line_items
    head = "\t+----------------------------------------------------------------------------------------------+\n"\
           "\t| DESCRIPTION                                       |    DATE    |  RATE  |  HOURS |  AMOUNT   |\n"\
           "\t+---------------------------------------------------+------------+--------+--------+-----------+"

    tail = "\t|  TOTAL                                            |            |        |        |  $#{total}|\n"\
           "\t+---------------------------------------------------+------------+--------+--------+-----------+"
    "#{head}\n#{@itemizer.rows.join("\n")}\n#{tail}"
  end

  def total
    (@itemizer.total_hours * @rate).round(2)
  end
end
