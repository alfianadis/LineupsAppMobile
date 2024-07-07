import 'package:flutter/material.dart';

class CustomImageViewer {
  CustomImageViewer._();

  static show(
      {required BuildContext context,
      required String url,
      BoxFit? fit,
      double? radius}) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).dialogBackgroundColor,
        borderRadius: BorderRadius.circular(radius ?? 8),
        image: DecorationImage(
          image: AssetImage(url),
          fit: fit ?? BoxFit.cover,
        ),
      ),
    );
  }
}
