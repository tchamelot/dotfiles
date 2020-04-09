install:
	@rsync -a . /tmp/tchamelot/ --exclude=Makefile --exclude=.git/
