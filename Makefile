.PHONY: build test serve stop deps npm-deps

DOMAIN=http://localhost:8775/
PHANTOMPATH=`pwd`/tests/bin/phantomjs
NGINX_PATH=`readlink -f nginx-1*/objs/nginx`
SRC:=`pwd`/
JS_PATH:=`pwd`/www/js/

-include CONFIG

build: deps npm-deps serve

clean:
	rm -rf nginx-1* phantomjs-2* tests/bin/phantomjs tests/output/* vendor/*

deps:
	ln -s $(SRC)node_modules/jquery/dist/jquery.min.js $(JS_PATH)lib/jquery.min.js
	#browserify www/js/app.js -o www/js/bundle.js
	rm -rf ${HOME}/.virtualenv
	which python3
	virtualenv -p `which python3` "${HOME}/.virtualenv"
	pip3 install -U -r `pwd`/requirements.txt
	npm install

test: test-js
	py.test tests/
	${NGINX_PATH} -t -c `pwd`/conf/nginx.conf

test-js:
	npm test

serve:
	rm -f /tmp/www
	ln -s `pwd`/www /tmp/www
	${NGINX_PATH} -c `pwd`/conf/nginx.conf
	ps waux | grep nginx
	# server may be up and running now

stop:
	${NGINX_PATH} -c `pwd`/conf/nginx.conf -s stop
	ps waux | grep nginx

reload:
	${NGINX_PATH} -c `pwd`/conf/nginx.conf -s reload
	ps waux | grep nginx

phantomjs: tests/bin/phantomjs

tests/bin/phantomjs:
	mkdir -p vendor
	wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-x86_64.tar.bz2 -P ./vendor
	tar -xvf ./vendor/phantomjs-2.1.1-linux-x86_64.tar.bz2 -C ./vendor/
	mkdir -p tests/bin/
	mkdir -p tests/output/
	ln -s `pwd`/vendor/phantomjs-2.1.1-linux-x86_64/bin/phantomjs ${PHANTOMPATH}