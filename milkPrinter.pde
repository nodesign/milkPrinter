import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

import geomerative.*;

boolean offline = true;

Twitter twitter;
String searchString = "weio";
List<Status> tweets;
boolean tweetLoaded=false;
int currentTweet;
int size = 20;


int leftMargin = 30;
int rightMargin = 30;

ArrayList<SVGReader> shp = new ArrayList<SVGReader>();
Map<String, Integer> kernTable = new HashMap<String, Integer>();

void setup() {

  initKernnings();

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
  size(210*2, 297*2);
  smooth();

  // VERY IMPORTANT: Allways initialize the library before using it
  RG.init(this);

  noLoop();
  //shp = RG.centerIn(shp, g);
} 

void draw() {
  background(255);
  if (tweetLoaded==false) {
    String tweet;
    if (!offline) {
      Status status = tweets.get(1);
      tweet  = status.getText(); //.toUpperCase();

      println(tweet);
    } 
    else {
      tweet = "There are two moralities - that of the Master and that of the Slave. The words of Machiavelli are deemed evil only by the Slave";
    }
    
    int acc = 0;
    for (int i=0; i<tweet.length(); i++) {
      char sel = tweet.charAt(i);
      float kerning = 0;

      if (i>0) {
        char sel2 = tweet.charAt(i-1); 
        print(sel + " " + sel2 + " ");
        kerning = map(getKerning(sel, sel2), -500, 500, -20, 20);
        println(size + kerning + " *******************************************" );
      } 
      
      acc += int(size + kerning);
      if ((sel>=65) && (sel<=127)) {   
         shp.add(new SVGReader(this, int(sel)+".svg", size, size, acc, height/2));
       }
    }

    for (int i=0;i<shp.size();i++) {
      SVGReader s = (SVGReader) shp.get(i);
      s.display(1, 0, 0);
    }
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



