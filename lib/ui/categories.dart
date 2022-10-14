import 'package:admin_app_flutter/control_panel/update_category_screen.dart';
import 'package:admin_app_flutter/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/ui/subcategories.dart';
import 'package:admin_app_flutter/widgets/list_tile_drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'orders_list.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  late User _user;
  FirebaseFirestore _firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _user = FbAuthController().user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF273246),
      drawer: Drawer(
        child: Container(
          color: Color(0XFF181D29),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(
                height: 50,
              ),
              FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: _firebase
                    .collection('Admins')
                    .doc(FbStoreController().firebaseUser!.uid)
                    .get(),
                builder: (_, snapshot) {
                  if (snapshot.hasError)
                    return Text('Error = ${snapshot.error}');

                  if (snapshot.hasData) {
                    var data = snapshot.data!.data();
                    // <-- Your value
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            NetworkImage(data?['ImageUrl'] ?? 'tezo'),

                        //  backgroundImage: AssetImage('images/person.png'),
                      ),
                      title: Text(
                        _user.displayName ?? 'No Name',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        _user.email ?? 'No Email',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  } else {
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        // backgroundImage: AssetImage('images/person.png'),
                      ),
                      title: Text(
                        _user.displayName ?? 'No Name',
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(16),
                          color: Colors.white,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(
                        _user.email ?? 'No Email',
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(12),
                          color: Colors.grey,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    );
                  }
                },
              ),
              // StreamBuilder<QuerySnapshot>(
              //     stream: FbStoreController().readDataUser(collectionName: 'Admins'),
              //     builder: (context, snapshot) {
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return Center(
              //           child: CircularProgressIndicator(),
              //         );
              //       } else if (snapshot.hasData &&
              //           snapshot.data!.docs.isNotEmpty) {
              //         // List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              //         Iterable<QueryDocumentSnapshot> data = snapshot.data!.docs
              //             .where((element) =>
              //         element.id == FbAuthController().user.uid);
              //         return ListTile(
              //           leading: CircleAvatar(
              //             radius: 30,
              //             backgroundImage: NetworkImage(data.elementAt(0).get('ImageUrl')),
              //           ),
              //           title: Text(
              //             data.elementAt(0).get('name'),
              //             style: TextStyle(
              //               fontSize: 16,
              //               color: Colors.white,
              //               fontFamily: 'Montserrat',
              //               fontWeight: FontWeight.w700,
              //             ),
              //           ),
              //           subtitle: Text(
              //             _user.email??'No Email',
              //             style: TextStyle(
              //               fontSize: 12,
              //               color: Colors.grey,
              //               fontFamily: 'Montserrat',
              //               fontWeight: FontWeight.w700,
              //             ),
              //           ),
              //         );
              //       } else {
              //         return
              //           ListTile(
              //             leading: CircleAvatar(
              //               radius: 30,
              //               backgroundImage: AssetImage('images/person.png'),
              //             ),
              //             title: Text(
              //               _user.displayName??'No Name',
              //               style: TextStyle(
              //                 fontSize: SizeConfig().scaleTextFont(16),
              //                 color: Colors.white,
              //                 fontFamily: 'Montserrat',
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //             subtitle: Text(
              //               _user.email??'No Email',
              //               style: TextStyle(
              //                 fontSize: SizeConfig().scaleTextFont(12),
              //                 color: Colors.grey,
              //                 fontFamily: 'Montserrat',
              //                 fontWeight: FontWeight.w700,
              //               ),
              //             ),
              //           );
              //       }
              //     }),
              SizedBox(
                height: 69,
              ),
              DrawerListTile(
                title: 'Home',
                iconData: Icons.home_rounded,
                onTab: () {
                  Navigator.pushNamed(context, '/main_categories');
                },
              ),
              // SizedBox(
              //   height: 30,
              // ),
              // DrawerListTile(
              //   title: 'Search',
              //   iconData: Icons.search,
              //   onTab: () {},
              // ),
              SizedBox(
                height: 30,
              ),
              // DrawerListTile(
              //   title: 'Basket',
              //   iconData: Icons.shopping_cart,
              //   onTab: () {},
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // DrawerListTile(
              //   title: 'Notifications',
              //   iconData: Icons.notifications_sharp,
              //   onTab: () {},
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              // DrawerListTile(
              //   title: 'Favorite',
              //   iconData: Icons.star,
              //   onTab: () {},
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              DrawerListTile(
                title: 'Settings',
                iconData: Icons.settings,
                onTab: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, '/profile_settings');
                },
              ),
              SizedBox(
                height: 30,
              ),
              DrawerListTile(
                  iconData: Icons.logout,
                  title: 'Exit',
                  onTab: () {
                    FbAuthController().signOut();
                    Navigator.pushReplacementNamed(context, '/login_screen');
                  }),
            ],
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_category_screen');
            },
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 30,
            ),
          ),
          IconButton(
            padding: EdgeInsets.only(right: 5, top: 5),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProductsLogsListScreen()));
            },
            icon: Icon(
              Icons.receipt,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
        title: Text(
          'Categories',
          style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FbStoreController().read(collectionName: 'MainCategories'),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              List<QueryDocumentSnapshot> data = snapshot.data!.docs;
              return Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                      colors: [
                        Color(0XFF273246),
                        Color(0XFF181D29),
                      ]),
                ),
                child: ListView.separated(
                    padding: EdgeInsets.only(top: 145, right: 13, left: 13),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubCategoriesScreen(
                                mainCategories:
                                    getMainCategories(snapshot: data[index]),
                              ),
                            ),
                          );
                        },
                        child: Stack(
                          children: [
                            Container(
                              alignment: AlignmentDirectional.bottomStart,
                              height: SizeConfig().scaleHeight(200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  colorFilter: new ColorFilter.mode(
                                      Colors.black.withOpacity(0.6),
                                      BlendMode.dstATop),
                                  image: NetworkImage(
                                    data[index].get('imagePath'),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data[index].get('name'),
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      data[index].get('description'),
                                      style: TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        await deleteCategories(
                                            path: data[index].id);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateCategoryScreen(
                                                    mainCategories:
                                                        getMainCategories(
                                                            snapshot:
                                                                data[index]),
                                                  )),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 20,
                      );
                    },
                    itemCount: data.length),
              );
            } else {
              return Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.warning,
                      size: 85,
                    ),
                    Text(
                      'No Data',
                      style: TextStyle(fontSize: 22, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

Future<bool> deleteCategories({required String path}) async {
  bool status = await FbStoreController()
      .delete(path: path, collectionName: 'MainCategories');

  return status;
}

MainCategories getMainCategories({required QueryDocumentSnapshot snapshot}) {
  MainCategories categories = MainCategories();
  categories.path = snapshot.id;
  categories.name = snapshot.get('name');
  categories.imagePath = snapshot.get('imagePath');
  categories.description = snapshot.get('description');
  return categories;
}

// body: GetX<ImagesGetxController>(
//   builder: (ImagesGetxController controller){
//     if(controller.listOfImages.isNotEmpty){
//       return ListView.separated(
//           padding: EdgeInsets.only(top: 145, right: 13, left: 13),
//           shrinkWrap: true,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//
//
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => SubCategoriesScreen(
//                 //       mainIdCategories: data[index].id,
//                 //       nameMainCategories: data[index].get('name'),
//                 //     ),
//                 //   ),
//                 // );
//               },
//               child: Container(
//                 alignment: AlignmentDirectional.bottomStart,
//                 height: SizeConfig().scaleHeight(200),
//
//                 // decoration: BoxDecoration(
//                 //   borderRadius: BorderRadius.circular(20),
//                 //   image: DecorationImage(
//                 //     colorFilter: new ColorFilter.mode(
//                 //         Colors.black.withOpacity(0.6),
//                 //         BlendMode.dstATop),
//                 //     image: NetworkImage(
//                 //       data[index].get('imagePath'),
//                 //     ),
//                 //     fit: BoxFit.cover,
//                 //   ),
//                 // ),
//                 // child: Padding(
//                 //   padding: const EdgeInsets.symmetric(
//                 //       horizontal: 24, vertical: 15),
//                 //   child: Column(
//                 //     mainAxisSize: MainAxisSize.min,
//                 //     crossAxisAlignment: CrossAxisAlignment.start,
//                 //     children: [
//                 //       Text(
//                 //         data[index].get('name'),
//                 //         style: TextStyle(
//                 //           fontFamily: 'Montserrat',
//                 //           fontSize: 16,
//                 //           color: Colors.white,
//                 //         ),
//                 //       ),
//                 //       SizedBox(
//                 //         height: 5,
//                 //       ),
//                 //       Text(
//                 //         data[index].get('description'),
//                 //         style: TextStyle(
//                 //           fontFamily: 'Montserrat',
//                 //           fontSize: 10,
//                 //           color: Colors.white,
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//               ),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return SizedBox(
//               height: 20,
//             );
//           },
//         itemCount: 10,
//          );
//
//   }
//     else{
//       return Center(
//         child: Column(
//           children: [
//             Icon(
//               Icons.warning,
//               size: 85,
//             ),
//             Text(
//               'No Data',
//               style: TextStyle(fontSize: 22, color: Colors.grey),
//             ),
//           ],
//         ),
//       );
//
//     }
//   }
//
// ),

// body: StreamBuilder<QuerySnapshot>(
//     stream: FbStoreController().read(collectionName: 'MainCategories'),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
//         List<QueryDocumentSnapshot> data = snapshot.data!.docs;
//         return Container(
//           height: double.infinity,
//           // decoration: BoxDecoration(
//           //   gradient: LinearGradient(
//           //     begin: AlignmentDirectional.topStart,
//           //       end: AlignmentDirectional.bottomEnd,
//           //       colors: [
//           //     Color(0XFF273246),
//           //     Color(0XFF181D29),
//           //   ]),
//           // ),

//       } else {
//         return Center(
//           child: Column(
//             children: [
//               Icon(
//                 Icons.warning,
//                 size: 85,
//               ),
//               Text(
//                 'No Data',
//                 style: TextStyle(fontSize: 22, color: Colors.grey),
//               ),
//             ],
//           ),
//         );
//       }
//     }),
