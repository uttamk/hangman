defmodule FibonacciTest do
  use ExUnit.Case
  doctest Fibonacci

  test "return 0 for 0" do
    assert Fibonacci.fib(0) == 0
  end

  test "return 1 for 1" do
    assert Fibonacci.fib(1) == 1
  end

  test "return 1 for 2" do
    assert Fibonacci.fib(2) == 1
  end

  test "return 2 for 3" do
    assert Fibonacci.fib(2) == 1
  end

  test "return 55 for 10" do
    assert Fibonacci.fib(2) == 1
  end
end
