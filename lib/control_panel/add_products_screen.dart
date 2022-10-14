import 'dart:io';

import 'package:admin_app_flutter/firebase/firestore/fb_storage_controlle.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/product_model.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/utils/helpers.dart';
import 'package:admin_app_flutter/widgets/app_button_main.dart';
import 'package:admin_app_flutter/widgets/app_text_field.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsScreen extends StatefulWidget {
  late String idSubCategories;

  AddProductsScreen({required this.idSubCategories});

  @override
  _AddProductsScreenState createState() => _AddProductsScreenState();
}

class _AddProductsScreenState extends State<AddProductsScreen> with Helpers {
  late TextEditingController productsName;
  late TextEditingController shortDescription;
  late TextEditingController description;
  late TextEditingController price;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late String url;

  @override
  void initState() {
    // TODO: implement initState
    productsName = TextEditingController();
    shortDescription = TextEditingController();
    description = TextEditingController();
    price = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    productsName.dispose();
    shortDescription.dispose();
    description.dispose();
    price.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0XFF273246),
        elevation: 0,
        title: Text(
          'Add Products ',
          style: TextStyle(
              fontSize: SizeConfig().scaleTextFont(26),
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: ListView(
          // primary: false,
          //   physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 0),
                        color: Colors.black.withOpacity(0.61),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      child: pickedImage != null
                          ? Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(
                                    File(pickedImage!.path),
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(50),
                              ),
                              width: 100,
                              height: 100,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey[800],
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "Add Image",
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig().scaleHeight(20)),
            Text(
              'Product Name',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: SizeConfig().scaleHeight(10)),
            AppTextField(hint: "product name ", controller: productsName),
            SizedBox(height: 20),
            Text(
              'Short description ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: SizeConfig().scaleHeight(10)),
            AppTextField(
                hint: "short description", controller: shortDescription),
            SizedBox(height: SizeConfig().scaleHeight(20)),
            Text(
              'description ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: SizeConfig().scaleHeight(10)),
            AppTextField(hint: "description", controller: description),
            SizedBox(height: SizeConfig().scaleHeight(20)),
            Text(
              'Price ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: SizeConfig().scaleHeight(10)),
            AppTextField(
              hint: "price",
              controller: price,
              textInputType: TextInputType.number,
            ),
            SizedBox(height: SizeConfig().scaleHeight(10)),
            AppButtonMain(
                onPressed: () async {
                  if (await performAddProducts()) {
                    Navigator.pop(context);
                  } else {
                    showSnackBar(
                        context: context,
                        content: 'error in add categories',
                        error: true);
                  }
                },
                title: 'save'),
            SizedBox(height: 10),
            AppButtonMain(
                onPressed: () {
                  Navigator.pop(context);
                },
                title: 'cancel'),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: _currentValue,
            ),
          ]),
    );
  }

  Future<bool> performAddProducts() async {
    if (checkData()) {
      await FbStoreController()
          .createProduct(products: products, collectionName: 'Products');

      return true;
    }
    return false;
  }

  bool checkData() {
    if (productsName.text.isNotEmpty &&
        price.text.isNotEmpty &&
        shortDescription.text.isNotEmpty &&
        description.text.isNotEmpty) {
      if (pickedImage != null) {
        // showSnackBar(context: context, content: 'select pick image true');
        return true;
      }
      showSnackBar(
          context: context, content: 'please select an image', error: false);
      return false;
    }
    showSnackBar(
        context: context, content: 'please enter required data', error: true);
    return false;
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    leading: new Icon(Icons.photo_library),
                    title: new Text('Photo Library'),
                    onTap: () {
                      pickImageGallery();
                      Navigator.of(context).pop();
                    }),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    pickImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<void> pickImageCamera() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 25);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
      setState(() {});
      uploadImage();
    }
  }

  void uploadImage() {
    _currentValue = null;
    if (pickedImage != null) {
      FbStorageControlle().upload(
        pickedFile: File(pickedImage!.path),
        eventsHandler: (bool status, String message, TaskState state,
            {Reference? reference}) async {
          if (status) {
            showSnackBar(context: context, content: message);
            changeCurrentIndicator(1);
            downloadURLExample(reference: reference);
          } else {
            if (status == TaskState.running) {
              print('The running Downloader ');
              changeCurrentIndicator(0);
            } else {
              // showSnackBar(context: context, content: message, error: true);
              changeCurrentIndicator(null);
            }
          }
        },
      );
    } else {
      showSnackBar(
          context: context, content: 'Pick image to upload', error: true);
    }
  }

  void changeCurrentIndicator(double? currentIndicator) {
    setState(() {
      _currentValue = currentIndicator;
    });
  }

  Future<void> downloadURLExample({Reference? reference}) async {
    url = await reference!.getDownloadURL();

    // Within your widgets:
    // Image.network(downloadURL);
  }

  Products get products {
    Products products = Products();
    products.name = productsName.text;
    products.shortDescription = shortDescription.text;
    products.description = description.text;
    products.price = price.text;
    products.imagePath = url;
    products.idSubCategories = widget.idSubCategories;
    return products;
  }
}
