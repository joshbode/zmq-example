#!/usr/bin/env julia

using JSON
using ZMQ
using Logging

BASE_PORT = int(ARGS[1])
WORKER = int(ARGS[2])
PORT = BASE_PORT + WORKER

Logging.configure(level=Logging.DEBUG)

context = ZMQ.Context(1)

socket = ZMQ.Socket(context, ZMQ.REP)
ZMQ.bind(socket, "tcp://*:$PORT")

Logging.info("Ready")

while true
    data = ZMQ.recv(socket)
    data = JSON.parse(takebuf_string(convert(IOStream, data)))
    Logging.info("Received: [", join(data, ", "), "]")
    result = ["std", @sprintf("Julia (%02d)", WORKER), std(data)]
    ZMQ.send(socket, JSON.json(result))
    Logging.info("Sent: $result")
end
