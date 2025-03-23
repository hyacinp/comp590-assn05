defmodule WaitingRoom do
  def start_link(barber_pid) do
    spawn_link(fn -> loop(barber_pid, []) end)
  end

  def loop(barber_pid, queue) do
    receive do
      {:add_customer, customer_pid} ->
        new_queue = queue ++ [customer_pid]
        if length(new_queue) == 1 do
          send(barber_pid, {:next_customer, customer_pid})
        end
        loop(barber_pid, new_queue)

      {:customer_done} ->
        [_ | rest] = queue
        case rest do
          [next | _] ->
            send(barber_pid, {:next_customer, next})
          [] ->
            send(barber_pid, :no_customers)
        end
        loop(barber_pid, rest)

      {:space_check, from_pid, max_chairs} ->
        send(from_pid, {:space_result, length(queue) < max_chairs})
        loop(barber_pid, queue)
    end
  end

  def add_customer(waiting_room_pid, customer_pid) do
    send(waiting_room_pid, {:add_customer, customer_pid})
  end
  def space_available?(waiting_room_pid, max_chairs) do
    send(waiting_room_pid, {:space_check, self(), max_chairs})
    receive do
      {:space_result, result} -> result
    end
  end
  def customer_done(waiting_room_pid) do
    send(waiting_room_pid, {:customer_done})
  end

end
