# Sleeping Barber Elixir Program

**TEAM: Kibby Hyacinth Pangilinan**

## Design Rationale

The assignment asks us to have a waiting room, barber, customers, and a receptionist. Therefore, to make my program clean and modular, I created separate .ex files for each of the components.


### waiting_room.ex
In the module, I decided to implement the customer queue, which is responsible for keeping track of the customers waiting and sending the next customer to the barber when the barber is sleeping or not cutting another customer's hair. It is also responsible for checking if the maximum number of customers (6) allowed in the waiting room has been met.

### barber.ex
In this file, I implemented the barber process where the Barber waits for a message from the waiting room and has the Barber cut customers' hair. This file also has the implementation for the Barber to sleep when there are no customers in the waiting room. I decided to implement hot swapping for the Barber the same way hot swapping was presented in class, by calling "\__MODULE__.loop(...)". This allows the barber’s behavior to be updated at runtime without restarting the system.

### customer.ex
I decided to have a customer.ex module that is responsible for representing a singular customer process, where the customer has the ability to get a haircut and leave, or the customer leaves because the waiting room capacity is full. This module essentially simulates the behavior of a customer looking for a haircut.

### customer_spawn.ex
This module is responsible for actually spawing a customer process, and where I implemented hot swapping for customers. For the sleeping barber, I needed multiple different customers so I created this module to have new customer processes be created periodically. Similar to the barber module, I implemented hot swapping here by calling "\__MODULE__.loop(...)" in order to be able to change how the customers are spawned (i.e. changing delay times, etc) without stopping the program.

### receptionist.ex
As per the instructions, the program needs a receptionist to monitor the waiting room so that it can send a customer away or send the customer to the barber if there is space in the waiting room. Thus, I implemented this module to be the intermediary between the customers and the waiting room: the receptionist adds a new customer to the waiting room if there is space, or if the receptionist notices that there isn't space, the customer leaves.


### main.ex
Lastly I created main.ex to have a module that is responsible for putting everything together and spawning the barber, receptionist, customer and waiting room.

Additionally, I used `send/receive` to facilitate actions/behaviors between key actors of the program. I also ensured that I used tail recursion in my processes so that all processes could run indefinitely.

## Design Rationale for Hot Swapping
As previously stated, I implemented hot swapping by calling  "\__MODULE__.loop(...)". By doing so, it allows me to be able to change sleep durations, messages and behavior for the Barber and Customer and be able to see these changes within the next cycle without having to stop the program.

## Running the program
Ensure that you are at the root of the project, then:
1. Enter the Elixir shell by running `iex -S mix`
2. Run `Main.start()` to start the program
3. Watch the program run
4. You can make changes to barber.ex and customer_spawn.ex, then run `recompile()` to observe the changes that you made to the behavior of either the barber or the customers being spawned.
