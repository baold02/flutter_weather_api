import 'package:flutter/material.dart';
import 'package:flutter_weather_api/Models/weather_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_weather_api/error_page.dart';
class Demo extends StatefulWidget {
  final text;
  const Demo({Key? key,required this.text}) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter API Integration'),
      ),
      body: FutureBuilder<Weather>(
        future: request(widget.text),
        builder: (context,snapshot){
          if(snapshot.hasData){
              return Center(
                child:  Column(
                  children: [
                        _buildText(widget.text, 60, Colors.black, true),
                        _buildText('Today', 40, Colors.grey, false),
                        _buildText(snapshot.data!.desc, 20, Colors.black, false),
                    SizedBox(
                      height: 150,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDisplayCard(Icons.thermostat, snapshot.data!.temp, Colors.red),
                            _buildDisplayCard(Icons.abc, snapshot.data!.wind, Colors.blue)

                          ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                          child: Card(
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius:BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                children: [
                                  FittedBox(
                                      child: Text(
                                        'forecasat for tomorrow',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight:FontWeight.bold,
                                          color: Colors.white
                                        ),
                                      ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                       Padding(padding: const EdgeInsets.all(5),
                                          child: Icon(
                                              Icons.thermostat,
                                             size: 30,
                                          ),

                                       ),
                                      Padding(padding: EdgeInsets.all(5),
                                        child: Text(
                                          snapshot.data!.forecast!.first.temp.toString(),
                                          style: TextStyle(
                                            fontSize:20,
                                            fontWeight:FontWeight.bold,
                                            color: Colors.white
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                    )

                  ],
                ),
              );
          }else if(snapshot.hasError){
             return ErrorPage();
          }else{
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }


Container _buildDisplayCard(IconData icon, String? result, Color iconColor){
    return Container(
        width: 200,
        padding: EdgeInsets.all(10.0),
        child: Card(
          color: Colors.blue[200],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 40,
                  color: iconColor,
                ),
                SizedBox(
                  height: 10,
                ),
                FittedBox(
                  child: Text(
                    result!,
                    style: TextStyle(
                        fontSize: 30
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
}

  Padding _buildText(String? text, double size, Color color, bool bool){
        return Padding(padding: const EdgeInsets.all(10.0),
                  child: Text(
                    text!,
                    style: TextStyle(
                        fontSize: size,
                        fontWeight:bool? FontWeight.bold: null,
                        color: color
                    ),
                  ),
        );
  }



  Future<Weather> request(String text) async{
   var dio = Dio();
   var response = await dio.get('https://goweather.herokuapp.com/weather/$text');
   var _weather = Weather.formJson(response.data);
   return _weather;

  }
}
