# CS4032 Distributed Systems Lab 2
## Wesley Fung (fungw@tcd.ie)

Simple multithreaded Ruby server and client implementation.
The server is designed to take in two types of messages

### KILL\_SERVICE
- Kill status is received by both client and server.

### HELO #{text}
- Message below is returned to client from server when HELO message is received.
- HELO #{text}
- IP: #{client\_ip}
- PORT: #{client\_port}
- Student ID: #{student\_id}
