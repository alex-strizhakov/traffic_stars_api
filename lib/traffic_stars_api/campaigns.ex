defmodule TrafficStarsAPI.Campaigns do
  def get_by_id(client, id) do
    Tesla.get(client, "/campaign/#{id}")
  end

  def status_by_id(client, id) do
    Tesla.get(client, "/campaign/status/#{id}")
  end

  def list(client, query \\ []) do
    Tesla.get(client, "/campaign/list", query)
  end

  def create(client, payload) do
    Tesla.post(client, "/campaign/create", payload)
  end

  def update(client, id, payload) do
    Tesla.patch(client, "/campaign/#{id}", payload)
  end

  def run(client, id) when is_integer(id), do: run(client, [id])

  def run(client, ids) when is_list(ids) do
    put_request(client, "/campaigns/run", ids)
  end

  def pause(client, id) when is_integer(id), do: pause(client, [id])

  def pause(client, ids) when is_list(ids) do
    put_request(client, "/campaigns/pause", ids)
  end

  def archive(client, id) when is_integer(id), do: archive(client, [id])

  def archive(client, ids) when is_list(ids) do
    put_request(client, "/campaigns/archive", ids)
  end

  def unarchive(client, id) when is_integer(id), do: unarchive(client, [id])

  def unarchive(client, ids) when is_list(ids) do
    put_request(client, "/campaigns/unarchive", ids)
  end

  defp put_request(client, path, ids) do
    client
    |> update_base_url()
    |> Tesla.put(path, %{campaign_ids: ids})
  end

  defp update_base_url(client) do
    Map.update!(client, :pre, fn pre ->
      List.keyreplace(
        pre,
        Tesla.Middleware.BaseUrl,
        0,
        {Tesla.Middleware.BaseUrl, :call, ["https://api.trafficstars.com/v1.1"]}
      )
    end)
  end
end
