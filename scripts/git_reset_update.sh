#!/bin/bash

git reset --hard
git clean -fxd
git pull

flutter clean
flutter pub get
