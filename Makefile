# vim:ft=make:

.PHONY : all start

all: build

build:
		docker build -t kali-sandbox .

clean:
		docker rmi kali-sandbox

start:
		docker run --rm -it -p 9020:8080 -p 9021:5900 --name kali-sandbox kali-sandbox

stop:
		docker rm -f kali-sandbox

browser:
		browse 'http://localhost:9020/vnc.html' | sh -e
