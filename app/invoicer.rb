# This class will generate the header and footer of the invoice.
# It accepts an LineItem object that can be used to build the
# line items table as well as tracks the current invoice number.
#
# If further formatting is required, extract the current methods into a
# text formatted. This will also allow for an HTML formatter to be built.
#
require 'date'
require_relative '../personal_info'
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
    "Bill To: #{PersonalInfo::BILL_TO[0]}\n"\
    "         #{PersonalInfo::BILL_TO[1]}\n"\
    "         #{PersonalInfo::BILL_TO[2]}"
  end

  def footer
    "Make checks payable to:\n"\
    "   #{PersonalInfo::PAYABLE_TO}\n\n"\
    "Mail to: \n"\
    "   #{PersonalInfo::MAIL_TO[0]}\n"\
    "   #{PersonalInfo::MAIL_TO[1]}\n"
  end
end
