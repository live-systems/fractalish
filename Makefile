.PHONY: build test serve

build: serve
	pip3 install pytest -U

test:
	py.test tests/
	nginx -t -c `pwd`/conf/nginx.conf

serve:
	ln -s www/ /tmp/www
	nginx -c `pwd`/conf/nginx.conf

stop:
	nginx -c `pwd`/conf/nginx.conf -s stop