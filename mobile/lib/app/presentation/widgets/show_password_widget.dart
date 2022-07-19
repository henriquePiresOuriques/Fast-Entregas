import 'package:flutter/material.dart';

class ShowPasswordWidget extends StatelessWidget {
  final bool show;
  final Function hidePassword;

  const ShowPasswordWidget({Key key, this.show, this.hidePassword})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hidePassword,
      child: show
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
    );
  }
}
