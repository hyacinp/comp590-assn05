#Team: Kibby Hyacinth Pangilinan

defmodule CustomerSpawn do
  def start_link(receptionist_pid, waiting_room_pid) do
    spawn(__MODULE__, :loop, [receptionist_pid, waiting_room_pid])
  end

  def loop(receptionist_pid, waiting_room_pid) do
    :timer.sleep(:rand.uniform(2000))
    Customer.start_link(receptionist_pid, waiting_room_pid)
    __MODULE__.loop(receptionist_pid, waiting_room_pid)
    end
end
