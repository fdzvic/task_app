import 'package:flutter/material.dart';

enum TextStyleType {
  bodyLarge,
  bodyMedium,
  bodySmall,
}

class CustomText extends StatelessWidget {
  final String? text;
  final Color? textColor;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final double? fontSize;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final TextStyleType? styleType;

  const CustomText(
    this.text, {
    super.key,
    this.textColor,
    this.fontWeight,
    this.textDecoration,
    this.maxLines,
    this.textAlign,
    this.fontSize,
    this.overflow,
    this.height = 1,
    this.styleType = TextStyleType.bodyMedium,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: textAlign,
      maxLines: maxLines ?? 100,
      overflow: overflow,
      style:
          _getTextStyle(context), // Llama a la función para obtener el estilo
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    TextStyle baseStyle = _getBaseStyle(context);

    return baseStyle.copyWith(
      fontWeight: fontWeight ?? baseStyle.fontWeight,
      fontSize: fontSize ?? baseStyle.fontSize,
      color: textColor ?? baseStyle.color,
      decoration: textDecoration ?? baseStyle.decoration,
      height: height ?? baseStyle.height,
    );
  }

  TextStyle _getBaseStyle(BuildContext context) {
    switch (styleType) {
      case TextStyleType.bodyLarge:
        return Theme.of(context).textTheme.bodyLarge!;
      case TextStyleType.bodyMedium:
        return Theme.of(context).textTheme.bodyMedium!;
      case TextStyleType.bodySmall:
        return Theme.of(context).textTheme.bodySmall!;
      default:
        return Theme.of(context).textTheme.bodyMedium!;
    }
  }
}
