

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String text;
  final onPress;

  const CustomButton({required this.text, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      width: MediaQuery.of(context).size.width,

      child: Card(
        shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        color: Colors.lightBlueAccent,
        child: TextButton(
            onPressed: onPress,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,

              ),
            )
        ),
      ),
    );
  }
}
