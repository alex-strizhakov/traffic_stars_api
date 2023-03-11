defmodule TrafficStarsAPITest do
  use ExUnit.Case, async: true

  test "client" do
    assert %Tesla.Client{
             pre: [
               {Tesla.Middleware.BaseUrl, :call, ["https://api.trafficstars.com/v1"]},
               {Tesla.Middleware.JSON, :call, [[]]},
               {Tesla.Middleware.Headers, :call, [[{"authorization", "Bearer access_token"}]]}
             ]
           } = TrafficStarsAPI.client("access_token")
  end
end
