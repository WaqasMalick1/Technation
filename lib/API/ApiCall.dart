import 'dart:convert';

import 'package:DemoApp/Models/CitiesModel.dart';
import 'package:DemoApp/Models/ServicesModel.dart';
import 'package:DemoApp/Models/SliderModel.dart';
import 'package:http/http.dart' as http;

class ApiCalls{
final String host = "wedo-api.technationme.com";
final String sliderpath = "api/sliders";
final String citiespath = "api/cities";
final String categorypath = "api/categories";


Future<SliderModel> getSliders()async{
 
 SliderModel sliderModel;
  final uri = Uri.https(host, sliderpath);
  print(uri);
 var response = await http.get(uri);
  print('data is ${ json.decode(response.body)}');
  if(response.statusCode == 200){
    final jsonList = json.decode(response.body);
    sliderModel =  SliderModel.fromJson(jsonList);
  }
    return sliderModel;
}

Future<CitiesModel> getCities()async{
  CitiesModel citiesModel;
  final uri = Uri.https(host, citiespath);
  final results = await http.get(uri);
  if(results.statusCode==200){
    final jsonList = json.decode(results.body);
   citiesModel =  CitiesModel.fromJson(jsonList);
  }
  return citiesModel;
}

Future<ServicesModel> getServices(String cityID,bool isWithParams)async{
ServicesModel servicesModel;
 final queryParameters = {
   'cityId': '$cityID'
   };
   var uri;
  if(isWithParams){
    uri = Uri.https(host, categorypath,queryParameters);
    print('url is $uri');
  }else{
    uri = Uri.https(host, categorypath);
   }
   
  final results = await http.get(uri);
  if(results.statusCode==200){
    final jsonList = json.decode(results.body);
    servicesModel = ServicesModel.fromJson(jsonList);
  }
  return servicesModel;
}


}