require 'spec_helper'
require_relative '../app/table'

describe Table do
  let(:test_row) do
      ["Test3", "01/01/2014", "99999", "9999.0", "999890001.0"]
  end

  it "constructs a table structure from rows" do
    row      = double(rows: [test_row])
    row.rows << :separator
    itemizer = double(rows: row.rows, total_hours: 1)
    table = described_class.build_table(itemizer, 2)
    puts table
  end
end
