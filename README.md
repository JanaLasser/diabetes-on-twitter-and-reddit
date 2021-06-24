# Diabetes discussion on social media
Investigation of how diabetes is discussed on social media and how the discussion changes the outcomes of people with diabetes.

## Data
### Reddit data

Data was collected using [Pushshift API](https://github.com/pushshift/api) and [psaw](https://github.com/dmarx/psaw) Python API wrapper. The data retrieval was done in ```
reddit_pushshift.ipynb```. The following search terms for used to find relevant comments from [r/diabetes](reddit.com/r/diabetes):

```
["diabetes",
"Diabetes",
"I was just diagnosed with diabetes",
"today I was diagnosed with diabetes",
"I just learned I have diabetes",
"learned I got diabetes",
"heard I got diabetes",
"learned I have diabetes",
"heard I have diabetes",
"I was recently diagnosed with diabetes",
"I recently learned I have diabetes",
"I recently learned that I have diabetes",
"new diabetic",
"New diabetic",
"NEW DIABETIC"]
```

For practical reasons, we limited our search to include messages that were posted after *January 1st 2020*.

The results are saved to `data/reddit_diagnosed_diabetes_clean.csv`. The colums are the same as what are returned by the Pushshift API.

#### Diagnosis time

Diagnosis time defined similarly as was done with Twitter.
The time of the diagnosis for each user was approxiamted by using the date of the first comment in the data set (in case of multiple comments in the data per user). The diagnosis date for each user is stored in the file `data/reddit_user_diagnosis_dates.csv`.

#### User comments

The usernames of accounts who have posted in *r/diabetes* after 1.1.2020 and their comment matched with our defined search criterio are liste in `data/reddit_diagnosed_user_IDs.txt`.

We sampled 175 users from this list to match the number of users found with similar methods from Twitter. The user comments across all subreddits were also collected via Pushshift API and `psaw`. Implementation is found in `code/reddit_get_user_comments.ipynb`.

All of the comments posted to reddit by these 175 users included in the sample are in `reddit_user_comments.csv`, which not included in this repository due to limitation in file size.

### Twitter data
#### Diagnosis tweets
Data was collected using the [twarc2 search](https://twarc-project.readthedocs.io/en/latest/twarc2/#search) utlility (see also ```queries/diagnosed_diabetes.sh``` and the script ```get_and_clean_twitter_data.ipynb```, section "Tweets from users that were just diagnosed with diabetes"), using the following search terms:

* "I was just diagnosed with diabetes" 
* "today I was diagnosed with diabetes"
* "I just learned I have diabetes"
* "learned I got diabetes"
* "heard I got diabetes"
* "learned I have diabetes"
* "heard I have diabetes"
* "I was recently diagnosed with diabetes"
* "I recently learned I have diabetes"
* "I recently learned that I have diabetes"

The raw json payloads from the Twitter v2 API are converted into a "flat" ```.csv``` file using the [twarc-csv](https://pypi.org/project/twarc-csv/) extension. The tweets were then cleaned, removing all Tweets containing the phrases "years ago", "yrs ago", "year ago", "YEARS AGO", "years today" and "flashback", since these were tweets in which users remembered a long-past diabetes diagnosis. In addition, all columns containing data not relevant to this analysis were dropped. The remaining tweet data set contains 224 tweets from 175 unique users and is stored under ```data/diagnosed_diabetes_clean.csv```. The data set includes the following columns (see field description for the "user timelines" table below for the majority of columns):

* ```attachments.media```: link to any attached media files.
* ```entities.mentions```: other Twitter accounts mentioned in the Tweet.

#### Diagnosis time
The time of the diagnosis for each user was approxiamted by using the date of the first tweet in the data set (in case of multiple tweets per user). The diagnosis date for each user is stored in the file ```data/user_diagnosis_dates.csv```.

#### User timelines
Data was collected using the [twarc2 timeline](https://twarc-project.readthedocs.io/en/latest/twarc2/#timeline) utlility (see also ```queries/diagnosed_user_timelines.sh``` and the script ```get_and_clean_twitter_data.ipynb```, section "user profiles"). The raw json payloads from the Twitter v2 API are converted into "flat" ```.csv``` files using the [twarc-csv](https://pypi.org/project/twarc-csv/) extension. Individual user timelines were combined into one big data table, containing all user timelines, identified by a unique user ID ```user_ID``` in the table. The table can be found at ```data/user_timelines.csv.xz``` (needs to be decompressed before accessing the data). The table contains the following columns (see also the [Twitter API v2 documentation](https://developer.twitter.com/en/docs/twitter-api/fields) for more details):

* ```author.created_at```: creation date of the user's Twitter account
* ```author.description```: description text of the user's Twitter account (at the time the data was downloaded?)
* ```author.id```: unique ID of the user account
* ```author.location```: location of the user account. This data only exists if the user made it available on their account.
* ```author.name```: name that is displayed for the user account when tweeting. Note: this name can be changed by the user.
* ```author.pinned_tweet_id```: ID of the tweet pinned to the user profile, if they have any.
* ```author.public_metrics.followers_count```: other users that follow the user's profile.
* ```author.public_metrics.following_count```: other users that the user follows.
* ```author.public_metrics.listed_count```: [unsure]: lists on which the user account appears on.
* ```author.public_metrics.tweet_count```: number of tweets that were tweeted from this user account.
* ```author.url```: url or the user profile.
* ```author.username```: unique name of the user account. Note: unlike the ```author.name```, this cannot be changed by the user.
* ```context_annotations```: context annotations made by some proprietary Twitter machine learning algorithm based on the Tweet's context.
* ```conversation_id```: ID of the conversation that the tweet belongs to. Can be used to retrieve all Tweets belonging to the same conversation.
* ```created_at```: creation date and time of the tweet.
* ```entities.annotations```: Entities that were recognized in the Tweet's text by some proprietary Twitter entity recognition algorithm.
* ```entities.cashtags```: List of cashtags in the tweet with their start and end character respective to the the tweet start.
* ```entities.hashtags```: List of hashtags in the tweet with their start and end character respective to the the tweet start.
* ```id```: unique ID of the Tweet.
* ```lang```: language of the Tweet, as inferred by some proprietary Twitter language recognition algorithm.
* ```possibly_sensitive```: flag that indicates whether the Tweet possibly contains sensitive content?
* ```public_metrics.like_count```: number of likes of the Tweet at the time the data was downloaded.
* ```public_metrics.quote_count```: number of quote Tweets mentioning this tweet at the time the data was downloaded.
* ```public_metrics.reply_count```: number of replies to the Tweet at the time the data was downloaded.
* ```public_metrics.retweet_count```: number of retweets of the Tweet at the time the data was downloaded.
* ```referenced_tweets```: IDs of Tweets this Tweet references or retweets.
* ```text```: Text of the Tweet.