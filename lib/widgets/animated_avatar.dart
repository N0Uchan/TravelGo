import 'package:flutter/material.dart';

class AnimatedAvatar extends StatefulWidget {
  const AnimatedAvatar({super.key});
  @override
  State<AnimatedAvatar> createState() => _AnimatedAvatarState();
}

class _AnimatedAvatarState extends State<AnimatedAvatar>
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
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Opacity(
        opacity: _animationController.value,
        child: CircleAvatar(
          foregroundImage: const AssetImage('assets/images/travel_guide.jpeg'),
          radius: _animationController.value*75,
        ),
      ),
    );
  }
}
