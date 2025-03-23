defmodule CustomerSpawn do
  def start_link(receptionist_pid, waiting_room_pid) do
    spawn_link(fn -> loop(receptionist_pid, waiting_room_pid) end)
  end

  def loop(receptionist_pid, waiting_room_pid) do
    :timer.sleep(:rand.uniform(2000))
    Customer.start_link(receptionist_pid, waiting_room_pid)
    loop(receptionist_pid, waiting_room_pid)
  end
end
