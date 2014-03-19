#!/usr/bin/env python

import time
import logging
import random

import zmq

PORT = 5555


def main():
    """Main function."""

    logging.basicConfig(
        datefmt="%Y-%m-%d %H:%M:%S",
        format="%(asctime)s %(name)s %(levelname)s: %(message)s",
        level=logging.DEBUG
    )

    context = zmq.Context()

    socket = context.socket(zmq.REQ)
    socket.connect("tcp://localhost:{0}".format(PORT))

    while True:
        time.sleep(1)
        data = random.sample(range(100), 10)
        socket.send_json(data)
        logging.info("Sent: {0}".format(data))
        result = socket.recv_json()
        logging.info("Received: {0}".format(result))

if __name__ == '__main__':
    main()
