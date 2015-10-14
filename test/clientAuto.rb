class CLIENT
	#Ruby client for echo.php server.
	#Tested and working on localhost.
	#Wesley Fung
	require 'socket'

	hostname = '0.0.0.0'
	port = 8000

	# Asks for user input until break condition is satisfied

	#loop do
	#puts "\nEnter a word followed by <ENTER> to send request and have the server echo it back to you! \nSend END to quit."

	#user_input = gets.chomp
	user_input = "HELO Hello World!"
	# Accounting for sentences
	user_input.gsub! ' ', '%20'
	request = "GET /echo.php?message=#{user_input} HTTP/1.0\r\n\r\n"

	socket = TCPSocket.open(hostname, port)
	socket.print(request)
	# Break when either of the conditions are satisfied
	if (user_input == "KILL_SERVICE")
	response = socket.read

	print "ECHO RESPONSE: " + response + "\n"
	end 
end
