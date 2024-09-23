import 'dart:developer';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:storeapp/widgets/custom_button.dart';
import '../constant.dart';
import '../helper/show_snack_bar.dart';
import '../widgets/custom_text_field.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});
  static const id = 'add product view';

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  String? productName, price, url;
  File? image;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Add Product',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: url == null
                              ? const AssetImage(
                                  'assets/images/image_not_available.png')
                              : NetworkImage(url!),
                          fit: BoxFit.fill)),
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  hintText: 'Enter Product Name',
                  onChange: (data) {
                    productName = data;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                    hintText: 'Enter Price',
                    inputType: TextInputType.number,
                    onChange: (data) {
                      price = data;
                    }),
                const SizedBox(height: 15),
                MaterialButton(
                  color: Colors.grey[300],
                  onPressed: () {
                    uploadImage();
                  },
                  child: const Text(
                    'Upload Image',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: 'Add Product',
                  onTap: () async {
                    isLoading = true;
                    setState(() {});
                    try {
                      if (context.mounted) {
                        snackBarMsg(context, 'Success!');
                      }
                      isLoading = false;
                      setState(() {});
                    } catch (e) {
                      log(e.toString());
                      if (context.mounted) {
                        snackBarMsg(
                            context, 'Failed!  Please try again later.');
                        isLoading = false;
                        setState(() {});
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void uploadImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageGallery =
        await picker.pickImage(source: ImageSource.camera);
    if (imageGallery != null) {
      image = File(imageGallery.path);
      var imageName = basename(imageGallery.path);
      var refStorage = FirebaseStorage.instance.ref(imageName);
      await refStorage.putFile(image!);
      url = await refStorage.getDownloadURL();
    }

    setState(() {});
  }
  // void pickImage() async {
  //   var pickImage = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     image = pickImage;
  //   });
  // }

  // void uploadImage() async{
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   storage.bucket = 'gs://itistore-815d0.appspot.com';
  //   var ref = storage.ref().child(p.basename(image!.path));
  //   var storageUploadTask = ref.putFile(image!);
  //   var taskSnapShot = await storageUploadTask
  // }
  // Future<String> uploadImage() async {
  //   try {
  //     final ref = FirebaseStorage.instance.ref(path).child(image.path);
  //     await ref.putFile(File(image.path));
  //     final url = await ref.getDownloadURL();
  //     return url;
  //   } catch (e) {
  //     return e.toString();
  //   }
  // }
}
