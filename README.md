# CS4032 Distributed Systems Lab 2\nWesley Fung (fungw@tcd.ie)

Simple multithreaded Ruby server and client implementation.
The server is designed to take in two types of messages:

### KILL\_SERVICE
Kill status is received by both client and server.

### HELO #{text}
Message below is returned to client from server when HELO message is received.
- HELO #{text}
- IP: #{client\_ip}
- PORT: #{client\_port}
- Student ID: #{student\_id}

## Command-line
###To run the server:
start.sh 8000
###To run a client:
ruby CLIENT.rb
