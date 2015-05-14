import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

boolean offline = true;

Twitter twitter;
String searchString = "weio";
List<Status> tweets;
boolean tweetLoaded=false;
int currentTweet;


PFont font;

void setup() {

  if (!offline) { 
    ConfigurationBuilder cb = new ConfigurationBuilder();
    cb.setOAuthConsumerKey(OAuthConsumerKey);
    cb.setOAuthConsumerSecret(OAuthConsumerSecret);
    cb.setOAuthAccessToken(OAuthAccessToken);
    cb.setOAuthAccessTokenSecret(OAuthAccessTokenSecret);

    TwitterFactory tf = new TwitterFactory(cb.build());

    twitter = tf.getInstance();

    getNewTweets();

    currentTweet = 0;

    thread("refreshTweets");
  }
  
  
  String[] fontList = PFont.list();
  
  for (int i=0; i<fontList.length; i++) println(fontList[i]);

  
  font = createFont("Lato-Black", 64);
  textFont(font);  

  size(210*2, 297*2);
  smooth();
  noLoop();
} 

void draw() {
  background(255);
  if (tweetLoaded==false) {
    String tweet;
    if (!offline) {
      Status status = tweets.get(1);
      tweet  = status.getText();

      println(tweet);
    } 
    else {
      tweet = "There are two moralities - that of the Master and that of the Slave. The words of Machiavelli are deemed evil only by the Slave";
      fill(0);
      textAlign(CENTER,CENTER);
      text(tweet, 100, 100);
    }
  }
}



void getNewTweets()
{
  try 
  {
    Query query = new Query(searchString);

    QueryResult result = twitter.search(query);

    tweets = result.getTweets();
  } 
  catch (TwitterException te) 
  {
    System.out.println("Failed to search tweets: " + te.getMessage());
    System.exit(-1);
  }
}

void refreshTweets()
{
  while (true)
  {
    getNewTweets();

    println("Updated Tweets"); 

    delay(10000);
    redraw();
  }
}

