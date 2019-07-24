# marketing-channel-attribution
Following this [Medium tutorial](https://medium.com/@mortenhegewald/marketing-channel-attribution-using-markov-chains-101-in-python-78fb181ebf1e) about `Marketing Channel Attribution with Markov Chains in Python`

**NOTE:** Docker files is copied from this [repository](https://github.com/jeffheaton/docker-jupyter-python-r) and code taken directly from the tutorial with few modifications/fixes.

## Clone and build docker image

```bash
$ git clone https://github.com/mohan3d/marketing-channel-attribution.git
$ cd marketing-channel-attribution
$ docker build -t "mca" .
```

## Run
```bash
$ docker run -it --rm -p 8888:8888 mca
```

Then open http://localhost:8888 and use provided token.
