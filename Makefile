RUBY_VERSION := $(shell cat .ruby-version)

serve: 
	bundle exec jekyll serve -P 3001 -l

build: install-bundle
	bundle exec jekyll build --baseurl "/"

use-ruby: 
	rvm use $(RUBY_VERSION) --install

install-bundle:
	bundle install

clean:
	bundle exec jekyll clean

update-bundler:
	gem install bundler

update-gems:
	bundle update

update: update-gems update-bundler

