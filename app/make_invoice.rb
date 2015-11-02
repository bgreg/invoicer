require 'rubygems'
require 'terminal-table'
require_relative "invoicer"
require_relative "itemizer"
require_relative "row"
require_relative '../personal_info'

class MakeInvoice
  CYAN  = "\e[36m"
  GREEN = "\e[92m"
  RED   = "\e[31m"

  def run
    rows = []
    continue = true

    printer(CYAN, "Welcome to Invoicer, enter as many line items as need.")
    line_break(2)

    while continue do
      printer(GREEN, "Description [stuff I did]: ")
      description = gets.chomp

      printer(GREEN, "Date [01/01/2222]: ")
      date = gets.chomp

      printer(GREEN, "Hours [0-99]: ")
      hours = gets.chomp.to_i

      if [description, date].all?{ |i| i != "" } && hours != 0
        rows << Row.new(description, date, hours, PersonalInfo::RATE)
      else
        printer(RED, "No data given")
        line_break(1)
      end

      printer(RED, "Enter another item?  [y|n]: ")
      continue = gets.chomp.downcase  == "y" ? true : false
      line_break(2)
    end

    unless rows.empty?
      make(rows)
    end
  end

  def make(rows, invoice_number = next_invoice_number)
    itemizer = Itemizer.new(PersonalInfo::RATE)
    rows.each{ |row| itemizer.add_row(row) }

    File.write(
      "unpaid/invoice_#{invoice_number}.txt",
      Invoicer.new(invoice_number, PersonalInfo::RATE, itemizer).invoice
    )

    printer(CYAN, "Created invoice number #{invoice_number}")
    line_break(1)
    increment_invoice_record(invoice_number)
  end

  private

  def next_invoice_number
    File.read("last_invoice.txt").chomp.to_i + 1
  end

  def increment_invoice_record(number)
    File.write("last_invoice.txt", number)
  end

  def printer(color, text)
    print "\t#{color}#{text}"
  end

  def line_break(count)
    count.times{|t| puts }
  end
end
