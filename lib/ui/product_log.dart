import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/product_model.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/widgets/app_search_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsLogsScreen extends StatefulWidget {
  List<Products> products;
  ProductsLogsScreen({required this.products});

  @override
  _ProductsLogsScreenState createState() => _ProductsLogsScreenState();
}

class _ProductsLogsScreenState extends State<ProductsLogsScreen> {
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
                stream:
                    FbStoreController().read(collectionName: 'productsLogs'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    data = snapshot.data!.docs;
                    return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: SizeConfig().scaleWidth(20),
                          mainAxisSpacing: SizeConfig().scaleHeight(15),
                          childAspectRatio: (SizeConfig().scaleWidth(164)) /
                              (SizeConfig().scaleHeight(310)),
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              height: SizeConfig().scaleHeight(300),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset(
                                  //   'images/softdrink.jpg',
                                  //   fit: BoxFit.cover,
                                  //   height: SizeConfig().scaleHeight(196),
                                  //   width: double.infinity,
                                  // ),
                                  Image(
                                    height: SizeConfig().scaleHeight(196),
                                    width: double.infinity,
                                    image: NetworkImage(
                                      widget.products[index].imagePath,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig().scaleHeight(10),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: SizeConfig().scaleHeight(10),
                                      left: SizeConfig().scaleHeight(10),
                                    ),
                                    child: Text(
                                      widget.products[index].name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: SizeConfig().scaleHeight(10),
                                        left: SizeConfig().scaleHeight(10),
                                        top: SizeConfig().scaleHeight(5),
                                      ),
                                      child: RichText(
                                        overflow: TextOverflow.ellipsis,
                                        text: TextSpan(
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 10,
                                          ),
                                          text: widget
                                              .products[index].description,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          start: SizeConfig().scaleHeight(10),
                                          end: SizeConfig().scaleHeight(15),
                                          bottom: SizeConfig().scaleHeight(10),
                                        ),
                                        child: Text(
                                          widget.products[index].price + '\$',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsetsDirectional.only(
                                          bottom: SizeConfig().scaleHeight(10),
                                        ),
                                        child: Text(
                                          'Quantity: ' +
                                              widget
                                                  .products[index].productCount.toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),

                                      Spacer(),
                                      // GestureDetector(
                                      //   child: Icon(
                                      //     Icons.edit,
                                      //     color: Color(0XFFFDBC02),
                                      //   ),
                                      //   onTap: () async {
                                      //     Navigator.push(
                                      //       context,
                                      //       MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             UpdateProductsScreen(
                                      //           products: getProduct(
                                      //             data.elementAt(index),
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     );
                                      //   },
                                      // ),
                                      SizedBox(
                                        width: SizeConfig().scaleWidth(10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: widget.products.length);
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
