install:
	@rsync -a . ~/ --exclude=Makefile --exclude=.git/
