import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

import geomerative.*;

Twitter twitter;
String searchString = "weio";
List<Status> tweets;
boolean tweetLoaded=false;
int currentTweet;

ArrayList<SVGReader> shp = new ArrayList<SVGReader>();

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

  noLoop();
  //shp = RG.centerIn(shp, g);
} 

void draw() {
  //background(255);
  if(tweetLoaded==false){
  Status status = tweets.get(1);
  String tweet  = status.getText(); //.toUpperCase();
  
  println(tweet);
  
  for (int i=0; i<tweet.length(); i++) {
    int sel = int(tweet.charAt(i));
    if ((sel>=65) && (sel<=127)) { 
       shp.add(new SVGReader(this,sel+".svg", 10, 10,  10*i, height/2)); 
 
    }
      
  }
  
  for(int i=0;i<shp.size();i++){
   SVGReader s = (SVGReader) shp.get(i);
   s.display(1,0,0);}
   tweetLoaded=true;
 
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

    delay(500);
    redraw();
  }
}

