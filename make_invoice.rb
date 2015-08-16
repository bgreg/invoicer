require_relative "invoicer"
require_relative "itemizer"
require_relative "row"
require_relative 'personal_info'

class MakeInvoice

  def make
    itemizer = Itemizer.new(PersonalInfo::RATE)
    itemizer.add_row(
      Row.new("Meeting with JOEL for update, group review of tracker.js source code half day, and half day troubleshooting CORS in firefox.", "08/09/2015", 7.57)
    ) 

    invoice_number = next_invoice_number 

    File.write(
      "unpaid/invoice_#{invoice_number}.txt",
      Invoicer.new(invoice_number, PersonalInfo::RATE, itemizer).invoice
    )

    increment_invoice_record(invoice_number)
  end

  private

  def next_invoice_number
    File.read("last_invoice.txt").chomp.to_i + 1
  end

  def increment_invoice_record(number)
    File.write("last_invoice.txt", number)
  end
end

MakeInvoice.new.make
