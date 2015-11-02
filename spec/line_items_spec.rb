require "spec_helper"
require_relative "../app/line_items"
require_relative "../app/row"

describe LineItems do
  let(:line_items) { described_class.new }
  let(:rows) { 2.times.map { Row.new("a" * 80, "a_date", 12, 5) } }
  let(:expected_line_item_rows) do
    [
      [
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "a_date",
        5,
        12,
        60.0
      ],
      :separator,
      [
        "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\naaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        "a_date",
        5,
        12,
        60.0
      ],
      :separator,
    ]
  end

  it "holds a collection of rows" do
    rows.each{ |r| line_items.add_row(r) }
    expect(line_items.rows).to match_array(expected_line_item_rows)
  end

  it "allows adding an array of rows" do
    line_items.add_rows(rows)
    expect(line_items.rows).to eq(expected_line_item_rows)
  end
end
