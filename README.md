Installation
------------

- Install [ØMQ](http://zeromq.org/) library:

      - Linux (on [Debian](http://debian.org/)):

            $ apt-get install libzmq-dev

      - OS X (using [homebrew](http://brew.sh/)):

            $ brew install zeromq

- Install [Python](http://python.org/) ØMQ bindings:

        $ pip install pyzmq supervisord

- Install [Julia](http://julialang.org/) ØMQ bindings:

        $ julia

        julia> Pkg.add("ZMQ")
        julia> Pkg.add("Logging")  # required for example only

Running
-------

1. Start `supervisord` using the provided configuration:

        $ supervisord -c ~/zmq-test/supervisord.conf

2. Connect to the [supervisor management page](http://localhost:9001/)

3. Tail the processes to see the log output.

4. Shutdown `supervisord` using `supervisorctl`:

        $ supervisorctl shutdown