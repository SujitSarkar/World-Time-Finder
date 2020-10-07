import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location; //location name for the url
  String time; //the time in that location
  String flag; //url to an asset flag icon
  String url; //location url for API endpoint
  bool isDayTime; //true or false if daytime or not

  //constructor....
  WorldTime({this.location, this.flag, this.url});


    Future<void> getTime() async{

     try {
       //make the request...
       Response response = await get('http://worldtimeapi.org/api/timezone/$url');
       Map data = jsonDecode(response.body);

       //get properties from tha data...
       String dateTime = data['datetime'];
       String offSet = data['utc_offset'].substring(1,3);

       //create dateTime object...
       DateTime now = DateTime.parse(dateTime);
       now = now.add(Duration(hours: int.parse(offSet)));

       //set te time property...
       isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
       time = DateFormat.jm().format(now);
     }
     catch(e){
        print("caught error: $e");
        print('could not get tha data');
     }
  }
}
