# Twitter News Analytics

Twitter News Analytics uses data from twitter to determine the relevance/popularity of CNN's top news stories. The project gets
the number of tweets of a news story and compares the tweet pattern to the average CNN top story. The algorithm then gives it a score.
The score is what determines the overall weight of the news story. The higher the score, the more prevalent the news story


## Files

This section tells you about the role of each of the above r scripts.

### RSSKeyWords - Completed

This file parses the data comping in from the RSS feed at CNN. It extracts the title, description, and pulbication date of every 
news story. After parsing the data, it filters out irrelevant words for.

This file is complete.

### TweetCollection - Partially Completed

TweetCollection gathers and parses the Tweets pertaining to each of the news stories. As of now, the search query is a simplified version of the news title.

In the future, I wish to add more searching capabilities to look at relevant Tweets that do not contain the title of the news story.


### Analysis - In Progress

Analysis generates a relevance score based on the pattern and frequency of relevant Tweets. It is not functional right now. 

