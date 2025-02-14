class Items {
  final String id;
  final String name;
  final String img;
  final int val;
  final String quantity;
  final String category;
  final String time;
  final String rate;
  String gender;

  Items({required this.id, required this.name,required this.img,required this.val,
  required this.quantity,required this.category,required this.time,required this.rate, required this.gender});


   @override
  String toString() {
    return 'Products(id: $id, name:$name,img: $img,val:$val,quantity:$quantity,category:$category,time:$time,rate:$rate)';
  }
  factory Items.fromJson(Map<String, dynamic> json) {
    
    return Items(
      id: json['_id'] as String,
      name: json['name'] as String,
      img: json['img'] as String,
      val: json['val'] as int,
      quantity: json['quantity'] as String,
      category: json['category'] as String,
      time: json['time'] as String,
      rate: json['rate'] as String,
      gender: json['gender'] ?? ''
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'img':img,
      'val':val,
      'quantity':quantity,
      'category':category,
      'time':time,
      'rate':rate,
      'gender':gender
    };
  }


  static Map<String, List<Items>> listFromJson(List<dynamic> jsonList) {
    

    Map<String, List<Items>> categorizedItems = {};
    final items= jsonList.map((json) => Items.fromJson(json)).toList();
    for (var item in items) {
      categorizedItems.putIfAbsent(item.category, () => []).add(item);
    }
    
    return categorizedItems;
  }
   static Map<String, List<Items>> listFromJsons(Map<String, dynamic> jsonMap) {
    Map<String, List<Items>> categorizedItems = {};

    // Iterate over each entry in the map
    jsonMap.forEach((category, value) {
      // Ensure the value is a List
      if (value is List) {
        // Convert each Map in the List to an Items object
        List<Items> items = value.map((itemJson) {
          if (itemJson is Map<String, dynamic>) {
            return Items.fromJson(itemJson);
          } else {
            throw FormatException("Invalid item format");
          }
        }).toList();

        // Add the List of Items to the result map under the category key
        categorizedItems[category] = items;
      }
    });

    return categorizedItems;
  }
  
  static List<Map<String, dynamic>> listToJson(List<Items> models) {
    return models.map((model) => model.toJson()).toList();
  }
}
