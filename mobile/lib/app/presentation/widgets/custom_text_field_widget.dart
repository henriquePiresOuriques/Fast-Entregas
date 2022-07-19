import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType textInputType;
  final String errorText;
  final Widget icon;
  final Widget leftIcon;
  final List<TextInputFormatter> formatter;
  final Function onChanged;
  final bool enabled;
  final Function suffixIconActive;
  final bool obscureText;
  final Color backgroundColor;

  const CustomTextFormFieldWidget({
    Key key,
    this.controller,
    this.labelText,
    this.errorText,
    this.icon,
    this.textInputType,
    this.formatter,
    this.onChanged,
    this.enabled,
    this.suffixIconActive,
    this.obscureText = false,
    this.leftIcon,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      onChanged: onChanged,
      keyboardType: textInputType,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: backgroundColor,
        prefixIcon: leftIcon,
        suffixIcon: icon,
        hintText: labelText,
        errorText: errorText,
      ),
      inputFormatters: formatter,
      obscureText: obscureText,
    );
  }
}
