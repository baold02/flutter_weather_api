class Forecast{
  String? day;
  String? temp;
  String? wind;

  Forecast({this.day, this.temp, this.wind});

  factory Forecast.fromJson(Map<String,dynamic>json)=> Forecast(
    day: json["day"],
    temp: json["temperature"],
    wind: json["wind"],
  );


  Map<String,dynamic> toJson()=>{
    "day": day,
    "temperature" :temp,
    "wind":wind
  };
}