import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../firebase/firestore/fb_store_controller.dart';
import '../model/product_model.dart';
import '../utils/helpers.dart';

class MyCart extends StatefulWidget {
  const MyCart({Key? key}) : super(key: key);

  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> with Helpers {
  List<QueryDocumentSnapshot> data = [];
  List products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF273246),
      appBar: AppBar(
        centerTitle: true,
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
        title: Text(
          'Place Shippment',
          style: TextStyle(
              fontSize: 28,
              // fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.only(topEnd: Radius.circular(40)),
        ),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: FbStoreController().readUserProductCart(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData &&
                      snapshot.data!.docs.isNotEmpty) {
                    data = snapshot.data!.docs;
                    //    products = data.map((e) => Products.fromMap(e.data())).toList();
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Card(
                              elevation: 10,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                              ),
                              child: Stack(
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topEnd,
                                    child: IconButton(
                                        onPressed: () async {
                                          await deleteItem(data[index].id);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.grey,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image(
                                          image: NetworkImage(
                                            data[index].get('imagePath'),
                                          ),
                                          height: 80,
                                          width: 80,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data[index].get('name'),
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                              ),
                                              // SizedBox(height: 10,),
                                              // Text('2 weight',style: TextStyle(
                                              //   fontSize: 15,color: Colors.grey,
                                              // ),),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '${data[index].get('price')}\$',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0XFFFF8236),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        // Padding(
                                        //   padding: EdgeInsets.only(top: 30),
                                        //   child: SizedBox(
                                        //     height: 50,
                                        //     child: Card(
                                        //       shape: RoundedRectangleBorder(
                                        //           borderRadius: BorderRadius.circular(
                                        //               5),
                                        //           side: BorderSide(
                                        //               color: Colors.grey,
                                        //               width: 2
                                        //           )
                                        //       ),
                                        //       child: Row(
                                        //         children: [
                                        //           IconButton(onPressed: () {},
                                        //             icon: Icon(Icons.minimize),),
                                        //           VerticalDivider(color: Colors.grey,
                                        //             thickness: 2,),
                                        //           Text('2kg', style: TextStyle(
                                        //               color: Colors.grey,
                                        //               fontSize: 14),),
                                        //           VerticalDivider(color: Colors.grey,
                                        //             thickness: 2,),
                                        //           IconButton(onPressed: () {},
                                        //             icon: Icon(Icons.add),),
                                        //         ],
                                        //       ),
                                        //     ),
                                        //   ),
                                        // )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
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
            Spacer(),
            // Card(
            //   elevation: 10,
            //   color: Colors.white,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadiusDirectional.only(
            //       topEnd: Radius.circular(40),
            //       topStart: Radius.circular(40),
            //     ),
            //   ),
            //   child: Padding(
            //     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            //     child: Column(
            //       children: [
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               ' Items',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xff36596A),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               ' 6.000',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xff36596A),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 15,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               ' Sub total',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xff36596A),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               ' 21.00',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xff36596A),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 15,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               ' Delivery charge',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xff36596A),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             Text(
            //               ' 05.00',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xff36596A),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 15,
            //         ),
            //         Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Text(
            //               ' Total',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xffFF8236),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //             SizedBox(
            //               width: 230,
            //             ),
            //             Text(
            //               ' 26.00',
            //               style: TextStyle(
            //                   fontSize: 15,
            //                   color: Color(0xffFF8236),
            //                   fontWeight: FontWeight.bold),
            //             ),
            //           ],
            //         ),
            //         SizedBox(
            //           height: 40,
            //         ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                        colors: [
                          Color(0XFF273246),
                          Color(0XFF181D29),
                        ])),
                child: ElevatedButton(
                  onPressed: () {
                    List<Products> products = [];
                    // Navigator.pushNamed(context, '/AddDelates');
                    // FbStoreController().makeOrder(products: products);
                    data.map((e) {
                      // print e values
                      print(e.get('name'));
                      print(e.get('price'));
                      print(e.get('description'));
                      print(e.get('productCount'));
                      print(e.get('shortDescription'));

                      Products product = Products();
                      product.path = e.id;
                      product.name = e.get('name') ?? "";
                      product.price = e.get('price') ?? "";
                      product.imagePath = e.get('imagePath') ?? "";
                      product.description = e.get('description') ?? "";
                      product.productCount = e.get('productCount') ?? "";
                      product.shortDescription =
                          e.get('shortDescription') ?? "";
                      product.subCategoriesName = "";

                      products.add(product);
                    }).toList();
                    FbStoreController().createProductsLogs(
                        product: products, collectionName: 'productsLogs');
                   //when order is created, delete all products from cart 
showSnackBar(context: context, content: 'Order prepared');
                    FbStoreController().deleteAllProductsFromCart();
                  },

                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      primary: Colors.transparent),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> deleteItem(String path) async {
    bool status = await FbStoreController().deleteProducts(path: path);
    if (status) {
      showSnackBar(context: context, content: 'Deleted done');
    } else {
      showSnackBar(context: context, content: 'Deleted failed', error: true);
    }
  }
}

/*
 Card(
                    elevation: 10,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.clear, color: Color(0xff9A9A9A)),
                        Row(
                          //crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Card(
                              child: Image.asset(
                                'images/coco1.jpg',
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              ),
                              clipBehavior: Clip.antiAlias,
                              elevation: 10,
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Column(
                              children: [
                                Text(
                                  'Orange Juice',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff36596A)),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'White 2kg',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff9A9A9A),
                                  ),
                                ),
                                SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '25.00',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xffFF8236),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '29.00',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal,
                                        color: Color(0xff9A9A9A),
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0, left: 10),
                              child: Card(
                                elevation: 10,
                                child: Row(
                                  children: [
                                    Card(
                                      child: Icon(
                                        Icons.add,
                                        color: Color(0xff36596A),
                                      ),
                                    ),
                                    Card(
                                      child: Text(
                                        '2K',
                                        style:
                                            TextStyle(color: Color(0xff36596A)),
                                      ),
                                    ),
                                    Card(
                                        child: Icon(Icons.minimize,
                                            color: Color(0xff36596A))),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
 */
