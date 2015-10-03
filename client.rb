require 'socket'

host = 'localhost'                  # The web server
port = 2000                         # Default HTTP port
path = "/index.html"                # The file we want

# This is the HTTP request we send to fetch a file
request = "GET #{path} HTTP/1.1\r\nHost: #{host}:#{port}\r\n\r\n"
puts request

socket = TCPSocket.open(host, port)  # Connect to server
socket.print(request)               # Send request
response = socket.read              # Read complete response

puts response

# Split response at first blank line into headers and body
headers,body = response.split("\r\n\r\n", 2)

status = headers.scan(/HTTP.1.\d\s+(\d+)\s+\w*/).first.first
info = headers.scan(/HTTP.1.\d\s+\d+\s+(\w*)/).first.first

if (status == "200")
  puts body
else
  puts info
end
