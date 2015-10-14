class SERVER
	require 'thread'
	require 'socket'

	address = '0.0.0.0'
	port = ARGV[0] 
	server = TCPServer.open('0.0.0.0', port)
	puts "Server is running on #{address} on port #{port}." 

	work_q = Queue.new
	(0..50).to_a.each{|x| work_q.push x }
	workers = (0...4).map do
		Thread.start(socket = server.accept) do |client|
			request = socket.gets
			puts "Client received."
			begin
				while x = work_q.pop(true)
					# GET /echo.php?message=hello HTTP/1.0
					response = "Undefined, request error."
					parseRequest = request.split('=')[1].strip
					message = parseRequest.split(' HTTP')[0]
					checkHELO = message.split('%20')[0].strip
					if checkHELO == 'HELO' 
						heloMessage = message.split('HELO%20')[1].strip
					    sock_domain, remote_port, remote_hostname, remote_ip = client.peeraddr	
						STDERR.puts 'HELO message recieved'
						response = "#{message}\nIP:#{remote_ip}\nPort:#{remote_port}\nStudentID:\n"
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
				rescue ThreadError
			end
		end
	end; "ok"
	workers.map(&:join); "ok"
end