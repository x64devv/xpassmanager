import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpassmanager/model/cartegory_model.dart';
import 'package:xpassmanager/model/datase_helper.dart';
import 'package:xpassmanager/model/file_hander.dart';

import '../../../components/avatar_card.dart';
import '../../../components/input_field.dart';
import '../../../components/lottie_widget.dart';
import '../../../components/x_button.dart';
import '../../constants.dart';

class AddCartegorySheet extends StatefulWidget {
  AddCartegorySheet({
    super.key,
    required this.size,
    required this.saveCartegory,
  });
  final Size size;
  CartegoryModel cartegory = CartegoryModel();
  Function(CartegoryModel) saveCartegory;

  @override
  State<AddCartegorySheet> createState() => _AddCartegorySheetState();
}

class _AddCartegorySheetState extends State<AddCartegorySheet> {
  String newCartegory = "";
  String selectedPath = kDefaultCartegoryImage;
  String fileName = "";
  final picker = ImagePicker();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: widget.size.height * 0.50,
      width: widget.size.width,
      decoration: BoxDecoration(
        color: kColorSecondary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Row(
              children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: kColorAccent,
                    )),
                const SizedBox(
                  width: 8,
                ),
                Text("Add Cartegory",
                    style: GoogleFonts.montserrat(
                        color: kColorAccent,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Form(
              key: key,
              child: Column(
                children: [
                  InputField(
                      hint: "Enter Cartegory Name",
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isNotEmpty) {
                          return null;
                        }
                        return "        Cartegory can't be empty!";
                      },
                      onChanged: (value) {
                        widget.cartegory.cartegoryName = value;
                      },
                      icon: Icons.group_work_rounded),
                  const SizedBox(
                    height: 8,
                  ),
                  AvatarCard(image: selectedPath),
                  const SizedBox(
                    height: 8,
                  ),
                  TextButton(
                      onPressed: () async {
                        XFile? pickedImage =
                            await picker.pickImage(source: ImageSource.gallery);
                        selectedPath = pickedImage!.path.toString();
                        fileName = pickedImage.name;
                        String localpath = await localPathAvatars();
                        File avatar = File(selectedPath);
                        File avatarCopy =
                            await avatar.copy(localpath + fileName);
                        if (avatarCopy.existsSync()) {
                          widget.cartegory.avatarPath = avatarCopy.path;
                          setState(() {
                            selectedPath = avatarCopy.path;
                          });
                        }
                      },
                      child: Text(
                        "Change Cartegory Avatar",
                        style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: kColorPrimary),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  XButton(
                      text: "Save",
                      color: kColorAccent,
                      textColor: kColorPrimary,
                      fontWeight: FontWeight.bold,
                      onTap: () {
                        if (key.currentState!.validate()) {
                          key.currentState!.save();
                          widget.saveCartegory(widget.cartegory);
                          Navigator.pop(context);
                        }
                      }),
                  const SizedBox(
                    height: 8,
                  ),
                  XButton(
                      text: "Cancel",
                      color: kColorPrimary,
                      textColor: kColorAccent,
                      fontWeight: FontWeight.bold,
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
