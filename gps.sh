#!/usr/bin/env bash

git add . \
  && git commit -m "Updated action `date +%s%N`" \
  && git push
