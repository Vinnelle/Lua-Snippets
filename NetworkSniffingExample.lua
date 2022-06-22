local socket = require("socket")

-- Create a TCP socket and bind it to the local host, at port 8080
local server = assert(socket.bind("*", 8080))

-- Find out which port the OS chose for us
local ip, port = server:getsockname()

-- Print a message to the console
print("Please telnet to localhost on port " .. port)
print("After connecting, you will be able to type HTTP requests")

-- Loop forever waiting for clients
while 1 do
  -- Wait for a connection from any client
  local client = server:accept()

  -- Make sure we don't block waiting for this client's line
  client:settimeout(10)

  -- Receives the first line of the request (the Request-Line)
  local line, err = client:receive()

  -- If there was no error, send it back to the client
  if not err then
    client:send(line .. "\n")
  end

  -- Put it back in "nagle" mode
  client:settimeout(nil)

  -- Close the connection for this client
  client:close()
end
