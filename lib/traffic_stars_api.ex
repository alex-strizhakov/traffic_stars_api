defmodule TrafficStarsAPI do
  @moduledoc """
  Documentation for `TrafficStarsAPI`.
  """

  alias TrafficStarsAPI.Auth
  alias TrafficStarsAPI.Campaigns

  def client(access_token) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.trafficstars.com/v1"},
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"authorization", "Bearer " <> access_token}]}
    ]

    Tesla.client(middleware)
  end

  # -------------------
  # Auth endpoints
  # -------------------

  defdelegate sign_in(api_key), to: Auth
  defdelegate refresh_token(refresh_token), to: Auth
  defdelegate session_info(access_token), to: Auth
  defdelegate sign_out(access_token), to: Auth

  # -------------------
  # Campaigns endpoints
  # -------------------

  defdelegate get_campaign_by_id(client, id), to: Campaigns, as: :get_by_id
  defdelegate get_campaign_status_by_id(client, id), to: Campaigns, as: :status_by_id
  defdelegate list_campaigns(client), to: Campaigns, as: :list
  defdelegate create_campaign(client, payload), to: Campaigns, as: :create
  defdelegate update_campaign(client, id, payload), to: Campaigns, as: :update
  defdelegate run_campaign(client, ids), to: Campaigns, as: :run
  defdelegate pause_campaign(client, ids), to: Campaigns, as: :pause
  defdelegate archive_campaign(client, ids), to: Campaigns, as: :archive
  defdelegate unarchive_campaign(client, ids), to: Campaigns, as: :unarchive
end
