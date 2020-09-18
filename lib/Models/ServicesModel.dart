class ServicesModel {
  int status;
  String message;
  List<Categories> categories;

  ServicesModel({this.status, this.message, this.categories});

  ServicesModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
  }

  
}

class Categories {
  String sId;
  List<String> description;
 
 
  String title;
  
  String image;
 
  
  String coverImage;
 

  Categories(
      {this.sId,
      this.description,
      
      this.title,
     
      this.image,
      
      this.coverImage,
      });

  Categories.fromJson(dynamic json) {
    sId = json['_id'];
    description = json['description'].cast<String>();
   
    title = json['title'];
   
    image = json['image'];
  
    coverImage = json['coverImage'];
    }
  

 
}