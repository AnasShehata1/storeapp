import 'dart:developer';
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
  String? productName, desc, image, price;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
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
                const SizedBox(height: 100),
                CustomTextField(
                  hintText: 'Product Name',
                  onChange: (data) {
                    productName = data;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Description',
                    onChange: (data) {
                      desc = data;
                    }),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Price',
                    inputType: TextInputType.number,
                    onChange: (data) {
                      price = data;
                    }),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Image',
                    onChange: (data) {
                      image = data;
                    }),
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
}
