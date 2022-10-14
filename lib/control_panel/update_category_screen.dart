import 'dart:io';

import 'package:admin_app_flutter/firebase/firestore/fb_storage_controlle.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/main.dart';
import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/utils/helpers.dart';
import 'package:admin_app_flutter/widgets/app_button_main.dart';
import 'package:admin_app_flutter/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UpdateCategoryScreen extends StatefulWidget {
  late MainCategories mainCategories;

  UpdateCategoryScreen({required this.mainCategories});

  @override
  _UpdateCategoryScreenState createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen>
    with Helpers {
  late TextEditingController _categoryTextController;
  late TextEditingController _desccategoryTextController;
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late TextEditingController _username;
  late User _user;
  late String url;

  @override
  void initState() {
    // TODO: implement initState
    _categoryTextController =
        TextEditingController(text: widget.mainCategories.name);
    _desccategoryTextController =
        TextEditingController(text: widget.mainCategories.description);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _categoryTextController.dispose();
    _desccategoryTextController.dispose();
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
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {},
        // ),
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
          'Update Categories',
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
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(height: 10),
              DecoratedBox(
                decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 0),
                    color: Colors.black.withOpacity(0.61),
                    blurRadius: 6,
                  )
                ]),
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
                                image: FileImage(File(pickedImage!.path)))))
                        : Container(
                      decoration:
                      BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(widget.mainCategories.imagePath),
                        ),
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
            ]),
            Divider(
              color: Colors.white70,
              indent: 10,
              endIndent: 10,
              height: 40,
            ),
            Text(
              'Update  Category',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
                hint: "update category", controller: _categoryTextController),
            SizedBox(height: 20),
            Text(
              'Update description ',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
            AppTextField(
                hint: "descripton category",
                controller: _desccategoryTextController),
            SizedBox(height: 20),
            AppButtonMain(onPressed: () async {
              if (await performUpdateNameImage()) {
                Navigator.pop(context);
              }
              else {
                showSnackBar(context: context,
                    content: 'error in update categories',
                    error: true);
              }
            }, title: 'update'),
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
        ),
      ),
    );
  }

  Future<bool> performUpdateNameImage() async {
    if (checkData()) {
      await FbStoreController().update(path: widget.mainCategories.path,
          mainCategories: mainCategories,
          collectionName: 'MainCategories');
      return true;
    }
    return false;
  }

  bool checkData() {
    if (_desccategoryTextController.text.isNotEmpty &&
        _categoryTextController.text.isNotEmpty) {
      if (pickedImage== null) {
        url = widget.mainCategories.imagePath;

        // showSnackBar(context: context, content: 'select pick image true');
        return true;
      }
      else{
        return true;
      }
      showSnackBar(context: context, content: 'please select an image',error: true);
      return false;
    }
    showSnackBar(context: context, content: 'please enter required data',error: true);
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
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {});
      await uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
      setState(() {});
      await uploadImage();
    }
  }

  Future<void> uploadImage()async {
    _currentValue = null;
    if (pickedImage != null) {
      FbStorageControlle().upload(
        pickedFile: File(pickedImage!.path),
        eventsHandler: (bool status, String message, TaskState state,
            {Reference? reference}) async {
          if (status) {
            showSnackBar(context: context, content: message);
            changeCurrentIndicator(1);
           await downloadURLExample(reference: reference);
          } else {
            if (status == TaskState.running) {
              print('The running Downloader ');
              changeCurrentIndicator(0);
            } else {
              showSnackBar(context: context, content: message, error: true);
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
    String urlGet = await reference!.getDownloadURL();
    if(urlGet == null){
      url = widget.mainCategories.imagePath;
    }
    else{
      url = urlGet;
    }

    // Within your widgets:
    // Image.network(downloadURL);
  }

// void _showPicker(context) {
//
//   showModalBottomSheet(
//       context: context,
//       builder: (BuildContext bc) {
//         return Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//
//                      // child: _pickedFile != null
//                      leading: new IconButton(onPressed: ()async => await pickImage(), icon: Icon(Icons.photo_library)),
//                     title: new Text('Photo Library'),
//
//                     ),
//                 new ListTile(
//                   leading: new Icon(Icons.photo_camera),
//                   title: new Text('Camera'),
//
//                 ),
//               ],
//             ),
//
//         );
//       }
//   );
//
// }
//
//
//
//
// Future<void> performCategory() async {
//   if (checkData()) {
//     await save();
//   }
// }
// bool checkData() {
//   if (_categoryTextController.text.isNotEmpty &&
//       _desccategoryTextController.text.isNotEmpty) {
//     return true;
//   }
//   showSnackBar(context: context, content: 'Enter required data',error: true);
//   return false;
// }
// Future<void> save() async {
//   bool status = await FbStoreController().create(mainCategories: mainCategories, collectionName: 'MainCategories');
//   if(status){
//     showSnackBar(context: context, content: 'saved successfully');
//     uploadImage();
//     clear();
//   }
// }
  MainCategories get mainCategories {
    MainCategories mainCategories = MainCategories();
    mainCategories.name = _categoryTextController.text;
    mainCategories.description = _desccategoryTextController.text;
    mainCategories.imagePath = url;
    return mainCategories;
  }
// void clear(){
//   _categoryTextController.text = '';
//   _desccategoryTextController.text = '';
//
// }
// Future<void> pickImage()async{
//   _pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//   if(_pickedFile != null){
//     setState(() {
//
//     });
//   }
// }
// void uploadImage(){
// if(_pickedFile != null){
//   FbStorageControlle().upload(
//     pickedFile: File(_pickedFile!.path),
//     eventsHandler: (bool status,
//         TaskState state,
//         String message,{Reference?reference}){
//       if(status){
//         showSnackBar(context: context, content: message);
//       }else {
//         if (status == TaskState.running) {
//           //
//         } else {
//           showSnackBar(context: context, content: message, error: true);
//         }
//       }
//     },
//   );
// }else{
//   showSnackBar(context: context, content: 'Pick image to upload', error: true);
//
// }
// }
}
