class SERVER
	require 'thread'
	require 'socket'

	address = '0.0.0.0'
	port = ARGV[0] 
	server = TCPServer.open(address, port)
	puts "Server is running on #{address} on port #{port}." 

	thread_pool = Queue.new
	(0..50).to_a.each{|x| thread_pool.push x }
	pool = (0...4).map do
		Thread.new do
			begin
				while x = thread_pool.pop(true)
					Thread.start(socket = server.accept) do |client|
						request = socket.gets
						puts "Client received."	
						# GET /echo.php?message=hello HTTP/1.0
						response = "Undefined, request error."
						parseRequest = request.split('=')[1].strip
						message = parseRequest.split(' HTTP')[0]
						checkHELO = message.split('%20')[0].strip
						if checkHELO == 'HELO' 
							if message == 'HELO'
								STDERR.puts 'Missing HELO text'
								response = "#{message}\nIP:#{client.peeraddr[2]}\nPort:#{client.peeraddr[1]}\nStudentID:\n"
							else
								heloMessage = message.split('HELO')[1].strip
								STDERR.puts 'HELO message recieved'
								response = "#{message}\nIP:#{client.peeraddr[2]}\nPort:#{client.peeraddr[1]}\nStudentID:\n"
							end
						end
						if message == 'KILL_SERVICE'
							STDERR.puts 'Kill status recieved, shutting down.'
							response = 'Kill status recieved, server has been shut down.'
							kill = true
						end
						STDERR.puts 'Request: ' + request
						STDERR.puts 'Message: ' + message
						STDERR.puts ' '
						client.puts response 
						client.close
						puts "Client disconnected."
						if kill == true
							exit
						end
					end
				end
				rescue ThreadError
			end
		end
	end; "ok"
	pool.map(&:join); "ok"
end
