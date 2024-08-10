# vim:ft=make:

.PHONY : all start github

all: github

build:
		docker build -t kali-sandbox .

github:
		docker pull ghcr.io/benjitrapp/boxed-kali:nightly
		docker run --rm -it -p 9020:8080 -p 9021:5900 ghcr.io/benjitrapp/boxed-kali:nightly kali

macm2:
		docker pull --platform linux/x86_64 ghcr.io/benjitrapp/boxed-kali:nightly
		docker run --rm -it -p 9020:8080 -p 9021:5900 ghcr.io/benjitrapp/boxed-kali:nightly kali

clean:
		docker rmi kali-sandbox

start:
		docker run --rm -it -p 9020:8080 -p 9021:5900 --name kali-sandbox kali-sandbox

stop:
		docker rm -f kali-sandbox

browser:
		browse 'http://localhost:9020/vnc.html' | sh -e
