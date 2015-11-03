require 'spec_helper'
require_relative '../app/make_invoice'

describe MakeInvoice do
  let(:test_file) { "spec/test_file" }

  before do
    allow_any_instance_of(MakeInvoice).to receive(:print).and_return(nil)
  end

  after { File.delete(test_file) }

  context "#run" do
    it "will create an invoice file with line items" do
      invoice = described_class.new(file_path: test_file)
      expect(STDIN).to receive(:gets).and_return("stuff", "01/01/2222", "42", "n")
      invoice.run

      file_contents = File.read(test_file)

      expect(File.exists?(test_file)).to be_truthy
      expect(file_contents).to include "stuff"
      expect(file_contents).to include "01/01/2222"
      expect(file_contents).to include "42"
    end
  end

  context "#make" do
  end
end
