# frozen_string_literal: true

require 'tc_helper'

class TestView3D < Test::Unit::TestCase
  def setup
    @view = Axlsx::View3D.new
  end

  def teardown; end

  def test_options
    v = Axlsx::View3D.new rot_x: 10, rot_y: 5, h_percent: "30%", depth_percent: "45%", r_ang_ax: false, perspective: 10

    assert_equal(10, v.rot_x)
    assert_equal(5, v.rot_y)
    assert_equal("30%", v.h_percent)
    assert_equal("45%", v.depth_percent)
    refute(v.r_ang_ax)
    assert_equal(10, v.perspective)
  end

  def test_rot_x
    assert_raise(ArgumentError) { @view.rot_x = "bob" }
    assert_nothing_raised { @view.rot_x = -90 }
  end

  def test_rot_y
    assert_raise(ArgumentError) { @view.rot_y = "bob" }
    assert_nothing_raised { @view.rot_y = 90 }
  end

  def test_h_percent
    assert_raise(ArgumentError) { @view.h_percent = "bob" }
    assert_nothing_raised { @view.h_percent = "500%" }
  end

  def test_depth_percent
    assert_raise(ArgumentError) { @view.depth_percent = "bob" }
    assert_nothing_raised { @view.depth_percent = "20%" }
  end

  def test_rAngAx
    assert_raise(ArgumentError) { @view.rAngAx = "bob" }
    assert_nothing_raised { @view.rAngAx = true }
  end

  def test_perspective
    assert_raise(ArgumentError) { @view.perspective = "bob" }
    assert_nothing_raised { @view.perspective = 30 }
  end
end
