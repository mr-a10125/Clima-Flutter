import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'city_screen.dart';

class WhetherScreen extends StatefulWidget {

  final dynamic json;
  const WhetherScreen({super.key, this.json});

  @override
  State<WhetherScreen> createState() => _WhetherScreenState();
}

class _WhetherScreenState extends State<WhetherScreen> {

  String cityName = "Paris";
  String tempC = "0";
  String whetherCondition = "";
  String whetherImage = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      this.cityName = widget.json['location']['name'];
      tempC = widget.json['current']['temp_c'].toString();
      whetherCondition = widget.json['current']['condition']['text'];
      whetherImage = 'https:${widget.json['current']['condition']['icon']}';
    });
  }

  void getCurrentLocation(String cityName) async {
    var url = Uri.https('api.weatherapi.com', '/v1/current.json', {'key': '1c0d373a1dc4498cae6150014252204', 'q': cityName , 'aqi': 'no'});
    print(url);
    var response = await http.get(url);
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      setState(() {
        this.cityName = json['location']['name'];
        tempC = json['current']['temp_c'].toString();
        whetherCondition = json['current']['condition']['text'];
        whetherImage = 'https:${json['current']['condition']['icon']}';
      });

      print(json);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          width: width,
          height: height, 
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('images/whether.jpg'), 
                  fit:BoxFit.cover
              )
          ), 
          child: SafeArea(
              child:Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: (){
                            getCurrentLocation(widget.json['location']['name']);
                          },
                          icon: Icon(Icons.near_me, color: Colors.white, size: 35,),
                      ),
                      IconButton(
                          onPressed: () async {
                            var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context) => CityScreen()));
                            print(cityName);
                            if(cityName != null && cityName != "") {
                              getCurrentLocation(cityName);
                            }
                          },
                          icon: Icon(Icons.location_on, color: Colors.white, size: 35,)
                      )
                    ],
                  ),
      
                  Flexible(
                    child: Text(
                      cityName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                      ),
                      softWrap: true,
                    ),
                  ),
                  Text(
                    "$tempC°C",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: NetworkImage(whetherImage),
                          width: 64,
                          height: 64,
                          fit: BoxFit.fill,
                        ),

                        Flexible(
                          child: Text(
                            whetherCondition,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold
                            ),
                            softWrap: true,
                          ),
                        ),
                      ],
                    )
                  )
                ],
              )
          )
      ),
    );
  }
}
