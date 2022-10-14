import 'package:admin_app_flutter/control_panel/add_sub_category_screen.dart';
import 'package:admin_app_flutter/control_panel/update_sub_category_screen.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/model/subcategories_model.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/ui/products.dart';
import 'package:admin_app_flutter/widgets/app_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubCategoriesScreen extends StatefulWidget {
  late MainCategories mainCategories;

  SubCategoriesScreen({required this.mainCategories});

  @override
  _SubCategoriesScreenState createState() => _SubCategoriesScreenState();
}

class _SubCategoriesScreenState extends State<SubCategoriesScreen> {
  late TextEditingController _controller;
  late String? _value;
  late Iterable<QueryDocumentSnapshot> data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    _value = null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF273246),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        leadingWidth: 60,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            padding: EdgeInsets.all(20),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddSubCategoryScreen(
                            pathMainCategories: widget.mainCategories.path,
                          )));
            },
            icon: Icon(
              Icons.add_circle,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
        title: Text(
          widget.mainCategories.name,
          style: TextStyle(
              fontSize: SizeConfig().scaleTextFont(28),
              // fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 25),
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: SizeConfig().scaleHeight(30),
          right: SizeConfig().scaleWidth(15),
          left: SizeConfig().scaleWidth(15),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.only(topEnd: Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig().scaleWidth(10),
                ),
                child: AppTextField(
                  controller: _controller,
                  onChange: (value) {
                    setState(() {
                      _value = value;
                    });
                  },
                  onPressed: () {
                    setState(() {
                      _controller.text = ' ';
                      _value = null;
                    });
                  },
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream:
                      FbStoreController().read(collectionName: 'Subcategories'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      // List<QueryDocumentSnapshot> data = snapshot.data!.docs;

                      data = _value != null
                          ? snapshot.data!.docs.where((element) =>
                              (element.get('idMainCategories') ==
                                  widget.mainCategories.path) &&
                              (element.get('name') == _value))
                          : snapshot.data!.docs.where((element) =>
                              element.get('idMainCategories') ==
                              widget.mainCategories.path);

                      // data.where((QueryDocumentSnapshot document) {
                      //   return document.get('idMainCategories') ==
                      //       widget.mainIdCategories;
                      // });

                      return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          padding:
                              EdgeInsets.only(right: 15, left: 15, top: 20),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductsScreen(
                                      subCategories: getSubCategories(
                                          snapshot: data.elementAt(index)),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      offset: Offset(0, 2),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: SizeConfig().scaleWidth(20)),
                                    Expanded(
                                      child: Text(
                                        data.elementAt(index).get('name'),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              SizeConfig().scaleTextFont(26),
                                          color: Color(0XFF303030),
                                          fontFamily: 'Montserrat',
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateSubCategoryScreen(
                                                      subCategories:
                                                          getSubCategories(
                                                              snapshot: data
                                                                  .elementAt(
                                                                      index)),
                                                    )));
                                      },
                                      icon: Icon(Icons.edit),
                                    ),
                                    IconButton(
                                      onPressed: () async {
                                        await deleteSubCategories(
                                            path: data.elementAt(index).id);
                                      },
                                      icon: Icon(Icons.delete),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 20,
                            );
                          },
                          itemCount: data.length);
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
                              style:
                                  TextStyle(fontSize: 22, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> deleteSubCategories({required String path}) async {
    bool status = await FbStoreController()
        .delete(path: path, collectionName: 'Subcategories');

    return status;
  }

  SubCategories getSubCategories({required QueryDocumentSnapshot snapshot}) {
    SubCategories categories = SubCategories();
    categories.path = snapshot.id;
    categories.name = snapshot.get('name');
    categories.idMainCategories = widget.mainCategories.path;

    return categories;
  }
}
