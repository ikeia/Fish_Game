import com.pubnub.api.builder.dto.*;
import com.pubnub.api.builder.*;
import com.pubnub.api.callbacks.*;
import com.pubnub.api.endpoints.access.*;
import com.pubnub.api.endpoints.channel_groups.*;
import com.pubnub.api.endpoints.*;
import com.pubnub.api.endpoints.files.*;
import com.pubnub.api.endpoints.files.requiredparambuilder.*;
import com.pubnub.api.endpoints.message_actions.*;
import com.pubnub.api.endpoints.objects_api.members.*;
import com.pubnub.api.endpoints.objects_api.memberships.*;
import com.pubnub.api.endpoints.objects_api.spaces.*;
import com.pubnub.api.endpoints.objects_api.users.*;
import com.pubnub.api.endpoints.presence.*;
import com.pubnub.api.endpoints.pubsub.*;
import com.pubnub.api.endpoints.push.*;
import com.pubnub.api.endpoints.remoteaction.*;
import com.pubnub.api.endpoints.vendor.*;
import com.pubnub.api.enums.*;
import com.pubnub.api.interceptors.*;
import com.pubnub.api.managers.*;
import com.pubnub.api.managers.token_manager.*;
import com.pubnub.api.models.consumer.access_manager.*;
import com.pubnub.api.models.consumer.access_manager.v3.*;
import com.pubnub.api.models.consumer.channel_group.*;
import com.pubnub.api.models.consumer.files.*;
import com.pubnub.api.models.consumer.history.*;
import com.pubnub.api.models.consumer.message_actions.*;
import com.pubnub.api.models.consumer.objects_api.member.*;
import com.pubnub.api.models.consumer.objects_api.membership.*;
import com.pubnub.api.models.consumer.objects_api.*;
import com.pubnub.api.models.consumer.objects_api.space.*;
import com.pubnub.api.models.consumer.objects_api.user.*;
import com.pubnub.api.models.consumer.objects_api.util.*;
import com.pubnub.api.models.consumer.*;
import com.pubnub.api.models.consumer.presence.*;
import com.pubnub.api.models.consumer.pubsub.*;
import com.pubnub.api.models.consumer.pubsub.files.*;
import com.pubnub.api.models.consumer.pubsub.message_actions.*;
import com.pubnub.api.models.consumer.pubsub.objects.*;
import com.pubnub.api.models.consumer.push.payload.*;
import com.pubnub.api.models.consumer.push.*;
import com.pubnub.api.models.server.access_manager.*;
import com.pubnub.api.models.server.access_manager.v3.*;
import com.pubnub.api.models.server.*;
import com.pubnub.api.models.server.files.*;
import com.pubnub.api.models.server.objects_api.*;
import com.pubnub.api.models.server.presence.*;
import com.pubnub.api.models.*;
import com.pubnub.api.*;
import com.pubnub.api.services.*;
import com.pubnub.api.vendor.*;
import com.pubnub.api.workers.*;
import okhttp3.logging.*;
import retrofit2.converter.gson.*;
import com.google.gson.*;
import com.google.gson.stream.*;
import com.google.gson.reflect.*;
import com.google.gson.internal.*;
import com.google.gson.internal.reflect.*;
import com.google.gson.internal.bind.*;
import com.google.gson.internal.bind.util.*;
import com.google.gson.annotations.*;
import retrofit2.*;
import retrofit2.http.*;
import retrofit2.internal.*;
//import org.slf4j.event.*;
//import org.slf4j.helpers.*;
//import org.slf4j.*;
//import org.slf4j.spi.*;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.databind.annotation.*;
import com.fasterxml.jackson.databind.cfg.*;
import com.fasterxml.jackson.databind.deser.*;
import com.fasterxml.jackson.databind.deser.impl.*;
import com.fasterxml.jackson.databind.deser.std.*;
import com.fasterxml.jackson.databind.exc.*;
import com.fasterxml.jackson.databind.ext.*;
import com.fasterxml.jackson.databind.introspect.*;
import com.fasterxml.jackson.databind.jsonFormatVisitors.*;
import com.fasterxml.jackson.databind.jsonschema.*;
import com.fasterxml.jackson.databind.jsontype.*;
import com.fasterxml.jackson.databind.jsontype.impl.*;
import com.fasterxml.jackson.databind.module.*;
import com.fasterxml.jackson.databind.node.*;
import com.fasterxml.jackson.databind.ser.*;
import com.fasterxml.jackson.databind.ser.impl.*;
import com.fasterxml.jackson.databind.ser.std.*;
import com.fasterxml.jackson.databind.type.*;
import com.fasterxml.jackson.databind.util.*;
import com.fasterxml.jackson.dataformat.cbor.*;
import org.jetbrains.annotations.*;
import org.intellij.lang.annotations.*;
//import org.json.*;
import okhttp3.*;
import okhttp3.internal.http1.*;
import okhttp3.internal.cache.*;
import okhttp3.internal.connection.*;
import okhttp3.internal.platform.*;
import okhttp3.internal.http2.*;
import okhttp3.internal.tls.*;
import okhttp3.internal.http.*;
import okhttp3.internal.*;
import okhttp3.internal.ws.*;
import okhttp3.internal.annotations.*;
import okhttp3.internal.cache2.*;
import okhttp3.internal.io.*;
import okhttp3.internal.publicsuffix.*;
import okhttp3.internal.proxy.*;
import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.core.*;
import com.fasterxml.jackson.core.async.*;
import com.fasterxml.jackson.core.base.*;
import com.fasterxml.jackson.core.filter.*;
import com.fasterxml.jackson.core.format.*;
import com.fasterxml.jackson.core.io.*;
import com.fasterxml.jackson.core.json.*;
import com.fasterxml.jackson.core.json.async.*;
import com.fasterxml.jackson.core.sym.*;
import com.fasterxml.jackson.core.type.*;
import com.fasterxml.jackson.core.util.*;
import okio.*;
import java.util.Arrays;
import java.util.List;

