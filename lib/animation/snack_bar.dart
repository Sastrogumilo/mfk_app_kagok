import 'package:flutter/material.dart';

class FlyDownAnimation extends StatefulWidget {
  final Widget child;

  const FlyDownAnimation({super.key, required this.child});

  @override
  // State<HomeScreen> createState() => _HomeScreenState();
  State<FlyDownAnimation> createState() => _FlyDownAnimationState();
  // _FlyDownAnimationState createState() => _FlyDownAnimationState();
}

class _FlyDownAnimationState extends State<FlyDownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration:
          const Duration(milliseconds: 500), // Adjust the duration as needed
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn, // Adjust the curve as needed
      ),
    );
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
