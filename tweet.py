import json
import tweepy
from csv import writer
from datetime import datetime

# Need to change country name to get tweets of different countries
COUNTRY='Republic of India'
CONSUMER_KEY=''
CONSUMER_SECRET=''
ACCESS_KEY=''
ACCESS_SECRET=''
auth=tweepy.OAuthHandler(CONSUMER_KEY,CONSUMER_SECRET)
auth.set_access_token(ACCESS_KEY,ACCESS_SECRET)
api=tweepy.API(auth)
places=api.geo_search(query=COUNTRY,granularity="country")
place_id = places[0].id
# maximum number of tweets to be acquired
max_tweets = 1000
searched_tweets = []
last_id = -1
# current date and time to be used for file name
FORMAT = '%m%d%H%M'
now = datetime.now().strftime(FORMAT)

while len(searched_tweets) < max_tweets:
        count = max_tweets - len(searched_tweets)
        try:
                # get English tweets only from specific country
                new_tweets = api.search(q="place:%s" % place_id, count=count, max_id=str(last_id - 1), lang="en")
                if not new_tweets:
                        break
                searched_tweets.extend(new_tweets)
                last_id = new_tweets[-1].id
        except tweepy.TweepError as e:
                break

# output csv file with country name, date and time
with open("tweets_" + COUNTRY + now + ".csv", 'wb') as outfile:
        # column names
        print >> outfile, 'id, created_at, lang, user.followers_count, user.screen_name, place, text'
        csv = writer(outfile)
        for tweet in searched_tweets:
                mystring = tweet.text
                # remove change line, comma and double quotation from tweeted text for R to properly show each data
                mystring = mystring.replace('\n', ' ').replace(',', ' ').replace('\"', ' ')
                # designate JSON attributes to retrieve
                row = (
                        tweet.id,
                        tweet.created_at,
                        tweet.lang,
                        tweet.user.followers_count,
                        tweet.user.screen_name,
                        tweet.place.name,
                        mystring
                        )
                values = [(value.encode('utf8') if hasattr(value, 'encode') else value) for value in row]
                csv.writerow(values)
                csv.writerow("")
