# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

require 'minitest-power_assert'
require 'minitest/autorun'

class StackTest < Minitest::Test

  def setup
    @stack = Stack.new
    @stack.push!(1)
  end

  def test_push
    refute @stack.empty?
  end

  def test_pop
    assert_equal 1, @stack.pop!
    assert @stack.empty?
  end

  def test_clear
    @stack.clear!
    assert @stack.empty?
  end

  def test_empty
    refute @stack.empty?
  end
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
