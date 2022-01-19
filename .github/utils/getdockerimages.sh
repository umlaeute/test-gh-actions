#!/bin/sh



filter() {
	sed \
		-e '/[^a-z]/d' \
		-e '/stable$/d' \
		-e '/^\(testing\|experimental\)$/d'
}
gettags() {
# get all available tags for the 'buildpack-deps' Docker image
curl -s "https://hub.docker.com/v2/repositories/library/${1}/tags?page_size=1000" | jq -r '.results[] | .name' | filter
}

getdist() {
   curl -s "${1}/dists/" | grep "href=" | sed -e 's|.*a href="||' -e 's|".*||' -e 's|/$||' | filter
}
getdists() {
	local url
	for url in "${@}"; do
		getdist "${url}"
	done
}

getall() {
	# available tags
	gettags buildpack-deps | sort -u
	# available dists
	getdists http://archive.ubuntu.com/ubuntu http://deb.debian.org/debian | sort -u
}

echo -n "["
getall | sort | uniq -d | while read x; do
	echo -n "${comma}"
	comma=","
	echo -n "  \"${x}\""
done
echo "]"
