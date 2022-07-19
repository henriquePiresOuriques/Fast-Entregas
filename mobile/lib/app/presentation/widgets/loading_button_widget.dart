import 'package:flutter/material.dart';

class LoadingButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;

  const LoadingButtonWidget(
      {Key key, this.text, this.onPressed, this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      child: TextButton(
        child: isLoading
            ? const CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
