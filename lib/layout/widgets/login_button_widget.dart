import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButtonWidget extends ConsumerWidget {
  final VoidCallback onPressed;
  final String text;
  final String link;
  final String image;
  const LoginButtonWidget({
    super.key,
    required this.onPressed,
    required this.text,
    required this.link,
    required this.image,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        clipBehavior: Clip.values.first,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          textStyle: TextStyle(fontSize: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          spacing: 4.0,
          children:[
            Image.network(
              image,
              height: 24,
              width: 24,
            ),
            SizedBox(width: 12),
            Flexible(child: Text(text)),
          ]
      ),
    ));
  }
}