require 'date'
require_relative 'personal_info'

class Invoicer

  def initialize(num, rate, itemizer)
    @invoice_number = num
    @rate           = rate
    @itemizer       = itemizer
  end

  def invoice
    "#{header}\n"\
    "#{bill_to}\n"\
    "\n"\
    "#{line_items}\n"\
    "\n"\
    "#{footer}\n"\
    "\tThank You"
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
    "\t+-------------------------+----------------+\n"\
    "\t| Make checks payable to:                  |\n"\
    "\t|                                          |\n"\
    "\t|   #{PersonalInfo::PAYABLE_TO}                           |\n"\
    "\t|                                          |\n"\
    "\t| Mail to:                                 |\n"\
    "\t|                                          |\n"\
    "\t|   #{PersonalInfo::MAIL_TO[0]}                     |\n"\
    "\t|   #{PersonalInfo::MAIL_TO[1]}                   |\n"\
    "\t+-------------------------+----------------+\n"
  end

  def line_items
    head = "\t+----------------------------------------------------------------------------------------------+\n"\
           "\t| DESCRIPTION                                       |    DATE    |  RATE  |  HOURS |  AMOUNT   |\n"\
           "\t+---------------------------------------------------+------------+--------+--------+-----------+"

    tail = "\t|  TOTAL                                            |            |        |        |  $#{total}  |\n"\
           "\t+---------------------------------------------------+------------+--------+--------+-----------+"
    "#{head}\n#{@itemizer.rows.join("\n")}\n#{tail}"
  end


  def total
    (@itemizer.total_hours * @rate).round(2)
  end
end

