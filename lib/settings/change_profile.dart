import 'dart:io';

import 'package:admin_app_flutter/firebase/firebase_auth/fb_auth_controller.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_storage_controlle.dart';
import 'package:admin_app_flutter/firebase/firestore/fb_store_controller.dart';
import 'package:admin_app_flutter/model/main_categories.dart';
import 'package:admin_app_flutter/model/user_model.dart';
import 'package:admin_app_flutter/responsive/size_config.dart';
import 'package:admin_app_flutter/utils/helpers.dart';
import 'package:admin_app_flutter/widgets/app_button_main.dart';
import 'package:admin_app_flutter/widgets/app_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';
import 'package:image_picker/image_picker.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({Key? key}) : super(key: key);

  @override
  _ChangeProfileState createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> with Helpers {
  ImagePicker imagePicker = ImagePicker();
  XFile? pickedImage;
  double? _currentValue = 0;
  late TextEditingController _username;
  late User _user;
  late String url;

  // ImagesGetxController controller = Get.put(ImagesGetxController());
  // FbStoreController storeController = FbStoreController();

  @override
  void initState() {
    // TODO: implement initState
    _user = FbAuthController().user;
    _username = TextEditingController(text: _user.displayName ?? 'No Name');
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _username.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: backButton,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Color(0XFF273246),
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
            'Change Profile ',
            style: TextStyle(
                fontSize: SizeConfig().scaleTextFont(28),
                // fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontFamily: 'Montserrat'),
          ),
        ),
        body: Card(
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: SizeConfig().scaleWidth(50), vertical: SizeConfig().scaleHeight(10)),
            child:
                SingleChildScrollView(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: SizeConfig().scaleHeight(10)),
                      DecoratedBox(
                        decoration:
                            BoxDecoration(shape: BoxShape.circle, boxShadow: [
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
                                        image: FileImage(
                                          File(pickedImage!.path),
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(50)),
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
                      SizedBox(width: SizeConfig().scaleWidth(10)),
                      Text(
                        "change Image",
                        style: TextStyle(
                          fontSize: SizeConfig().scaleTextFont(14),
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
                  'Update Name',
                  style: TextStyle(
                    fontSize: SizeConfig().scaleTextFont(20),
                  ),
              ),
              SizedBox(height: SizeConfig().scaleHeight(20)),
              AppTextField(hint: "user name", controller: _username),
              SizedBox(height: SizeConfig().scaleHeight(20)),
              AppButtonMain(
                    onPressed: () async {
                      await performUpdateNameImage();
                    },
                    title: 'save'),
              SizedBox(height: SizeConfig().scaleHeight(10)),
              AppButtonMain(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    title: 'cancel'),
              SizedBox(height: SizeConfig().scaleHeight(10)),
              LinearProgressIndicator(
                  value: _currentValue,
              ),
            ]),
                ),
          ),
        ),
      ),
    );
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
    pickedImage = await imagePicker.pickImage(source: ImageSource.camera,imageQuality: 25);
    if (pickedImage != null) {
      setState(() {});
      await uploadImage();
    }
  }

  Future<void> pickImageGallery() async {
    pickedImage = await imagePicker.pickImage(source: ImageSource.gallery,imageQuality: 25);
    if (pickedImage != null) {
      // showSnackBar(context: context, content: 'imagetrue');
      setState(() {});
      // upload();
      await uploadImage();
    }
  }

  Future<void> performUpdateNameImage() async {
    if (checkData()) {
      if (await updateDisplayName()) {}
      Navigator.pushReplacementNamed(context, '/profile_settings');
    }
  }

  bool checkData() {
    if (pickedImage != null) {
      return true;
    }
    showSnackBar(
        context: context, content: 'please pick image and enter your name');
    return false;
  }

  //   showSnackBar(context: context, content: 'Enter required data',error: true);
  //   return false;
  // }
  Future<bool> updateDisplayName() async {
    bool status =
        await FbAuthController().updateDisplayName(name: _username.text);
    if (status) {
      bool createUser = await FbStoreController()
          .createUser(userData: userData, collectionName: 'Admins');
      if (createUser) {
        showSnackBar(context: context, content: 'updated successfully');

        return true;
      }
    }
    showSnackBar(context: context, content: 'updated failed');

    return false;
  }

  Future<void> uploadImage() async {
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

  // UserModel get user {
  //   UserModel userModel = UserModel();
  //   userModel.name = _username.text;
  //   userModel.imagePath = url;
  //   return user;
  // }

  UserData get userData {
    UserData userData = UserData();
    userData.name = _username.text;
    userData.ImageUrl = url;
    return userData;
  }
  Future<bool> backButtonArrow() async {
    Navigator.pushReplacementNamed(context, '/profile_settings');

    return true;
  }

  Future<bool> backButton() async {
    Navigator.pushReplacementNamed(context, '/profile_settings');
    return true;
  }
}

