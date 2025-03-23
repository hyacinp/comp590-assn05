defmodule Customer do
  def start_link(receptionist_pid, waiting_room_pid) do
    spawn_link(fn -> loop(receptionist_pid, waiting_room_pid)
    end)
  end

  def loop(receptionist_pid, waiting_room_pid) do
    send(receptionist_pid, {:new_customer, self()})

    receive do
      :full ->
        IO.puts("[Customer #{inspect(self())}] leaves, because there is no waiting space.")
      :done ->
        IO.puts("[Customer #{inspect(self())}] got their haircut and is now leaving.")
        WaitingRoom.customer_done(waiting_room_pid)
    end
  end
end
