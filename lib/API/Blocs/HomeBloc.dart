import 'package:DemoApp/API/Blocs/BaseBloc.dart';
import 'package:DemoApp/API/Resources/Repository.dart';
import 'package:DemoApp/Models/CitiesModel.dart';
import 'package:DemoApp/Models/ServicesModel.dart';
import 'package:DemoApp/Models/SliderModel.dart';
import 'package:rxdart/subjects.dart';

class HomeBloc implements BaseBloc{
  final repository = Repository();

 

  // cities
  final cities = PublishSubject<CitiesModel>();
  Stream<CitiesModel> get citiesData => cities.stream;

  // cities
  final services = PublishSubject<ServicesModel>();
  Stream<ServicesModel> get servicesData => services;

  HomeBloc(){
    getCities();
    getServices('', false);
  }

  

  void getCities()async{

    repository.apiCall.getCities().then((value)  {
      if(value==null){
        cities.sink.addError('null');
      }else{
        cities.sink.add(value);
      }
    });
  }

  void getServices(String cityID,bool isWithParams)async{

    repository.apiCall.getServices(cityID,isWithParams).then((value)  {
      if(value.categories==null){
        services.sink.addError('No Data Available');
      }else{
        services.sink.add(value);
      }
    });
  }

  @override
  void dispose() {
    
    cities.close();
    services.close();
  }

}