# This class will generate the header and footer of the invoice.
# It accepts an LineItem object that can be used to build the
# line items table as well as tracks the current invoice number.
#
# If further formatting is required, extract the current methods into a
# text formatted. This will also allow for an HTML formatter to be built.
#
require 'date'
require_relative 'table'

class Invoicer

  def initialize(num, rate, line_items)
    @invoice_number = num
    @table          = Table.build_table(line_items, rate)
  end

  def invoice
    "#{header}\n"\
    "#{bill_to}\n"\
    "\n"\
    "#{@table}\n"\
    "\n"\
    "#{footer}\n"\
    "Thank You\n"
  end

  private

  def header
    "\n\n"\
    "Invoice: #{@invoice_number}\n"\
    "Date:    #{Date.today}\n"\
    "Due:     Upon Receipt"
  end

  def bill_to
    "Bill To: #{@client_data[:bill_to][0]}\n"\
    "         #{@client_data[:bill_to][1]}\n"\
    "         #{@client_data[:bill_to][2]}"
  end

  def footer
    "Make checks payable to:\n"\
    "   #{@client_data[:payable_to]}\n\n"\
    "Mail to: \n"\
    "   #{@client_data[:mail_to][0]}\n"\
    "   #{@client_data[:mail_to][1]}\n"
  end
end
