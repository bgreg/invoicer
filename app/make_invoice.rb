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
    @store      = options.fetch(:store, YAML::Store.new("db/invoice.store"))
    @file_path  = options.fetch(:file_path, false)
    @line_items = options.fetch(:line_items, LineItems.new)
    @std_in     = options.fetch(:std_in, STDIN)
    @rows       = []
    @clients    = store_clients
  end

  def run
    @store.transaction do
      continue = true

      printer(CYAN, "Welcome to Invoicer, enter as many line items as need.")
      line_break(2)

      printer(GREEN, "Please enter a client from this list:")
      line_break
      printer(CYAN, "[#{@clients.join(' | ')}]: ")
      client = @std_in.gets.chomp.strip
      rate   = @store.fetch(client)[:rate] rescue abort("#{RED}Could not find client: #{client}")

      while continue do
        printer(GREEN, "Description [stuff I did]: ")
        description = @std_in.gets.chomp

        printer(GREEN, "Date [01/01/2222]: ")
        date = @std_in.gets.chomp

        printer(GREEN, "Hours [0-99]: ")
        hours = @std_in.gets.chomp.to_i

        if [description, date].all?{ |i| !i.empty? } && hours != 0
          @rows << Row.new(description, date, hours, rate)
        else
          printer(RED, "No data given")
          line_break
        end

        printer(RED, "Enter another item?  [y|n]: ")
        continue = (@std_in.gets.chomp.downcase  == "y" ? true : false)
        line_break(2)
      end

      make(rate, @store.fetch(client)) unless @rows.empty?
    end
  end

  private

  def make(rate, client_data, invoice_number = next_invoice_number)
    @line_items.add_rows(@rows)
    write_file(invoice_number, rate, client_data)
    printer(CYAN, "Created invoice number #{invoice_number}")
    line_break
    increment_invoice_record(invoice_number)
  end

  def write_file(invoice_number, rate, client_data)
    File.write(
      path(invoice_number),
      Invoicer.new(invoice_number, rate, @line_items, client_data).invoice)
  end

  def store_clients
    @store.transaction(true) { @store.fetch(:clients) }
  end

  def path(number)
    @file_path ? @file_path : "unpaid/invoice_#{number}.txt"
  end

  def next_invoice_number
    @store[:last_invoice] + 1
  end

  def increment_invoice_record(number)
    @store[:last_invoice] += 1
  end

  def printer(color, text)
    print "\t#{color}#{text}"
  end

  def line_break(count = 1)
    count.times{ puts }
  end
end
