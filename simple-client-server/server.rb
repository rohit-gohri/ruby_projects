require 'socket'                # Get sockets from stdlib

server = TCPServer.open('localhost', 2000)   # Socket to listen on port 2000
loop {                                     # Servers run forever
  Thread.start(server.accept) do |client|
    request = client.gets
    path = "." + request.scan(/\s+((.\w+)+)\s+HTTP/).first.first
    puts path
    req = request.scan(/^(\w+)/).first.first

    if (req == "GET")
      if File.file?(path)
        response = "HTTP/1.1 200 OK\r\n"
        body = File.read(path)
      else
        response = "HTTP/1.1 404 Not Found\r\n"
        body = "\r\n"
      end

      response = response + "Date: " + Time.now.ctime + "\r\n" +
                "Content-type: text/#{File.extname(path)}\r\n"
      client.puts(response)
      client.puts body

      client.close                # Disconnect from the client
    end
  end
}
