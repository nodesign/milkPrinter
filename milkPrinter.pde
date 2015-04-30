import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

import geomerative.*;

Twitter twitter;
String searchString = "weio";
List<Status> tweets;

int currentTweet;

RShape shp[] = new RShape[26];

void setup() {

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

  size(800, 800);
  smooth();

  // VERY IMPORTANT: Allways initialize the library before using it
  RG.init(this);

  for (int i=0;i<shp.length; i++) {
    String letter = str(65+i); 
    shp[i] = RG.loadShape(letter+".svg");
  }
  //shp = RG.centerIn(shp, g);
} 

void draw() {
  background(255);
  //translate(mouseX, mouseY);
  
  String b = "BOJANA";
  for (int i=0; i<b.length(); i++) {
    int sel = int(b.charAt(i));
    RG.shape(shp[sel-65], 20*i, height/2);
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

    delay(30000);
  }
}

