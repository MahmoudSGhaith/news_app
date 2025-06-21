import 'package:flutter/material.dart';
import 'package:news/extension/extensions.dart';

class DrawerWidget extends StatelessWidget {
  final String text;
  final String imagePath;

  const DrawerWidget({super.key, required this.text, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.heightQuery * 0.05),
      child: Row(
        children: [
          Image(
            image: AssetImage(imagePath),
            color: Theme.of(context).hoverColor,
          ),
          SizedBox(width: context.widthQuery * 0.05),
          Text(text, style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
    );
  }
}
