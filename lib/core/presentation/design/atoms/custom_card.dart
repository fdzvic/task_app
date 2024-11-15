import 'package:flutter/material.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.width,
    this.height,
  });
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? colors.primaryColor.withOpacity(.3),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
