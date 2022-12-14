import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpassmanager/components/lottie_widget.dart';

import '../../../components/account_cartegory.dart';
import '../../../components/avatar_card.dart';
import '../../../components/input_field.dart';
import '../../../components/x_button.dart';
import '../../../model/cartegory_model.dart';
import '../../../model/datase_helper.dart';
import '../../../model/file_hander.dart';
import '../../../model/password_model.dart';
import '../../constants.dart';

class AccountSheet extends StatefulWidget {
  AccountSheet({
    Key? key,
    required this.size,
    required this.passwordModel,
    required this.savePassword,
  }) : super(key: key);
  final PasswordModel passwordModel;
  void Function(PasswordModel) savePassword;

  final Size size;

  @override
  State<AccountSheet> createState() => _AccountSheetState();
}

class _AccountSheetState extends State<AccountSheet> {
  String generatedPin = "";

  bool obscureText = false;

  int selectedCartegory = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        height: widget.size.height * 0.95,
        width: widget.size.width,
        decoration: BoxDecoration(
            color: kColorPrimary,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32), topRight: Radius.circular(32))),
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
                  Text(
                    "New Account",
                    style: textStyle(true, 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 70,
                width: 70,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: kColorSecondary),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: widget.passwordModel.siteIcon!.isEmpty
                    ? Icon(
                        Icons.image_rounded,
                        color: kColorSecondary,
                        size: 26,
                      )
                    : AvatarCard(image: widget.passwordModel.siteIcon!),
              ),
              TextButton(
                child: Text(
                  "Change icon",
                  style: textStyle(false, 12, color: kColorSecondary),
                ),
                onPressed: () async {
                  ImagePicker picker = ImagePicker();
                  XFile? pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                  String selectedPath = pickedImage!.path.toString();
                  String fileName = pickedImage.name;
                  String localpath = await localPathAvatars();
                  File avatar = File(selectedPath);
                  File avatarCopy = await avatar.copy(localpath + fileName);
                  if (avatarCopy.existsSync()) {
                    debugPrint("File copied successfully");
                    setState(() {
                      widget.passwordModel.siteIcon = avatarCopy.path;
                    });
                  } else {
                    debugPrint("File copy failed");
                  }
                },
              ),
              const SizedBox(
                height: 8,
              ),
              InputField(
                  text: widget.passwordModel.site!,
                  hint: "Site Name",
                  fontSize: 12,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty()) {
                      return "Field can't be empty.";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.passwordModel.site = value;
                  },
                  icon: Icons.text_format),
              const SizedBox(
                height: 8,
              ),
              InputField(
                  text: widget.passwordModel.site!,
                  hint: "Website/App",
                  fontSize: 12,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty()) {
                      return "Field can't be empty.";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.passwordModel.name = value;
                  },
                  icon: Icons.link_rounded),
              const SizedBox(
                height: 8,
              ),
              InputField(
                  text: widget.passwordModel.user!,
                  hint: "Email/Username/Phone",
                  fontSize: 12,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty()) {
                      return "Field can't be empty.";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    widget.passwordModel.user = value;
                  },
                  icon: Icons.text_format),
              const SizedBox(
                height: 8,
              ),
              Column(
                children: [
                  InputField(
                      text: widget.passwordModel.pass!,
                      obscureText: obscureText,
                      hint: "Password/Pin",
                      fontSize: 12,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty()) {
                          return "Field can't be empty.";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        widget.passwordModel.pass = value;
                      },
                      icon: Icons.lock_rounded),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                          onPressed: () {
                            widget.passwordModel.pass =
                                generatePassword(true, true, true, true, 12);
                          },
                          child: Row(
                            children: [
                              Text(
                                "Auto Generate",
                                style:
                                    textStyle(true, 12, color: kColorSecondary),
                              ),
                              Icon(
                                Icons.settings,
                                color: kColorSecondary,
                                size: 16,
                              ),
                            ],
                          )),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Text(
                                "Show",
                                style:
                                    textStyle(true, 12, color: kColorSecondary),
                              ),
                              Icon(
                                Icons.visibility_rounded,
                                color: kColorSecondary,
                                size: 16,
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Select Cartegory",
                style: textStyle(true, 16),
              ),
              const SizedBox(
                height: 8,
              ),
              FutureBuilder(
                  initialData: const <CartegoryModel>[],
                  future: fetchCartegories(),
                  builder:
                      (context, AsyncSnapshot<List<CartegoryModel>> snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return Container(
                          height: 100,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) => AccountCartegory(
                                    cartegory:
                                        snapshot.data![index].cartegoryName!,
                                    icon: Material(
                                      color: widget.passwordModel.cartegory ==
                                              snapshot.data![index].id
                                          ? kColorSecondary
                                          : Colors.transparent,
                                      child: InkWell(
                                        splashColor: kColorAccent,
                                        onTap: () {
                                          setState(() {
                                            widget.passwordModel.cartegory =
                                                snapshot.data![index].id;
                                          });
                                        },
                                        child: AvatarCard(
                                            image: snapshot
                                                .data![index].avatarPath!),
                                      ),
                                    ),
                                  )));
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                            "You need to add atleast one cartegory to add a password for easy navigation",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: kColorSecondary)),
                      );
                    }
                  }),
              const SizedBox(
                height: 8,
              ),
              XButton(
                  text: "Save Account",
                  color: kColorAccent,
                  textColor: kColorPrimary,
                  fontWeight: FontWeight.bold,
                  onTap: () {
                    widget.passwordModel.dateAdded = dateFormat(DateTime.now());
                    if (widget.passwordModel.cartegory == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kColorSecondary,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                "Password need to have cartegory assigned!",
                                textAlign: TextAlign.center,
                                style:
                                    textStyle(false, 12, color: kColorPrimary),
                              ))));
                      return;
                    }
                    widget.savePassword(widget.passwordModel);
                    Navigator.pop(context);
                  }),
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
        ));
  }

  String generatePassword(bool _isWithLetters, bool _isWithUppercase,
      bool _isWithNumbers, bool _isWithSpecial, double _numberCharPassword) {
    //Define the allowed chars to use in the password
    String _lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
    String _upperCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    String _numbers = "0123456789";
    String _special = "@#=+!£\$%&?[](){}";

    //Create the empty string that will contain the allowed chars
    String _allowedChars = "";

    //Put chars on the allowed ones based on the input values
    _allowedChars += (_isWithLetters ? _lowerCaseLetters : '');
    _allowedChars += (_isWithUppercase ? _upperCaseLetters : '');
    _allowedChars += (_isWithNumbers ? _numbers : '');
    _allowedChars += (_isWithSpecial ? _special : '');

    int i = 0;
    String _result = "";

    //Create password
    while (i < _numberCharPassword.round()) {
      //Get random int
      int randomInt = Random.secure().nextInt(_allowedChars.length);
      //Get random char and append it to the password
      _result += _allowedChars[randomInt];
      i++;
    }

    return _result;
  }
}
