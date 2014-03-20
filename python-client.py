#!/usr/bin/env python

import sys
import time
import logging
import random

import zmq

BASE_PORT = int(sys.argv[1])
WORKERS = int(sys.argv[2])

logging.basicConfig(
    datefmt="%Y-%m-%d %H:%M:%S",
    format="%(asctime)s %(name)s %(levelname)s: %(message)s",
    level=logging.DEBUG
)


def main():
    """Main function."""

    context = zmq.Context()

    time.sleep(1)
    socket = context.socket(zmq.REQ)
    for offset in range(WORKERS):
        socket.connect("tcp://localhost:{0}".format(BASE_PORT + offset))

    while True:
        data = random.sample(range(100), 10)
        socket.send_json(data)
        logging.info("Sent: {0}".format(data))
        result_type, worker, result = socket.recv_json()
        logging.info(
            "Received: {0}: {1}: {2}".format(result_type, worker, result)
        )
        time.sleep(1)

if __name__ == '__main__':
    main()
