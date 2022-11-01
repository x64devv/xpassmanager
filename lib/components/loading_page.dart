import 'package:flutter/material.dart';
import 'package:xpassmanager/screens/constants.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kColorAccent,
      child: Column(
        children: [
          CircularProgressIndicator(color: kColorSecondary,),
          const SizedBox(height: 8,),
          Text("Please Wait...", style: textStyle(true, 14, color: kColorAccent),),
        ],
      ),
    );
  }
}