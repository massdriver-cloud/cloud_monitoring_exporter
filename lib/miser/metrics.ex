defmodule Miser.Metrics do
  @moduledoc """
  """

  use PromEx, otp_app: :miser

  alias Miser.Metrics.Poller

  @impl true
  def plugins do
    poller_configuration = Application.get_env(:miser, Miser.Metrics.Poller)

    [
      {Poller, poller_configuration}
    ]
  end

  @impl true
  def dashboard_assigns, do: []

  @impl true
  def dashboards, do: []
end
