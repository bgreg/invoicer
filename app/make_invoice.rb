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

  def initialize(options = {})
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
    @file_path  = options.fetch(:file_path, false)
    @line_items = options.fetch(:line_items, LineItems.new)
    @std_in     = options.fetch(:std_in, STDIN)
    @rows       = []
  end

  def run
    continue = true

    printer(CYAN, "Welcome to Invoicer, enter as many line items as need.")
    line_break(2)

    while continue do
      printer(GREEN, "Description [stuff I did]: ")
      description = @std_in.gets.chomp

      printer(GREEN, "Date [01/01/2222]: ")
      date = @std_in.gets.chomp

      printer(GREEN, "Hours [0-99]: ")
      hours = @std_in.gets.chomp.to_i

      if [description, date].all?{ |i| !i.empty? } && hours != 0
        @rows << Row.new(description, date, hours, PersonalInfo::RATE)
      else
        printer(RED, "No data given")
        line_break(1)
      end

      printer(RED, "Enter another item?  [y|n]: ")
      continue = @std_in.gets.chomp.downcase  == "y" ? true : false
      line_break(2)
    end

    make unless @rows.empty?
  end

  def make(invoice_number = next_invoice_number)
    @line_items.add_rows(@rows)
    write_file(invoice_number)
    printer(CYAN, "Created invoice number #{invoice_number}")
    line_break(1)
    increment_invoice_record(invoice_number)
  end

  def write_file(invoice_number)
    File.write(
      path(invoice_number),
      Invoicer.new(invoice_number, PersonalInfo::RATE, @line_items).invoice)
  end

  private

  def path(number)
    @file_path ? @file_path : "unpaid/invoice_#{number}.txt"
  end

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
    count.times{ puts }
  end
end
