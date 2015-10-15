class SERVER
	require 'thread'
	require 'socket'

	# Setup for server
	address = '0.0.0.0'
	port = ARGV[0] 
	server = TCPServer.open(address, port)
	puts "Server is running on #{address} on port #{port}." 
	student_id = "f3ddcabdebd2d7cfa6c080da06b2b657f36d2ef65406b6b19f3970161e1f5b09"

	# Thread pool queue
	thread_pool = Queue.new
	(0..50).to_a.each{|x| thread_pool.push x }
	# Maximum of four threads
	pool = (0...4).map do
		Thread.new do
			begin
				while x = thread_pool.pop(true)
					Thread.start(socket = server.accept) do |client|
						request = socket.gets
						puts "Client received."	
						# GET /echo.php?message=hello HTTP/1.0
						response = "Undefined, request error."
						# Parse the GET request
						parseRequest = request.split('=')[1].strip
						message = parseRequest.split(' HTTP')[0]
						checkHELO = message.split('%20')[0].strip
						if checkHELO == 'HELO' 
							# Minimal error handling
							if message == 'HELO'
								STDERR.puts 'Missing HELO text'
								response = "#{message}\nIP:#{client.peeraddr[2]}\nPort:#{client.peeraddr[1]}\nStudentID:#{student_id}\n"
							else
								heloMessage = message.split('HELO')[1].strip
								STDERR.puts 'HELO message recieved'
								response = "#{message}\nIP:#{client.peeraddr[2]}\nPort:#{client.peeraddr[1]}\nStudentID:#{student_id}\n"
							end
						end
						if message == 'KILL_SERVICE'
							STDERR.puts 'Kill status recieved, shutting down.'
							response = 'Kill status recieved, server has been shut down.'
							kill = true
						end
						# Send the response and close the connection
						STDERR.puts 'Request: ' + request
						STDERR.puts 'Message: ' + message
						STDERR.puts ' '
						client.puts response 
						client.close
						puts "Client disconnected."
						# Kill program if kill status was received
						if kill == true
							exit
						end
					end
				end
				rescue ThreadError
			end
		end
	end; "ok"
	# Put thread back into pool
	pool.map(&:join); "ok"
end
