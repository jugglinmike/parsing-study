http: lex.yy.c http.tab.c http.tab.h
	g++ http.tab.c lex.yy.c -lfl -o http

http.tab.c http.tab.h: http.y
	bison -d http.y

lex.yy.c: http.l http.tab.h
	flex http.l

non-existent:

%.http: http non-existent
	cat $@ | ./http

.PHONY: test
test: http test/positive/*.http
