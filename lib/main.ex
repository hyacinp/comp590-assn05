defmodule Main do

  def start do
    barber_pid = Barber.start_link(self())
    waiting_room_pid = WaitingRoom.start_link(barber_pid)
    receptionist_pid = Receptionist.start_link(waiting_room_pid, 6)
    CustomerSpawn.start_link(receptionist_pid, waiting_room_pid)
  end

end
