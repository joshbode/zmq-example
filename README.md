Installation
------------

1. Install [ØMQ](http://zeromq.org/) library:
      - Linux (on [Debian](http://debian.org/)):

            $ apt-get install libzmq-dev

      - OS X (using [homebrew](http://brew.sh/)):

            $ brew install zeromq
            $ brew tap bertjwregeer/homebrew-compat
            $ brew install cppzmq  # required for rzmq

2. Install [Python](http://python.org/) ØMQ bindings:

        $ pip install pyzmq

3. Install [Julia](http://julialang.org/) ØMQ bindings:

        $ julia

        julia> Pkg.add("ZMQ")
        julia> Pkg.add("Logging")  # required for example only

4. Install [R](http://r-project.org/) ØMQ bindings:

        $ R

        > install.packages("rzmq")
        > install.packages(c("logging", "rjson"))  # required for example only

5. Install [supervisord](http://supervisord.org/):

        $ pip install supervisord


Running
-------

1. Clone this repository.

2. Start `supervisord` using the provided configuration:

        $ supervisord -c zmq-example/supervisord.conf

3. Connect to the [supervisor management page](http://localhost:9001/)

4. Tail the processes to see the log output.

5. When finished, shutdown `supervisord` using `supervisorctl`:

        $ supervisorctl shutdown
