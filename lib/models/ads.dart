/*class AppUser {
  AppUser({this.id, this.firstname, this.lastname});

  AppUser.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.parse(json['id'].toString()) : null;
    firstname = json['firstname'].toString();
    lastname = json['lastname'].toString();
  }

  int? id;
  String? firstname;
  String? lastname;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    return data;
  }
}*/
class Products {
  final String id;
  final String title;
  final String subtitle;

  final String img;
  

  Products({required this.id, required this.title,required this.subtitle,required this.img,
  });
   @override
  String toString() {
    return 'Products(id: $id, title: $title, subtitle: $subtitle, img: $img)';
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    
    return Products(
      id: json['_id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      img: json['img'] as String,
      
    );
  }


  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'subtitle':subtitle,
      'img':img,
     
  };
  }

  static List<Products> listFromJson(List<dynamic> jsonList) {
    

  
    return jsonList.map((json) => Products.fromJson(json)).toList();
  }

  static List<Map<String, dynamic>> listToJson(List<Products> models) {
    return models.map((model) => model.toJson()).toList();
  }
}
