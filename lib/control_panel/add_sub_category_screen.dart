import 'dart:io';

import 'package:admin_app_flutter/firebase/firestore/fb_storage_controlle.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/model/subcategories_model.dart';
import 'package:admin_app_flutter/utils/helpers.dart';
import 'package:admin_app_flutter/widgets/app_button_main.dart';
import 'package:admin_app_flutter/widgets/app_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddSubCategoryScreen extends StatefulWidget {

  late String pathMainCategories;


  AddSubCategoryScreen({required this.pathMainCategories});

  @override
  _AddSubCategoryScreenState createState() => _AddSubCategoryScreenState();
}

class _AddSubCategoryScreenState extends State<AddSubCategoryScreen>
    with Helpers {
  late TextEditingController _categoryTextController;

  @override
  void initState() {
    // TODO: implement initState
    _categoryTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0XFF273246),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Sub Categories',
          style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: 'Montserrat'),
        ),
      ),
      body: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            Text(
              'Add New Sub Category',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
                hint: "add sub category", controller: _categoryTextController),
            SizedBox(height: 20),


            AppButtonMain(onPressed: () async {
              if(await performAddSubCategories()){
                Navigator.pop(context);
              }
              else{
                showSnackBar(context: context, content: 'error in add  sub categories',error: false);
              }

            }, title: 'save'),
            SizedBox(height: 10),
            AppButtonMain(
                onPressed: () {
                  Navigator.pop(context);
                },
                title: 'cancel'),

          ]),
        ),
      ),
    );
  }

  Future<bool> performAddSubCategories() async {
    if (checkData()) {
    await addSubCategories();
    return true;
  }
    return false;
  }

  bool checkData() {
    if (_categoryTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> addSubCategories() async {
    return await FbStoreController().createSubCategories(
        subCategories: subCategories, collectionName: 'Subcategories');
  }

  SubCategories get subCategories {
    SubCategories subCategories = SubCategories();
    subCategories.name = _categoryTextController.text;
    subCategories.idMainCategories = widget.pathMainCategories;
    return subCategories;
  }


}
