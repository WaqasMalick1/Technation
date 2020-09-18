import 'package:DemoApp/API/ApiCall.dart';
import 'package:DemoApp/Models/CitiesModel.dart';
import 'package:DemoApp/Models/ServicesModel.dart';

class Repository{
  final apiCall = ApiCalls();

  

  Future<CitiesModel> getCitiesData() => apiCall.getCities();

  Future<ServicesModel> getServicesData(String cityID,bool isWithParams) => apiCall.getServices(cityID, isWithParams); 
}