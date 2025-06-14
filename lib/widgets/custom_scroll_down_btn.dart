import 'package:flutter/material.dart';

class CustomScrollDownBtn extends StatelessWidget {
  const CustomScrollDownBtn(
      {super.key, required this.onPressed, required this.isVisible});
  final VoidCallback onPressed;
  final bool isVisible;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: AnimatedSlide(
        offset: isVisible ? const Offset(0, 0) : const Offset(1, 0),
        duration: const Duration(milliseconds: 300),
        child: FloatingActionButton.small(
          onPressed: onPressed,
          backgroundColor: const Color(0xffB0C1D4),
          child: const Icon(
            Icons.arrow_downward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
