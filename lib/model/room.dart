class Room{
  static const String collectionName='Rooms';
  String Roomid;
  String title;
  String description;
  String categoryid;
  Room({
    required this.Roomid,
    required this.title,
    required this.description,
    required this.categoryid,
  });
  Room.fromJson(Map<String,dynamic> json):this
      (
      Roomid: json['Roomid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      categoryid: json['categoryid'] as String,
    );
  Map<String,dynamic> toJson(){
    return {
      'Roomid':Roomid,
      'title':title,
      'description':description,
      'categoryid':categoryid,
    };
  }
}