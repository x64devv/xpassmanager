import 'package:flutter/material.dart';

class SocialMediaCard extends StatelessWidget {
  const SocialMediaCard({Key? key, required this.icon, required this.onPressed}) : super(key: key);
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        iconSize: 50,
        color: Colors.blue,
      ),
    );
  }
}
