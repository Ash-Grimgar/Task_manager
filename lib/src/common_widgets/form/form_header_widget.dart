import 'package:flutter/material.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.ImageColor,
    this.heightBetween,
    this.imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    required this.image,
    required this.title,
    required this.subTitle,
    this.textAlign
  });

  final String image, title, subTitle;
  final double imageHeight;
  final double? heightBetween;
  final Color? ImageColor;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(image: AssetImage(image), height: size.height * 0.2),
        SizedBox(height: heightBetween,),
        Text(title, style: Theme.of(context).textTheme.headlineMedium),
        Text(subTitle, style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}
