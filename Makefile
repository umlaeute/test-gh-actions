default: test

.PHONY: default check clean

check: test
	./$<

clean:
	rm -f test
