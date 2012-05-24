#! /usr/bin/make

$(if $(GAE_HOME),,$(error GAE_HOME environment variable not set!))

clean:
	echo "Cleaning..."

	rm -rf debian/debhelper.log

compile:
	echo "Nothing to compile here."

install:
	echo "Install to $(DESTDIR)"

	# copy libraries
	mkdir -p "$(DESTDIR)/usr/share/gae"
	cp -r "$(GAE_HOME)/lib/"* "$(DESTDIR)/usr/share/gae/"
	# copy binaries
	mkdir -p "$(DESTDIR)/usr/bin"
	cp "$(GAE_HOME)/bin/appcfg.sh" "$(DESTDIR)/usr/bin/"
	# copy config
	mkdir -p "$(DESTDIR)/etc/gae"
	cp -r "$(GAE_HOME)/config/"* "$(DESTDIR)/etc/gae/"
	# patch scripts
	sed -i -e 's;SDK_LIB=.*;SDK_LIB="/usr/share/gae";g' "$(DESTDIR)/usr/bin/appcfg.sh"
