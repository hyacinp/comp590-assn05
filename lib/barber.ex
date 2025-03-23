defmodule Barber do
  def start_link(waiting_room) do
    spawn_link(__MODULE__, :loop, [waiting_room])
  end

  def loop(waiting_room) do
    receive do
      {:next_customer, customer_pid} ->
        IO.puts("[Barber] starting haircut for customer #{inspect(customer_pid)}")
        :timer.sleep(:rand.uniform(2000))
        IO.puts("[Barber] Finished cutting customer #{inspect(customer_pid)}'s hair")
        send(customer_pid, :done)
        __MODULE__.loop(waiting_room)

      :no_customers ->
          IO.puts("[Barber] No customers. Sleeping")
          receive do
            {:next_customer, customer_pid} ->
              IO.puts("[Barber] awakens — now cutting hair for customer #{inspect(customer_pid)}")
              :timer.sleep(:rand.uniform(2000))
              IO.puts("[Barber] Finished cutting customer #{inspect(customer_pid)}'s hair")
              send(customer_pid, :done)
          end
          __MODULE__.loop(waiting_room)
    end
  end
end
