class SliderModel {
  int status;
  String message;
  List<Sliders> sliders;

  SliderModel({this.status, this.message, this.sliders});

  SliderModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    if (json['sliders'] != null) {
      sliders = new List<Sliders>();
      json['sliders'].forEach((v) {
        sliders.add(new Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.sliders != null) {
      data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sliders {
  String sId; 
  String image;
 

  Sliders({this.sId,  this.image });

  Sliders.fromJson(dynamic json) {
    sId = json['_id'];
    image = json['image'];
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['image'] = this.image;
    return data;
  }
}