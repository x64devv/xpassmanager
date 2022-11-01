import "package:flutter/material.dart";
import 'package:xpassmanager/screens/constants.dart';

class AddButton extends StatelessWidget {
  const AddButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: kColorSecondary,
        child: Container(
          padding: const EdgeInsets.all(8),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: kColorAccent,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Center(child: Icon(Icons.add_rounded, color: kColorPrimary,),),
        ),
      ),
    );
  }
}