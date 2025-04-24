import 'dart:convert';
import 'package:clima/whether_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'location.dart';

class ClimaScreen extends StatefulWidget {
  const ClimaScreen({super.key});
  @override
  State<ClimaScreen> createState() => _ClimaScreenState();
}

class _ClimaScreenState extends State<ClimaScreen> {

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    double lat = location.latitude;
    double lon = location.longitude;

    var url = Uri.https('api.weatherapi.com', '/v1/current.json', {'key': '1c0d373a1dc4498cae6150014252204', 'q': '$lat, $lon' , 'aqi': 'no'});
    print(url);
    var response = await http.get(url);
    if(response.statusCode == 200) {
      var json = jsonDecode(response.body);
      print(json);
      Navigator.push(context, MaterialPageRoute(builder: (context) => WhetherScreen(json: json,)));
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/whether.jpg'),
            fit: BoxFit.cover
        )
      ),
      child: SafeArea(
          child: Center(
            child: SpinKitDoubleBounce(
              color: Colors.blue,
              size: 50,
            ),
          )
      ),
    );
  }
}
