import 'package:flutter/material.dart';

class AnimatedElevBtn extends StatefulWidget {
  const AnimatedElevBtn({super.key,required this.enterApp});
  final void Function() enterApp;
  @override
  State<AnimatedElevBtn> createState() => _AnimatedElevBtnState();
}

class _AnimatedElevBtnState extends State<AnimatedElevBtn>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
      lowerBound: 0,
      upperBound: 1,
    );
    Future.delayed(const Duration(milliseconds: 1000), () {
      _animationController.forward();
    });
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
      child: ElevatedButton(
        onPressed: widget.enterApp ,
        child: const Padding(
          padding: EdgeInsets.fromLTRB(12, 16, 12, 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Explore Places',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(Icons.navigate_next_outlined),
            ],
          ),
        ),
      ),
      builder: (context, child) => Opacity(
        opacity: _animationController.value,
        child: SlideTransition(
          position: Tween(
            begin: const Offset (1, 0),
            end: const Offset(0, 0),
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
