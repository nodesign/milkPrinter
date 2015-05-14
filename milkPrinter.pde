import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

boolean offline = true;

Twitter twitter;
String searchString = "nodesign";
List<Status> tweets;
boolean tweetLoaded=false;
int currentTweet;

PFont font;

int resolutionMultiplier = 1;

int margins =  18  *resolutionMultiplier;
int fontSize = 21  *resolutionMultiplier;
int leading =  16  *resolutionMultiplier;

PImage logo;
PGraphics pg;
boolean print = false;

PImage printImage;

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
    println("tweets" + str(tweets.size()));

    currentTweet = 0;
  }


  //String[] fontList = PFont.list();
 // for (int i=0; i<fontList.length; i++) println(fontList[i]);


  size(210*resolutionMultiplier, 297*resolutionMultiplier);
  pg = createGraphics(210*resolutionMultiplier, 297*resolutionMultiplier);
  


  font = createFont("Helvetica-Bold", fontSize);
  pg.textFont(font);  

  //smooth();
  noLoop();
  logo = loadImage("milk2.jpg");
} 

void draw() {
  pg.beginDraw();
  pg.background(255);

  String tweet;
  if (!offline) {
    println(currentTweet);
    Status status = tweets.get(currentTweet);
    tweet  = "@"+status.getUser().getScreenName()+": "+status.getText();

    println(tweet);
  } 
  else {
    tweet = "There are two moralities - that of the Master and that of the Slave. The words of Machiavelli are deemed evil only by the Slave";
  }


  pg.fill(0);
  pg.textAlign(LEFT, LEFT);
  pg.textLeading(leading);

  pg.text(tweet, margins, pg.height/4 , 100, pg.height-margins*2);

  float w = logo.width/(4.0-resolutionMultiplier);
  float h = logo.height/(4.0-resolutionMultiplier);
  pg.image(logo, (pg.width-w)/2.0, pg.height-h-margins/2.0-pg.height/8, w, h);
  pg.endDraw();
  
  
  image(pg, 0,0);
  
  
  if (print) {
    calculatePoints();
    print = false;
  }
  
}

void calculatePoints() {
  for (int i=0; i<pg.height; i++) {
    for (int j=0; j<pg.width; j++) {

      color a = pg.get(j, i);
      if (red(a) < 30) {
        float x = float(j)/float(resolutionMultiplier);
        float y = float(i)/float(resolutionMultiplier);
        //println(x, y);
      }
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


void keyReleased() {
  if (key==32) { //sapcebar
    if (currentTweet < tweets.size()-1) {
      currentTweet++;
    } 
    else {
      getNewTweets();
      currentTweet = 0;
    }
    println(currentTweet);
    redraw();
  }

  if ((key=='p') || (key=='P')) { //p
    print = true;
    redraw();
  }
}

