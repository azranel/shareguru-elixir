ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Shareguru.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Shareguru.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Shareguru.Repo)

