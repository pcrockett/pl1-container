# PL/I Container

A Docker container for a certain retired PL/I programmer I know who still wants to play with PL/I.

**Current status:** Proof-of-concept. Needs more work to make it practical.

## Getting Started

Install Docker and clone this repo. Then run:

```bash
make
```

This will build a Docker image and drop you into a shell where the [Iron Spring PL/I compiler](http://www.iron-spring.com/index.html)
is installed.

## TODO

* [ ] figure out a good way to run the compiler against files in your working directory _outside_
  the container.
* [ ] build the container with CI/CD and publish it so you don't have to build it on your machine

## Links

* <http://www.iron-spring.com/doc.html>
