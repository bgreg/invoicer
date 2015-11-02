require "spec_helper"
require_relative "../app/row"

describe Row do

  context "#to_a" do
    it "wraps first element and generates a total" do
      row = Row.new("a" * 80, "a_date", 12, 5)
      expect(row.to_a).to match_array(
         ["aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\n"\
          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa", "a_date", 5, 12, 60.0]
      )
      expect(row.to_a[4]).to eq(60.0)
    end
  end
end
