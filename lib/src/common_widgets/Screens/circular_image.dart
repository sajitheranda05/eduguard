import 'package:flutter/material.dart';

class CustomCircularImage extends StatelessWidget {
  const CustomCircularImage({
    super.key,
    required this.image,
    this.isNetworkImage =false,
    this.overlayColor,
    this.backgroundColor,
    this.width =56,
    this.height =56,
    this.padding =4,
  });

  final String image;
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
        color: backgroundColor ?? Colors.greenAccent,
        borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 72,
            backgroundImage: AssetImage(image),

          ),
        ),
    );
  }
}
