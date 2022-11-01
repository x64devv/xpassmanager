import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpassmanager/components/avatar_card.dart';
import 'package:xpassmanager/model/datase_helper.dart';
import 'package:xpassmanager/model/user_model.dart';
import 'package:xpassmanager/screens/constants.dart';

import '../../model/file_hander.dart';

class ProfileSheet extends StatelessWidget {
  ProfileSheet({super.key, required this.user});
  UserModel user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
      height: size.height * 0.95,
      width: size.width,
      decoration: BoxDecoration(
        color: kColorPrimary,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(32)),
      ),
      child: Column(
        children: [
          EditAvatar(size: size, user: user),
          const SizedBox(
            height: 16,
          ),
          Text(
            "John Doe",
            style: GoogleFonts.montserrat(
                fontSize: 16, fontWeight: FontWeight.bold, color: kColorAccent),
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileOption(
            text: "Change Password",
            icon: Icons.key_rounded,
            onTap: () {},
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileOption(
            text: "Enable Fingerprint",
            icon: Icons.fingerprint,
            onTap: () {},
          ),
          const SizedBox(
            height: 16,
          ),
          ProfileOption(
            text: "Logout",
            icon: Icons.exit_to_app_rounded,
            onTap: () {
              SystemNavigator.pop();
            },
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  ProfileOption({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final IconData icon;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      decoration: BoxDecoration(
        color: kColorAccent.withAlpha(30),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: kColorSecondary),
          ),
          Icon(
            icon,
            color: kColorAccent,
            size: 30,
          )
        ],
      ),
    );
  }
}

class EditAvatar extends StatefulWidget {
  EditAvatar({
    Key? key,
    required this.size,
    required this.user,
  }) : super(key: key);

  final Size size;
  UserModel user;
  @override
  State<EditAvatar> createState() => _EditAvatarState();
}

class _EditAvatarState extends State<EditAvatar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      child: Column(
        children: [
          const AvatarCard(image: "assets/avatar_1.jpeg"),
          // IconButton(iconSize: 26,padding: const EdgeInsets.all(0), onPressed: (){}, icon: Icon(Icons.camera_alt_rounded, color: kColorSecondary,))
          TextButton(
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
                  setState(() {
                    widget.user.avatarPath = avatarCopy.path;
                    editUser(widget.user).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          content: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: kColorSecondary,
                                  borderRadius: BorderRadius.circular(32)),
                              child: Text(
                                value
                                    ? "Changes saved successfully!"
                                    : "Changes not saved!",
                                textAlign: TextAlign.center,
                                style:
                                    textStyle(false, 12, color: kColorPrimary),
                              ))));
                    });
                  });
                } else {
                  debugPrint("File copy failed");
                }
              },
              child: Text(
                "Change avatar",
                style: GoogleFonts.montserrat(
                    fontSize: 10, color: kColorSecondary),
              ))
        ],
      ),
    );
  }
}
