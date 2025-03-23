#Team: Kibby Hyacinth Pangilinan

defmodule Receptionist do
  def start_link(waiting_room, max_chairs) do
    spawn_link(fn -> loop(waiting_room, max_chairs) end)
  end

  def loop(waiting_room, max_chairs) do
    receive do
      {:new_customer, customer_pid} ->
        if WaitingRoom.space_available?(waiting_room, max_chairs) do
          IO.puts("[Receptionist] Customer #{inspect(customer_pid)} enters waiting room")
          WaitingRoom.add_customer(waiting_room, customer_pid)
        else
          IO.puts("[Receptionist] Waiting room full. Customer#{inspect(customer_pid)} leaves")
          send(customer_pid, :full)
        end
        loop(waiting_room, max_chairs)
    end
  end
end
