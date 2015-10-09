class SERVER
	require 'socket'

	server = TCPServer.open('0.0.0.0', 8000)

	loop do                        
		Thread.start(socket = server.accept) do |client|
			request = socket.gets
			STDERR.puts request
			response = "Hello World!\n"
			client.puts "Closing the connection. Bye!"
			client.close
		end
	end
end
