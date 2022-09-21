import 'forecast_model.dart';

class Weather{
  String? temp;
  String? wind;
  String? desc;
  List<Forecast>? forecast;

  Weather({this.temp, this.wind, this.desc, this.forecast});
  
  factory Weather.formJson(Map<String,dynamic> json)=> Weather(
         temp: json['temperature'],
          wind: json['wind'],
          desc: json['description'],
          forecast: List<Forecast>.from(
            json["forecast"].map((x)=> Forecast.fromJson(x))
          )
      );
  
  Map<String, dynamic>toJson()=>{
    "temperature": temp,
    "wind": wind,
    "descriptiion":desc,
    "forecast": List<dynamic>.from(forecast!.map((e) => e.toString()))
  };
}