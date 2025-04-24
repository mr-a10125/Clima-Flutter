import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {

  const CityScreen({super.key});

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  TextEditingController tec = TextEditingController();

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
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.arrow_back, color: Colors.white, size: 30,)
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextFormField(
                    controller: tec,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Enter your city name',
                      fillColor: Colors.white,
                      filled: true
                    ),
                  ),
                ),
                
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, tec.text);
                    },
                    child: Text('Get Whether')
                )
              ],
            )
        ),
      ),
    );
  }
}
