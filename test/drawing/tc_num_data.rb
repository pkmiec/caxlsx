# frozen_string_literal: true

require 'tc_helper'

class TestNumData < Test::Unit::TestCase
  def setup
    @num_data = Axlsx::NumData.new data: [1, 2, 3]
  end

  def test_initialize
    assert_equal("General", @num_data.format_code)
  end

  def test_formula_based_cell; end

  def test_format_code
    assert_raise(ArgumentError) { @num_data.format_code = 7 }
    assert_nothing_raised { @num_data.format_code = 'foo_bar' }
  end

  def test_to_xml_string
    str = +'<?xml version="1.0" encoding="UTF-8"?>'
    str << '<c:chartSpace xmlns:c="' << Axlsx::XML_NS_C << '">'
    str << @num_data.to_xml_string
    doc = Nokogiri::XML(str)

    assert_equal(1, doc.xpath("//c:numLit/c:ptCount[@val=3]").size)
    assert_equal(1, doc.xpath("//c:numLit/c:pt/c:v[text()='1']").size)
  end
end
