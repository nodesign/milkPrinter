import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import java.util.*;

boolean offline = false;

Twitter twitter;
String searchString = "nodesign";
List<Status> tweets;
boolean tweetLoaded=false;
int currentTweet;

PFont font;

int resolutionMultiplier = 3;

int margins =  18  *resolutionMultiplier;
int fontSize = 21  *resolutionMultiplier;
int leading =  16  *resolutionMultiplier;

PImage logo;

boolean print = false;

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


  String[] fontList = PFont.list();
  for (int i=0; i<fontList.length; i++) println(fontList[i]);


  font = createFont("Helvetica-Bold", fontSize);
  textFont(font);  

  size(210*resolutionMultiplier, 297*resolutionMultiplier);
  //smooth();
  noLoop();
  logo = loadImage("milk2.jpg");
} 

void draw() {
  background(255);

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


  fill(0);
  textAlign(LEFT, LEFT);
  textLeading(leading);
  text(tweet, margins, margins, width-margins*2, height-margins*2);

  float w = logo.width/(4.0-resolutionMultiplier);
  float h = logo.height/(4.0-resolutionMultiplier);
  image(logo, (width-w)/2.0, height-h-margins/2.0, w, h);
  if (print) {
    calculatePoints();
    print = false;
  }
  
}

void calculatePoints() {
  for (int i=0; i<height; i++) {
    for (int j=0; j<width; j++) {

      color a = get(j, i);
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

