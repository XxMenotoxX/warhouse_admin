class UserData {

  late String path;
  late String? name ;
  late String? ImageUrl ;

  UserData();
  UserData.fromMap(Map<String,dynamic>map){
    name= map['name'];
    ImageUrl = map['ImageUrl'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['name']= name;
    map['ImageUrl'] = ImageUrl;

    return map;
  }


}