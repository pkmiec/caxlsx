# frozen_string_literal: true

require 'tc_helper'

class TestNumVal < Test::Unit::TestCase
  def setup
    @num_val = Axlsx::NumVal.new v: 1
  end

  def test_initialize
    assert_equal("General", @num_val.format_code)
    assert_equal("1", @num_val.v)
  end

  def test_format_code
    assert_raise(ArgumentError) { @num_val.format_code = 7 }
    assert_nothing_raised { @num_val.format_code = 'foo_bar' }
  end

  def test_to_xml_string
    str = +'<?xml version="1.0" encoding="UTF-8"?>'
    str << '<c:chartSpace xmlns:c="' << Axlsx::XML_NS_C << '">'
    str << @num_val.to_xml_string(0)
    doc = Nokogiri::XML(str)
    # lets see if this works?
    assert_equal(1, doc.xpath("//c:pt/c:v[text()='1']").size)
  end
end
