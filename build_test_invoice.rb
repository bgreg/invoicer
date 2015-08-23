require_relative "invoicer"
require_relative "itemizer"
require_relative "row"
require_relative "personal_info"
require_relative "make_invoice"

class MakeInvoice
  def test
    rows = []
    rows << Row.new("Test1", "01/01/2014", 9999)
    rows << Row.new("Test2", "01/01/2014", 9999)
    rows << Row.new("Test3", "01/01/2014", 9999)
    make(rows)
  end
end

MakeInvoice.new.test
