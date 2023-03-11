defmodule TrafficStarsAPI.Auth do
  @base_url {Tesla.Middleware.BaseUrl, "https://api.trafficstars.com/v1"}

  @auth_middleware [
    @base_url,
    Tesla.Middleware.FormUrlencoded
  ]

  def sign_in(api_key) do
    client = Tesla.client(@auth_middleware)

    with {:ok, response} <- Tesla.post(client, "/auth/token", build_payload(api_key)) do
      {:ok, Map.update!(response, :body, &Jason.decode!/1)}
    end
  end

  def refresh_token(refresh_token) do
    client = Tesla.client(@auth_middleware)

    with {:ok, response} <- Tesla.post(client, "/auth/token", build_payload(refresh_token)) do
      {:ok, Map.update!(response, :body, &Jason.decode!/1)}
    end
  end

  defp build_payload(refresh_token) do
    %{grant_type: "refresh_token", refresh_token: refresh_token}
  end

  def session_info(access_token) do
    [Tesla.Middleware.JSON | build_auth_middleware(access_token)]
    |> Tesla.client()
    |> Tesla.post("/auth/info", %{})
  end

  def sign_out(access_token) do
    access_token
    |> build_auth_middleware()
    |> Tesla.client()
    |> Tesla.get("/auth/logout")
  end

  defp build_auth_middleware(access_token) do
    [@base_url, {Tesla.Middleware.Headers, [{"authorization", "Bearer " <> access_token}]}]
  end
end
