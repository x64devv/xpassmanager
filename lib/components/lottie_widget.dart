import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatefulWidget {
  const LottieWidget({super.key, required this.lottieAnimation, required this.size});
  final String lottieAnimation;
  final Size size;
  @override
  State<LottieWidget> createState() => _LottieWidgetState();
}

class _LottieWidgetState extends State<LottieWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size.width*0.6,
      height: widget.size.height*0.3,
      padding: const EdgeInsets.all(8),
      child: Lottie.asset(
        widget.lottieAnimation,
        controller: _controller,
        repeat: true,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..addStatusListener((status) {
              if (status == AnimationStatus.completed) {
                _controller.repeat();
              }
            })
            ..forward();
        },
      ),
    );
  }
}
