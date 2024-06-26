#!/bin/sh

# Copyright 2021 Google LLC
#
# This library is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# This library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this library; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA

if [ -z "$CI" ]; then
	DOCKER_INTERACTIVE_OPTS="-it"
else
	DOCKER_INTERACTIVE_OPTS=""
fi

echo "Build"
docker build -t web-gphoto2 - <Dockerfile

echo "prepare cache"
mkdir -p deps/.emcache

echo "run"
docker run --rm $DOCKER_INTERACTIVE_OPTS \
	-u $(id -u):$(id -g) \
	-v $PWD:/src \
	-v $PWD/deps/.emcache:/emsdk/upstream/emscripten/cache \
	web-gphoto2 \
	$@
