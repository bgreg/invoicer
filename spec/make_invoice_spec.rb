require 'spec_helper'
require_relative '../app/make_invoice'

describe MakeInvoice do
  let(:store) { YAML::Store.new("spec/db/invoice.store") }
  let(:test_file) { "spec/test_file" }

  before do
    allow_any_instance_of(MakeInvoice).to receive(:print).and_return(nil)
  end

  after do
    File.delete(test_file)
    store.transaction { store[:last_invoice] = 0 }
  end

  context "#run" do
    let(:file_contents) { File.read(test_file) }
    let(:invoice) { described_class.new(store: store, file_path: test_file) }

    before do
      expect(STDIN).to receive(:gets).and_return("Mega City One", "Punish scum", "01/01/2222", "42", "n")
    end

    it "will gather inputs from the user needed for making an invoice" do
      invoice.run
      # puts file_contents

      expect(File.exists?(test_file)).to be_truthy
      expect(file_contents).to include "Mega City One"
      expect(file_contents).to include "Punish scum"
      expect(file_contents).to include "01/01/2222"
      expect(file_contents).to include "42"
    end

    it "will increment the invoice number every time an invoice is created" do
      starting_invoice_number = store.transaction { store[:last_invoice] }
      invoice.run
      ending_invoice_number = store.transaction { store[:last_invoice] }
      expect(starting_invoice_number < ending_invoice_number).to be_truthy
    end
  end
end
