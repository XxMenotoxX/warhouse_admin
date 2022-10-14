import 'package:admin_app_flutter/model/product_model.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/widgets/app_text_montserat.dart';
import 'package:flutter/material.dart';

import '../control_panel/update_products_screen.dart';
import 'Cart.dart';

class ProductDetailsScreen extends StatefulWidget {
  late Products products;

  ProductDetailsScreen({required this.products});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
        // actions: [
        //   IconButton(
        //     onPressed: () {},
        //     icon: Icon(
        //       Icons.search,
        //       color: Colors.white,
        //     ),
        //   ),
        // ],
        title: Text(
          widget.products.name,
          style: TextStyle(
              fontSize: SizeConfig().scaleTextFont(28),
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
          top: SizeConfig().scaleHeight(95),
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadiusDirectional.only(topEnd: Radius.circular(40)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height: SizeConfig().scaleHeight(54),
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 20),
              padding: EdgeInsets.symmetric(
                horizontal: SizeConfig().scaleWidth(5),
              ),
              height: SizeConfig().scaleHeight(24),
              width: SizeConfig().scaleWidth(80),
              decoration: BoxDecoration(
                color: Color(0XFFFDBC02),
                borderRadius: BorderRadiusDirectional.circular(15),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: SizeConfig().scaleHeight(10),
                  ),
                  SizedBox(
                    width: SizeConfig().scaleWidth(10),
                  ),
                  Flexible(
                    child: Text(
                      '${widget.products.subCategoriesName}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig().scaleTextFont(14),
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(10),
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(start: 20),
                child:
                    AppTexMontseratBlack(titleOfButton: widget.products.name)),
            SizedBox(
              height: SizeConfig().scaleHeight(20),
            ),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: SizeConfig().scaleWidth(167),
                      height: SizeConfig().scaleHeight(294),
                      child: Text(
                        widget.products.description,
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w500,
                          color: Color(0XFF828894),
                          fontSize: SizeConfig().scaleTextFont(16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig().scaleWidth(15),
                  ),
                  Expanded(
                    child: Image(
                      image: NetworkImage(widget.products.imagePath),
                      width: SizeConfig().scaleWidth(249),
                      height: SizeConfig().scaleHeight(345),
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig().scaleHeight(29),
            ),
            Expanded(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 20),
                    child: Text(
                      ('\$${widget.products.price}'),
                      style: TextStyle(
                        fontSize: SizeConfig().scaleTextFont(28),
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        color: Color(0XFF303030),
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: EdgeInsetsDirectional.only(start: 20),
                  //       child: Text(
                  //         ('Product Count'),
                  //         style: TextStyle(
                  //           fontSize: SizeConfig().scaleTextFont(28),
                  //           fontFamily: 'Montserrat',
                  //           fontWeight: FontWeight.w700,
                  //           color: Color(0XFF303030),
                  //         ),
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsetsDirectional.only(start: 20),
                  //       child: Text(
                  //         ('${widget.products.productCount}'),
                  //         style: TextStyle(
                  //           fontSize: SizeConfig().scaleTextFont(28),
                  //           fontFamily: 'Montserrat',
                  //           fontWeight: FontWeight.w700,
                  //           color: Color(0XFF303030),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
            // SizedBox(height: SizeConfig().scaleHeight(84),),
            Container(
              padding: EdgeInsets.only(
                top: SizeConfig().scaleHeight(20),
                right: SizeConfig().scaleWidth(24),
                left: SizeConfig().scaleWidth(24),
                // horizontal: SizeConfig().scaleWidth(24),
                // vertical: SizeConfig().scaleHeight(10),
              ),
              height: SizeConfig().scaleHeight(116),
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: AlignmentDirectional.topEnd,
                    end: AlignmentDirectional.bottomStart,
                    colors: [Color(0XFF273246), Color(0XFF181D29)]),
                borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => MyCart(),
                  //       ),
                  //     );
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //         color: Colors.transparent,
                  //         borderRadius: BorderRadius.circular(8),
                  //         border: Border(
                  //           top: BorderSide(
                  //             color: Color(0XFF8E8E8E),
                  //           ),
                  //           bottom: BorderSide(
                  //             color: Color(0XFF8E8E8E),
                  //           ),
                  //           right: BorderSide(
                  //             color: Color(0XFF8E8E8E),
                  //           ),
                  //           left: BorderSide(
                  //             color: Color(0XFF8E8E8E),
                  //           ),
                  //         )),
                  //     child: Icon(
                  //       Icons.local_shipping,
                  //       color: Color(0XFF8E8E8E),
                  //       size: SizeConfig()
                  //           .scaleHeight(SizeConfig().scaleHeight(26)),
                  //     ),
                  //     padding: EdgeInsets.all(10),
                  //   ),
                  // ),
                  SizedBox(
                    width: SizeConfig().scaleWidth(16),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      MaterialPageRoute(
                        builder: (context) => UpdateProductsScreen(
                          products: widget.products,
                        ),
                      );
                    },
                    child: Text(
                      'Update Product ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig().scaleTextFont(18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0XFFFDBC02),
                      minimumSize: Size(SizeConfig().scaleWidth(251),
                          SizeConfig().scaleHeight(55)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    
  }
  
}
