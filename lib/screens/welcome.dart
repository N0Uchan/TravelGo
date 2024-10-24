import 'package:flutter/material.dart';
import 'package:travel_go/widgets/animated_avatar.dart';
import 'package:travel_go/widgets/animated_elevBtn.dart';
import 'package:travel_go/widgets/gradient_text.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key,required this.enterApp});

  final void Function() enterApp;

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const AnimatedAvatar(),
            const SizedBox(
              height: 12,
            ),
            AnimatedElevBtn(enterApp: widget.enterApp),
            const SizedBox(
              height: 12,
            ),
            const AnimatedGradientText(
              text: "Your travel guide",
              startColor: Colors.blue,
              endColor: Colors.purple,
              delay: 1200,
              duration: Duration(milliseconds: 400) ,
            ),
            const SizedBox(
              height: 12,
            ),
            const AnimatedGradientText(
              text: "a few taps away.",
              startColor: Colors.blue,
              endColor: Colors.purple,
              delay: 1600,
              duration: Duration(milliseconds: 400) ,
            ),
          ],
        ),
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0.5, -0.4),
            end: const Offset(0.5, 0.7),
          ).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeOut,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
