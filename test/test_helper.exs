Mox.defmock(Tesla.Adapter.Mock, for: Tesla.Adapter)
Application.put_env(:tesla, :adapter, Tesla.Adapter.Mock)
ExUnit.start()
