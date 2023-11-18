import 'package:flutter/material.dart';

class AddTextField extends StatelessWidget {
  const AddTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.isPassword,
    required this.controller,
    required this.icon,
  });
  final String label;
  final String hint;
  final bool isPassword;
  final IconData icon;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 50,
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          label: Text(
            label,
            style: const TextStyle(
                color: Color(0xff89B9AD),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
          suffixIconColor: const Color(0xffF4EEEE),
          suffixIcon: Icon(icon),
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xffF4EEEE)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Color(0xff89B9AD)),
          ),
        ),
      ),
    );
  }
}
