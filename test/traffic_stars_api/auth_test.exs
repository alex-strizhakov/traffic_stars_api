defmodule TrafficStarsAPI.AuthTest do
  use ExUnit.Case, async: true

  import Mox

  alias Tesla.Adapter.Mock
  alias TrafficStarsAPI.Auth

  @headers [{"content-type", "application/x-www-form-urlencoded"}]
  @base_url "https://api.trafficstars.com/v1"
  @token_url Path.join(@base_url, "/auth/token")

  setup :verify_on_exit!

  describe "auth endpoints" do
    setup do
      body = %{
        "access_token" =>
          "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ6Y2YyOTMwb0RpSmJxUWs4Vz",
        "expires_in" => 36000,
        "token_type" => "Bearer",
        "id_token" =>
          "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJ6Y2YyOTMwb0RpSmJxUWs4VzR0a"
      }

      [body: body]
    end

    test "sign_in/1", %{body: body} do
      api_key = "api_key"

      expect(Mock, :call, fn
        %{
          url: @token_url,
          body: "grant_type=refresh_token&refresh_token=api_key",
          headers: @headers,
          method: :post
        },
        _ ->
          {:ok, %Tesla.Env{body: Jason.encode!(body)}}
      end)

      assert {:ok, %{body: ^body}} = Auth.sign_in(api_key)
    end

    test "refresh_token/1", %{body: body} do
      refresh_token = "refresh_token"

      expect(Mock, :call, fn
        %{
          url: @token_url,
          body: "grant_type=refresh_token&refresh_token=refresh_token",
          headers: @headers,
          method: :post
        },
        _ ->
          {:ok, %Tesla.Env{body: Jason.encode!(body)}}
      end)

      assert {:ok, %{body: ^body}} = Auth.refresh_token(refresh_token)
    end

    test "session_info/1", %{body: body} do
      access_token = "access_token"

      url = Path.join(@base_url, "/auth/info")

      headers = [
        {"content-type", "application/json"},
        {"authorization", "Bearer #{access_token}"}
      ]

      expect(Mock, :call, fn
        %{
          url: ^url,
          headers: ^headers,
          method: :post
        },
        _ ->
          {:ok, %Tesla.Env{body: body}}
      end)

      assert {:ok, %{body: ^body}} = Auth.session_info(access_token)
    end
  end

  test "sign_out/1" do
    access_token = "access_token"

    url = Path.join(@base_url, "/auth/logout")
    headers = [{"authorization", "Bearer #{access_token}"}]

    expect(Mock, :call, fn
      %{
        url: ^url,
        headers: ^headers,
        method: :get
      },
      _ ->
        {:ok, %Tesla.Env{status: 204}}
    end)

    assert {:ok, %{status: 204}} = Auth.sign_out(access_token)
  end
end
