require 'date'
require_relative '../personal_info'
require_relative 'table'

class Invoicer

  def initialize(num, rate, itemizer)
    @invoice_number = num
    @table          = Table.new(itemizer, rate)
  end

  def invoice
    "#{header}\n"\
    "#{bill_to}\n"\
    "\n"\
    "#{@table.line_items}\n"\
    "\n"\
    "#{footer}\n"\
    "\tThank You\n"
  end

  private

  def header
    "\n\n"\
    "\tInvoice: #{@invoice_number}\n"\
    "\tDate:    #{Date.today}\n"\
    "\tDue:     Upon Receipt"
  end

  def bill_to
    "\tBill To: #{PersonalInfo::BILL_TO[0]}\n"\
    "\t         #{PersonalInfo::BILL_TO[1]}\n"\
    "\t         #{PersonalInfo::BILL_TO[2]}"
  end

  def footer
    "\t Make checks payable to:\n"\
    "\t   #{PersonalInfo::PAYABLE_TO}\n\n"\
    "\t Mail to: \n"\
    "\t   #{PersonalInfo::MAIL_TO[0]}\n"\
    "\t   #{PersonalInfo::MAIL_TO[1]}\n"
  end
end

