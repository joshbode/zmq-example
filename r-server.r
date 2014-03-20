#!/usr/bin/env Rscript

library(logging)
library(rjson)
library(rzmq)

argv = commandArgs(TRUE)

BASE_PORT = as.integer(argv[1])
WORKER = as.integer(argv[2])
PORT = BASE_PORT + WORKER

logging::basicConfig(level=logging::loglevels['DEBUG'])

context = rzmq::init.context()

socket = rzmq::init.socket(context, 'ZMQ_REP')
rzmq::bind.socket(socket, sprintf('tcp://*:%d', PORT))

logging::loginfo("Ready")

while (TRUE) {
    data = rjson::fromJSON(rawToChar(rzmq::receive.socket(socket, unserialize=FALSE)))
    logging::loginfo(sprintf("Received: [%s]", paste0(data, collapse=', ')))
    result = list("mean", sprintf("R (%02d)", WORKER), mean(data))
    rzmq::send.socket(socket, charToRaw(rjson::toJSON(result)), serialize=FALSE)
    logging::loginfo(sprintf("Sent: %s", toString(result)))
}
