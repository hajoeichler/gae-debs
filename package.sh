#! /bin/bash

version=1.6.5

log() {
    echo "$@"
}

clean() {
    log "Clean workdir"
    rm -rf "$work"
}

get() {
    log "Get gae - $version"
    if [ -e "$download/$version/appengine-java-sdk.zip" ]; then
        log "Already downloaded."
        return
    fi
    mkdir -p "$download/$version"
    cd "$download/$version"
    wget --output-document=appengine-java-sdk.zip http://googleappengine.googlecode.com/files/appengine-java-sdk-"${version}".zip
}

extract() {
    log "Extract zip"
    mkdir -p "$work"
    unzip -q "$download/$version/appengine-java-sdk.zip" -d "$work"
}

set_version() {
    log "Set version"
    sed -i "s/@VERSION@/${version}/g" "${debian}/debian/changelog"
}

package() {
    log "Package as debian - $version"
    cd ${debian}
    debuild --set-envvar="GAE_HOME=${work}/appengine-java-sdk-${version}" -uc -us -b
}

base=$(dirname $(readlink -f "$0"))
work="$base/work"
download="$base/download"
debian="$base/gae-java"

set -e

clean
get
extract
set_version
package
