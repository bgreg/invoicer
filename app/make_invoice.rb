require 'rubygems'
require 'terminal-table'
require 'yaml/store'
require_relative "invoicer"
require_relative "line_items"
require_relative "row"
require_relative '../db/struct/client'

class MakeInvoice
  CYAN  = "\e[36m"
  GREEN = "\e[92m"
  RED   = "\e[31m"

  def initialize
    store = YAML::Store.new("db/invoice.store")

    client = Struct::Client.new(
      rate: 99,
      bill_to: ["Security One", "3344 PeachTrees","MegaCityOne, Ny, 55555"],
      payable_to: "Judge Dredd",
      mail_to: ["12345 Justice Drive", "Mega City One, Ny, 55555"]
    )

    store.transaction do
      store["client1"] = client
    end
  end

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
    line_items = LineItems.new
    line_items.add_rows(rows)

    File.write(
      "unpaid/invoice_#{invoice_number}.txt",
      Invoicer.new(invoice_number, PersonalInfo::RATE, line_items).invoice)

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
