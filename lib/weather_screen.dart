import 'package:flutter/material.dart';
import 'package:flutter_weather_api/Models/weather_model.dart';
import 'package:flutter_weather_api/demo.dart';
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _controllor = TextEditingController();
    Weather? info;

  @override
  void dispose() {
    // TODO: implement dispose
    _controllor.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    String text = '';
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter API'),
        ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(border: OutlineInputBorder()),
                controller: _controllor,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          setState(() {
            text = _controllor.text;
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> Demo(text: text)));
          });
          _controllor.clear();
        },
      ),
    );
  }
}
