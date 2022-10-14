class SubCategories {
  late String  path;
  late String  idMainCategories;
  late String name ;

 SubCategories();
  SubCategories.fromMap(Map<String,dynamic>map){
    name= map['name'];
    idMainCategories = map['idMainCategories'];

  }

  Map<String,dynamic>toMap(){
    Map<String ,dynamic>map = Map<String,dynamic>();
    map['name']= name;
    map['idMainCategories'] = idMainCategories;

    return map;
  }


}