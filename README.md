## Oracle SqlPlus in docker

The Makefile has two real targets, 'build' and 'test'. Build does what it says on the tin, but test does something special -- it runs up a local oracle-xe container, logs in, runs 'select * from dual', and checks for errors.
