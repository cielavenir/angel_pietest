.PHONY: clean
all: testa.exe testb.exe
CC=gcc
CFLAGS=-std=c99 -fpic
libtest1.a: test1.o
	ar r $@ $<
libtest2.a: test2.o
	ar r $@ $<
libtest1.so: test1.o
	$(CC) -shared $(CFLAGS) -o $@ $<
libtest2.so: test2.o
	$(CC) -shared $(CFLAGS) -o $@ $<
libhoge1a.so: hoge1.c libtest1.so
	$(CC) -shared $(CFLAGS) -o $@ hoge1.c -L. -ltest1
libhoge2a.so: hoge2.c libtest2.so
	$(CC) -shared $(CFLAGS) -o $@ hoge2.c -L. -ltest2
libhoge1b.so: hoge1.c libtest1.so
	$(CC) -pie -rdynamic $(CFLAGS) -DUSE_PIE -o $@ hoge1.c -L. -ltest1
libhoge2b.so: hoge2.c libtest2.so
	$(CC) -pie -rdynamic $(CFLAGS) -DUSE_PIE -o $@ hoge2.c -L. -ltest2
testa.exe: main.o libhoge1a.so libhoge2a.so
	$(CC) -o $@ main.o -L. -Wl,-rpath,. -lhoge1a -lhoge2a
testb.exe: main.o libhoge1b.so libhoge2b.so
	$(CC) -o $@ main.o -L. -Wl,-rpath,. -lhoge1b -lhoge2b
clean:
	rm -f *.o *.a *.so *.exe
