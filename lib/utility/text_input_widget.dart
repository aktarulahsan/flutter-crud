import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputWidget extends StatelessWidget {
  const TextInputWidget({
    Key? key,
    required this.hint,
    this.preIcon,
    this.supIcon,
    required this.type,
    this.obscure,
    required this.leble,
    required this.controller,
    this.validator,
    this.maxLength,
    this.enable,
    this.textAlign,
  }) : super(key: key);

  final String hint;
  final IconData? preIcon;
  final Widget? supIcon;
  final TextInputType type;
  final bool? obscure;
  final String leble;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final bool? enable;
  final TextAlign? textAlign;
  // final alig

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        obscureText: obscure ?? false,
        keyboardType: type,
        validator: validator,
        enabled: enable,
        textAlign: textAlign?? TextAlign.start,
        style: TextStyle(fontSize: 15),
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          isDense: true,
          // contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          contentPadding: EdgeInsets.symmetric(vertical: -5,horizontal: 5),
          label: Text(leble,textAlign: TextAlign.end,style: TextStyle(fontSize: 12),),
          suffixIconConstraints:
              const BoxConstraints(minHeight: 20, minWidth: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(0.8), fontSize: 10),
          prefixIcon: Icon(preIcon, color: Colors.blueAccent),
          suffixIcon: supIcon,
          errorStyle: const TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
