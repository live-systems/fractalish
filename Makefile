.PHONY: build test serve

DOMAIN=http://localhost:8775/
PHANTOMPATH=tests/bin/phantomjs

-include CONFIG

build: deps serve

clean:
	rm -rf nginx-1* phantomjs-2* tests/bin/phantomjs tests/output/* vendor/*

deps:
	rm -rf ${HOME}/.virtualenv
	which python3
	virtualenv -p `which python3` "${HOME}/.virtualenv"
	pip3 install -U -r `pwd`/requirements.txt

test:
	py.test tests/
	`pwd`/nginx-1*/objs/nginx -t -c `pwd`/conf/nginx.conf

serve:
	rm -f /tmp/www
	ln -s `pwd`/www /tmp/www
	`pwd`/nginx-1*/objs/nginx -c `pwd`/conf/nginx.conf
	ps waux | grep nginx
	# server may be up and running now

stop:
	`pwd`/nginx-1*/objs/nginx -c `pwd`/conf/nginx.conf -s stop
	ps waux | grep nginx

reload:
	`pwd`/nginx-1*/objs/nginx -c `pwd`/conf/nginx.conf -s reload
	ps waux | grep nginx

phantomjs: tests/bin/phantomjs

tests/bin/phantomjs:
	mkdir -p vendor
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -P ./vendor
	tar -xvf ./vendor/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C ./vendor/
	mkdir -p tests/bin/
	mkdir -p tests/output/
	ln -s `pwd`/vendor/phantomjs-2.1.1-linux-x86_64/bin/phantomjs ${PHANTOMPATH}