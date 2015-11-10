require 'fileutils'

class Pay
  CYAN  = "\e[36m"
  GREEN = "\e[92m"
  RED   = "\e[31m"

  def initialize
  end

  def run
    printer(GREEN,"Please enter the invoice to pay\n")
    printer(CYAN, Dir.entries("unpaid").join(" ") + "\n")
    payed_invoice = gets.chomp.strip
    FileUtils.mv("unpaid/#{payed_invoice}", "paid/#{payed_invoice}")

    if File.exists?("paid/#{payed_invoice}")
      printer(CYAN, "Success")
    else
      printer(RED, "OOPS")
    end
  end

  private

  def printer(color, text)
    print "\t#{color}#{text}"
  end
end

Pay.new.run
