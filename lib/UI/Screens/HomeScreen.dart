import 'dart:async';

import 'package:DemoApp/API/ApiCall.dart';
import 'package:DemoApp/API/Blocs/HomeBloc.dart';
import 'package:DemoApp/Models/CitiesModel.dart';
import 'package:DemoApp/Models/ServicesModel.dart';
import 'package:DemoApp/Models/SliderModel.dart';
import 'package:DemoApp/UI/Screens/DetailScreen.dart';
import 'package:DemoApp/UI/Widgets/PhotoItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:page_transition/page_transition.dart';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController scrollController;
  StreamController<double> scollUp = StreamController<double>.broadcast();
  
  List<Cities> citieslist=[];
  final homeBloc = HomeBloc();
   String _citySelectID;
   SliderModel sliderModel;
   final apiCall = ApiCalls();

  @override
  void initState() {
    scollUp.sink.add(0);
   
    homeBloc.citiesData.listen((event) {
      setState(() {
        citieslist=event.cities; 
      });
      });
    
    scrollController = ScrollController();
   scrollController.addListener(_scrollListener);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Stack(
       children: [
         NestedScrollView(
           controller: scrollController,
           headerSliverBuilder: (BuildContext context, bool innerScroll ){
             
            return <Widget>[
              
              SliverAppBar(
                floating: true,
                elevation: 0,
                snap: false,
                stretch: true,
                expandedHeight: 350.0,
                      flexibleSpace: FlexibleSpaceBar(
                          background:  FutureBuilder<SliderModel>(
                            future: apiCall.getSliders(),
                            builder: (context, snapshot) {
                              print(snapshot.connectionState);
                              if(snapshot.connectionState == ConnectionState.waiting && !snapshot.hasData){
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.black,
                                  ),
                                );
                              }
                              if(snapshot.hasError){
                                return Center(child:Text(snapshot.error));
                              }
                              return Swiper(itemCount: snapshot.data.sliders.length,
                              autoplay: false,
                              loop: true,
                              itemBuilder: (BuildContext context, int index){
                                print(snapshot.data.sliders[index].image);
                                return PhotoItem(imageUrl: "https://wedo-api.technationme.com"+snapshot.data.sliders[index].image);
                              },);
                            }
                          )
                          ),
                        leading: Image.asset('assets/icons/menu.png'),
                        actions: [
                         Image.asset('assets/icons/bell.png',scale: 2,)
                        ],
              
               
              ),
              
             
            ];
           }, 
           body: Stack(
             children: [
               SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Container(
                       width: double.infinity,
                        padding: EdgeInsets.only(left: 20,right: 20,top: 60),
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                        Text('Popular Services',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 3),
                              child: Icon(Icons.location_on,size: 19,color: Color(0xFF22CE29),)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Location',style: TextStyle(fontSize: 8),),
                                Row(
                                  children: [
                                    _dropdownCities(citieslist)
                                  ],
                                )
                              ],
                            ),
                          ],
                        )
                      ],
          ),
    
),
StreamBuilder<ServicesModel>(
  stream: homeBloc.servicesData,
  builder: (context, snapshot) {
    if(snapshot.connectionState == ConnectionState.waiting){
      return Center(child: CircularProgressIndicator());
    }
    if(snapshot.hasError)
    if(snapshot.hasError){
          return Center(child:Text(snapshot.error));
          }
    return     Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child:   GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 1.5,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      physics: NeverScrollableScrollPhysics(),
      children: List.generate(snapshot.data.categories.length, (index) => InkWell(

        onTap: (){
          Navigator.of(context).push(PageTransition(child: DetailScreen(categories: snapshot.data.categories[index]), type: PageTransitionType.rightToLeft));
        },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10),
                         color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                 blurRadius: 10,
                                                 offset: Offset(0.0, 3),
                                                 
                                              )
                                            ]
                ),
                child: Center(
                  child: PhotoItem(imageUrl: "https://wedo-api.technationme.com"+snapshot.data.categories[index].image),
                ),
          ),
      ),),),
    );
  }
)
                   ],
                 ),
               ),

               
             ],
           ),),

           StreamBuilder<double>(
             stream: scollUp.stream,
             initialData: 0.0,
             builder: (context, snapshot) {
               
               return SafeArea(
                                child: Container(
                   height: 60,
                   margin: EdgeInsets.only(top: snapshot.data>=0? 320-snapshot.data: 0,left: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 5,
                      offset: Offset(0.0, 3),
                                                 
                      )
                      ],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20))
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Search Our Service',style: TextStyle(fontSize: 10),),
                            Container(
                              width: 170,
                              height: 20,
                      child: Form(child: TextFormField(
                  textInputAction: TextInputAction.done,

                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Field not be empty';
                    } else {
                      return null;
                    }
                  },
                  // validator:
                  onSaved: (value) {
                    
                  },

                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 14.0),
                      hintText: 'Type your request',
                      hintStyle: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),
                       border: InputBorder.none,
                      ),
                ),),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                        margin: EdgeInsets.only(right: 10),
                       decoration: BoxDecoration(
                          color: Color(0xFF22CE29),
                          borderRadius: BorderRadius.circular(10)
                       ),
                        child: Text('GO',style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                 ),
               );
             }
           )
       ],
     )
    );
  }
  void _scrollListener() {
    
    if (scrollController.offset>0 && scrollController.offset <=320  ) {
      if(scrollController.offset<50){
        scollUp.sink.add(0.0);
        
      }else{
        scollUp.sink.add(scrollController.offset.floor().toDouble());
      }
      
      //print('scroll is ${scrollController.offset}');
      
    } 
  }

  Widget _dropdownCities(List<Cities> citilist){
    return DropdownButtonHideUnderline(
                      
                        child: DropdownButton<String>(
                          value: _citySelectID,
                          hint: Text('Select City',style: TextStyle(fontSize: 12)),
                        
                          isDense: true,
                          style: TextStyle(color: Colors.black),
                          onChanged: (String newValue) {
                          
                              _citySelectID = newValue;
                              print(_citySelectID);

                              homeBloc.getServices(_citySelectID, true);
                              
                          },
                          items: citilist.map((Cities cities) {
                            return DropdownMenuItem<String>(
                              value: cities.sId,

                              child:  Text(cities.name,style: TextStyle(color: Colors.black),),
                            );
                          }).toList(),
                        ),
                      );
  
  }
}