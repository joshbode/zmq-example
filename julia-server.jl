#!/usr/bin/env julia

using JSON
using ZMQ
using Logging

PORT = 5555

Logging.configure(level=Logging.DEBUG)

context = ZMQ.Context(1)

socket = ZMQ.Socket(context, ZMQ.REP)
ZMQ.bind(socket, "tcp://*:$PORT")

Logging.info("Ready")

while true
    data = ZMQ.recv(socket)
    data = JSON.parse(takebuf_string(convert(IOStream, data)))
    Logging.info("Received: [", join(data, ", "), "]")
    result = std(data)
    ZMQ.send(socket, JSON.json(result))
    Logging.info("Sent: $result")
end
