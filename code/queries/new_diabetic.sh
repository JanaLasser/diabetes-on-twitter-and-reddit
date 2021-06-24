#!/bin/bash
twarc2 search --start-time 2006-03-21 --end-time 2021-06-18 --archive '("new diabetic" OR "New diabetic" OR "NEW DIABETIC") lang:en' > ../../data/new_diabetic.jsonl
