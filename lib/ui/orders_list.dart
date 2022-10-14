import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/product_model.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/ui/product_log.dart';
import 'package:admin_app_flutter/widgets/app_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsLogsListScreen extends StatefulWidget {
  ProductsLogsListScreen();

  @override
  _ProductsLogsListScreenState createState() => _ProductsLogsListScreenState();
}

class _ProductsLogsListScreenState extends State<ProductsLogsListScreen> {
  late TextEditingController _controller;
  late String? _value;

  late Iterable<QueryDocumentSnapshot> data;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 60,
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
        title: Text(
          "Orders",
          style: TextStyle(
              fontSize: SizeConfig().scaleTextFont(28),
              // fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(
          top: SizeConfig().scaleHeight(30),
          right: SizeConfig().scaleWidth(15),
          left: SizeConfig().scaleWidth(15),
          bottom: SizeConfig().scaleHeight(13),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
              colors: [
                Color(0XFF273246),
                Color(0XFF181D29),
              ]),
        ),
        child: ListView(
          children: [
            AppTextField(
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
            SizedBox(
              height: SizeConfig().scaleHeight(30),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore
                    .collection('productsLogs')
                    .orderBy('orderId', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    data = snapshot.data!.docs;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              print("object   ");
                              var products = data
                                  .elementAt(index)
                                  .get("product") as List<dynamic>;
                              List<Products> productsData = [];
                              products.forEach((e) {
                                productsData.add(Products.fromMap(e));
                              });
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsLogsScreen(
                                    products: productsData,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: SizeConfig().scaleHeight(5)),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.white,
                                ),
                                child: ListTile(
                                    title: Text(
                                      "${data.elementAt(index).get("userId")}",
                                      style:
                                          TextStyle(color: Colors.deepOrange),
                                    ),
                                    subtitle: Text(
                                      "${data.elementAt(index).get("orderId")}",
                                      style: TextStyle(color: Colors.blueGrey),
                                    ),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 25),
                                          child: Text(
                                            "items: ${data.elementAt(index).get("numberOfProducts")}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            "total: ${data.elementAt(index).get("totalPrice")}\$",
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ))),
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
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }

  Products getProduct(QueryDocumentSnapshot snapshot) {
    Products products = Products();
    products.path = snapshot.id;
    products.name = snapshot.get('name');
    products.price = snapshot.get('price');
    products.imagePath = snapshot.get('imagePath');
    products.productCount = snapshot.get('productCount');
    products.description = snapshot.get('description');
    products.shortDescription = snapshot.get('shortDescription');
    products.subCategoriesName = "";
    products.idSubCategories = "widget.subCategories.path";

    return products;
  }

  Future<bool> deleteProducts({required String path}) async {
    bool status = await FbStoreController()
        .delete(path: path, collectionName: 'Products');

    return status;
  }
}
