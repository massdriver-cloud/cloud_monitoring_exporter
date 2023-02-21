defmodule Env do
  @moduledoc """
  Module for getting casted values out of System.get_env/2
  Loosely based on https://blog.nytsoi.net/2021/04/17/elixir-simple-configuration
  """

  @type config_type :: :string | :float | :integer | :boolean | :atom
  @type casted_types :: binary() | float | integer | boolean | atom | nil

  @doc "Gets and casts an environment variable as a string. Returns nil if not set."
  @spec get(binary) :: casted_types
  def get(key), do: get(key, :string, nil)

  @doc "Gets and casts an environment variable"
  @spec get(binary(), config_type(), any) :: casted_types
  def get(key, type, default \\ nil) do
    case System.get_env(key) do
      nil -> default
      val -> cast(val, type)
    end
  end

  @doc "Gets and casts a value as string, will raise an exception if env is missing"
  @spec get!(binary()) :: casted_types | no_return
  def get!(key), do: get!(key, :string)

  @doc "Gets and casts value, will raise an exception if env is missing"
  @spec get!(binary(), config_type()) :: casted_types | no_return
  def get!(key, type) do
    case System.get_env(key) do
      nil -> raise "Missing environment variable: #{key}"
      val -> cast(val, type)
    end
  end

  @spec cast(binary(), config_type()) :: any()
  defp cast(val, :integer), do: String.to_integer(val)
  defp cast(val, :float), do: String.to_float(val)
  defp cast(val, :string), do: val
  defp cast(val, :string_csv), do: String.split(val, ",")
  defp cast(val, :atom), do: String.to_atom(val)
  defp cast("true", :boolean), do: true
  defp cast("false", :boolean), do: false
end
