require_relative "../app/invoicer"
require_relative "../app/line_items"
require_relative "../app/row"
require_relative "../app/make_invoice"

class MakeInvoice

  def test
    rows = []
    rows << Row.new("LongLine"*80, "01/01/2014", 9999, 10)
    rows << Row.new("Test2", "01/01/2014", 9999, 10)
    rows << Row.new("Test3", "01/01/2014", 9999, 10)
    make(rows, 0)
  end
end

MakeInvoice.new.test
