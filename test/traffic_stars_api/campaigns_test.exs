defmodule TrafficStarsAPI.CampaignsTest do
  use ExUnit.Case, async: true

  import Mox

  alias Tesla.Adapter.Mock
  alias TrafficStarsAPI.Campaigns

  @base_url "https://api.trafficstars.com/v1"
  @action_base_url @base_url <> ".1"

  setup :verify_on_exit!

  setup do
    [client: TrafficStarsAPI.client("access_token")]
  end

  test "get_by_id/2", %{client: client} do
    url = Path.join(@base_url, "/campaign/1")
    expect(Mock, :call, fn %{url: ^url, method: :get}, _ -> :ok end)

    assert Campaigns.get_by_id(client, 1) == :ok
  end

  test "status_by_id/2", %{client: client} do
    url = Path.join(@base_url, "/campaign/status/1")

    expect(Mock, :call, fn %{url: ^url, method: :get}, _ -> :ok end)
    assert Campaigns.status_by_id(client, 1) == :ok
  end

  test "create/2", %{client: client} do
    url = Path.join(@base_url, "/campaign/create")

    payload = %{a: 1}
    body = Jason.encode!(payload)
    expect(Mock, :call, fn %{url: ^url, method: :post, body: ^body}, _ -> :ok end)
    assert Campaigns.create(client, payload) == :ok
  end

  test "update/3", %{client: client} do
    url = Path.join(@base_url, "/campaign/1")

    payload = %{a: 1}
    body = Jason.encode!(payload)
    expect(Mock, :call, fn %{url: ^url, method: :patch, body: ^body}, _ -> :ok end)
    assert Campaigns.update(client, 1, payload) == :ok
  end

  describe "run/2" do
    test "with one id", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/run")
      payload = %{campaign_ids: [1]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.run(client, 1) == :ok
    end

    test "with list of ids", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/run")
      payload = %{campaign_ids: [1, 2]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.run(client, [1, 2]) == :ok
    end
  end

  describe "pause/2" do
    test "with one id", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/pause")
      payload = %{campaign_ids: [1]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.pause(client, 1) == :ok
    end

    test "with list of ids", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/pause")
      payload = %{campaign_ids: [1, 2]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.pause(client, [1, 2]) == :ok
    end
  end

  describe "archive/2" do
    test "with one id", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/archive")
      payload = %{campaign_ids: [1]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.archive(client, 1) == :ok
    end

    test "with list of ids", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/archive")
      payload = %{campaign_ids: [1, 2]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.archive(client, [1, 2]) == :ok
    end
  end

  describe "unarchive/2" do
    test "with one id", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/unarchive")
      payload = %{campaign_ids: [1]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.unarchive(client, 1) == :ok
    end

    test "with list of ids", %{client: client} do
      url = Path.join(@action_base_url, "/campaigns/unarchive")
      payload = %{campaign_ids: [1, 2]}
      body = Jason.encode!(payload)
      expect(Mock, :call, fn %{url: ^url, body: ^body, method: :put}, _ -> :ok end)
      assert Campaigns.unarchive(client, [1, 2]) == :ok
    end
  end
end
