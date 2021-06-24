#!/bin/bash
cat ../../data/diagnosed_user_IDs.txt | xargs -i sh -c "twarc2 timeline --end-time 2021-06-18 --exclude-retweets --exclude-replies --use-search {} > ../../data/user_timelines/{}.jsonl"
