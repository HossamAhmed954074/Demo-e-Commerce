import 'package:demo_ecommerce/core/utils/validation_utils.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFormFieldCustom extends StatefulWidget {
  TextFormFieldCustom({
    super.key,
    required this.labelText,
    required this.obscureText,
    required this.controller,
  });

  final String labelText;
  bool obscureText;
  final TextEditingController controller;

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: TextFormField(
        validator: (value) {
          if (!ValidationUtils.isValidEmail(value!) &&
              widget.labelText == 'Email') {
            return 'Please enter a valid email';
          }
          if (widget.labelText == 'Password' &&
              !ValidationUtils.isValidPassword(value)) {
            return 'Please enter your password';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          suffixIcon: widget.labelText == 'Password'
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscured = !_isObscured;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),

        obscureText: widget.obscureText ? _isObscured : false,
        controller: widget.controller,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
