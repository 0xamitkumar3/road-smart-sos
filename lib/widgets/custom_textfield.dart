import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final String hint;

  final IconData icon;

  final bool obscure;

  final TextEditingController? controller;

  const CustomTextField({

    super.key,

    required this.hint,

    required this.icon,

    this.obscure = false,

    this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.white54,
        ),

        prefixIcon: Icon(
          icon,
          color: Colors.red.shade400,
        ),

        filled: true,

        fillColor:
            const Color(
          0xFF1C1F2E,
        ),

        border:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              BorderSide.none,
        ),

        enabledBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide: BorderSide(
            color: Colors.white
                .withValues(
              alpha: 0.08,
            ),
          ),
        ),

        focusedBorder:
            OutlineInputBorder(

          borderRadius:
              BorderRadius.circular(
            18,
          ),

          borderSide:
              BorderSide(
            color:
                Colors.red.shade400,

            width: 1.5,
          ),
        ),
      ),
    );
  }
}