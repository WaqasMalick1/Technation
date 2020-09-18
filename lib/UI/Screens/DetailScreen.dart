import 'package:DemoApp/Models/ServicesModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatefulWidget {
  final Categories categories;
  DetailScreen({@required this.categories}): assert(categories!=null);
  @override
  _DetailScreenState createState() => _DetailScreenState(this.categories);
}

class _DetailScreenState extends State<DetailScreen> {
  final Categories categories;
  _DetailScreenState(this.categories);
  @override
  Widget build(BuildContext context) {
    return 
           Scaffold(
        body: SingleChildScrollView(
                  child: Column(
                children: [
                Stack(
                  children: [
                   
                    Container(
                    height: 270,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      image: DecorationImage(image: NetworkImage('https://wedo-api.technationme.com'+ categories.coverImage),fit: BoxFit.cover)
                    ),
                    child: Container(
                      alignment: FractionalOffset.bottomCenter,
                      child: Container(
                        height: 135,
                        width: 165,
                        transform: Matrix4.translationValues(0.0, 60.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                               blurRadius: 10,
                               offset: Offset(0.0, 3)
                            )
                          ]
                        ),
                        child: Center(
                          child: Image.network('https://wedo-api.technationme.com'+ categories.image),
                        ),
                      ),
                    ),
              ),
               Container(
                      margin: EdgeInsets.only(top: 48,left: 15,right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          InkWell(
                            onTap: ()=> Navigator.pop(context),
                            child: Icon(Icons.arrow_back,color: Colors.white,)),
                          Image.asset('assets/icons/bell.png',scale: 2,)
                        ],
                      ),
                    ),
                  ],
                ),
              Padding(
                padding: const EdgeInsets.only(left: 23.0,right: 23.0,top: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 37),
                    child: Text('${categories.title} includes:', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16),)),
                  ListView.builder(
                    itemCount: categories.description.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index){
                      return servicesDesription(categories.description[index]);
                    }
                    )
                  ],
                  ),),
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 30),
                    child: Align(
                      alignment: FractionalOffset.topCenter,
                      child: Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xFF22CE29)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 65,vertical: 17),
                      child: Text('Book This Service',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),
                      )
                      
                    ),
                  )
            ],
          ),
        
      ),
    );
  }

  Widget servicesDesription(String description){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 19,
            width: 19,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width:1,color: Color(0xFF22CE29))
            ),
            child: Center(
              child: Icon(Icons.done,color: Color(0xFF22CE29),size: 12,),
            )),
            Expanded(
                          child: Padding(padding: const EdgeInsets.only(
                left: 16.0
              ),
              child:  Text(description,style: GoogleFonts.roboto()),),
            )
          
        ],
      ),
    );
  }
}