//import org.slf4j.impl.StaticLoggerBinder;


String publishChannel = "Food";
String pubKey = "pub-c-0df1aec4-4620-4f0b-af08-11a8c38d69c7";
String subKey = "sub-c-c008e100-00ef-11eb-81c8-6616e216ad91";
String myID = "player0";



PNConfiguration pnConfiguration;
PubNub pubnub;


//This variable is used to hold the messages that are published
JSONObject sendMessage = new JSONObject();
String messageKey1 = "x";
String messageKey2 = "y";
String messageKey3 = "food";
String messageKey4 = "color";



//This array holds all of the incoming messages that are received
ArrayList<PNMessageResult> allReceivedMessages = new ArrayList<PNMessageResult>(); 



void connectToPubNub()
{
    //create a new configuration and set the values  
    pnConfiguration = new PNConfiguration();
    pnConfiguration.setSubscribeKey(subKey);
    pnConfiguration.setPublishKey(pubKey);
    pnConfiguration.setSecure(true);
    pnConfiguration.setUuid(myID);
    
    //create the connection to Pubnub using those values
    pubnub = new PubNub(pnConfiguration);
    
    //subscribe to 
    pubnub.subscribe()
    .channels(Arrays.asList(publishChannel)) // subscribe to channels
    .execute();
   
    //add a listener to the channel and assign the readIncoming function to handle the messages
    pubnub.addListener(readIncoming);
    
}





//this function handles all incoming messages

SubscribeCallback readIncoming = new SubscribeCallback() 
{

    @Override
    public void message(PubNub pubnub, PNMessageResult inMessage) 
    {
        //println("Message publisher: " + messagePublisher);
        //println("Message Payload: " + message.getMessage());

        //add the message to the arrayList
        allReceivedMessages.add(inMessage);
        
        
    }
    
    //These functions must be defined as they represent all the other functionality possible
    //but we aren't using them. Leave them here
    public void user(PubNub pubnub, PNUserResult pnUserResult){}
    public void file(PubNub pubnub, PNFileEventResult pnFileEventResult){}
    public void space(PubNub pubnub, PNSpaceResult pnSpaceResult){}
    public void membership(PubNub pubnub, PNMembershipResult pnMembershipResult){}
    public void status(PubNub pubnub, PNStatus status) {}
    public void presence(@NotNull PubNub pubnub, @NotNull PNPresenceEventResult presence) {}
    public void signal(PubNub pubnub, PNSignalResult pnSignalResult) {}
    public void messageAction(PubNub pubnub, PNMessageActionResult pnActionResult) {}
    

};


//function that handles the incoming
 void handleMessageData(PNMessageResult thisMessage){
  
  //https://www.javadoc.io/doc/com.google.code.gson/gson/2.6.2/com/google/gson/JsonPrimitive.html
  
   //reading the message Values
  String sender = thisMessage.getPublisher();
  int xCoordinate =  thisMessage.getMessage().getAsJsonObject().get(messageKey1).getAsInt();
  int yCoordinate =  thisMessage.getMessage().getAsJsonObject().get(messageKey2).getAsInt();
  boolean food = thisMessage.getMessage().getAsJsonObject().get(messageKey3).getAsBoolean();
  color co = thisMessage.getMessage().getAsJsonObject().get(messageKey4).getAsInt();
  //print(food);
  if (food){
    food_added += 1;
   for (int i = 0; i < fish_food.length; i++) {
    if (fish_food[i] == null){fish_food[i] = new food(xCoordinate, yCoordinate, 40, i, fish_food,co);allReceivedMessages.clear();break;}
      }
  }
  
  
  
  //fill(255,0,0);
  //ellipse(xCoordinate,yCoordinate,20,20);
  
  
  
  
      }







//this function sends messages
void sendMessage()
{
 
 JsonObject pnMessage = new JsonObject();    //create a JSON object the hold the message
 
 pnMessage.addProperty(messageKey1, mouseX);
 pnMessage.addProperty(messageKey2, mouseY);
 pnMessage.addProperty(messageKey3, keyPressed);
 pnMessage.addProperty(messageKey4, c);
 
 pubnub.publish()                                  //publish the message
    .message(pnMessage)
    .channel(publishChannel)
    .async(new PNCallback<PNPublishResult>() {
        @Override
        public void onResponse(PNPublishResult result, PNStatus status) {
            // handle publish result, status always present, result if successful
            // status.isError() to see if error happened
            if(!status.isError()) 
            {
             //println("pub timetoken: " + result.getTimetoken());
            }
            //println("pub status code: " + status.getStatusCode());
        }
    });
  
}
