import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp/utils/utils.dart';
import 'package:myapp/widget/button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Utils _utils = Utils();
  Uint8List? _file;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
          child: Column(
            children: [
              Container(
                height: size.height / 2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                  image: _file == null
                      ? null
                      : DecorationImage(
                          image: MemoryImage(_file!),
                          fit: BoxFit.fill,
                          alignment: FractionalOffset.topCenter,
                        ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Choose Image From",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              _file != null
                  ? Center(
                      child: CustomButton(ontap: () {}, text: "Scan Image"),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                            text: "Camera",
                            ontap: () async {
                              Uint8List? file =
                                  await _utils.pickImage(ImageSource.camera);
                              setState(() {
                                _file = file;
                              });
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        CustomButton(
                          text: "Gallery",
                          ontap: () async {
                            Uint8List? file =
                                await _utils.pickImage(ImageSource.gallery);
                            setState(() {
                              _file = file;
                            });
                          },
                        )
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
