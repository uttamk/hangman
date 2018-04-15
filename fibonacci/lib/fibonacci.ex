defmodule Fibonacci do
  alias Fibonacci.Cache

  def fib(n) do
    {:ok, agent} = Cache.intialize(fn -> %{0 => 0, 1 => 1} end)
    value = fib(agent, n)
    Agent.stop(agent)
    value
  end

  defp fib(agent, 0) do
    Cache.get(agent, 0)
  end

  defp fib(agent, 1) do
    Cache.get(agent, 1)
  end

  defp fib(agent, n) do
    fib_n_minus_one = fib(agent, n - 1, Cache.has_key?(agent, n - 1))
    fib_n_minus_two = fib(agent, n - 2, Cache.has_key?(agent, n - 2))

    fib_n_minus_one + fib_n_minus_two
  end

  defp fib(agent, n, _is_in_cache = true) do
    Cache.get(agent, n)
  end

  defp fib(agent, n, _is_in_cache = false) do
    Cache.update(agent, n, fib(agent, n))
  end
end

defmodule Fibonacci.Cache do
  def intialize(init_fn) do
    Agent.start_link(init_fn)
  end

  def get(agent, key) do
    Agent.get(agent, fn map -> Map.get(map, key) end)
  end

  def has_key?(agent, key) do
    Agent.get(agent, fn map -> Map.has_key?(map, key) end)
  end

  def update(agent, key, value) do
    Agent.update(agent, fn map -> Map.put(map, key, value) end)
    value
  end
end
