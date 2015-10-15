# CS4032 Distributed Systems Lab 2
###Wesley Fung (fungw@tcd.ie)

Student ID: f3ddcabdebd2d7cfa6c080da06b2b657f36d2ef65406b6b19f3970161e1f5b09

Multithreaded Ruby server with thread pooling and client implementation.
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
sh start.sh 8000
###To run a client:
ruby client.rb
###To run the test:
sh multiClient.sh
> NOTE: Make sure you run the script from inside the test folder.
multiClient.sh will not be able to find clientAuto.rb if you run
it from anywhere else.
