import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField(this.text,
      {super.key,
      this.onChanged,
      this.validator,
      this.obscureText = false,
      this.hasToggleVisibility = false});
  final String text;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool hasToggleVisibility;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool obscureText;
  @override
  void initState() {
    super.initState();
    obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onChanged: widget.onChanged,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: kSecondaryColor,
          ),
        ),
        hintText: widget.text,
        hintStyle: const TextStyle(color: Colors.white),
        suffixIcon: widget.hasToggleVisibility
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white,
                ),
              )
            : null,
      ),
      style: const TextStyle(color: Colors.white),
    );
  }
}
