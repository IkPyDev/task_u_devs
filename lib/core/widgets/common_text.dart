import 'package:flutter/material.dart';
import 'package:task_u_devs/core/extension/color.dart';

class CommonText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? textSize;
  final double? padding;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final Color? backgroundColor;

  const CommonText(
      {required this.text,this.backgroundColor, this.fontWeight, this.color, this.textSize, this.padding, this.fontStyle, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ,
      padding: EdgeInsets.symmetric(vertical: padding ?? 0.0),
      child: Text(text,
        textAlign: TextAlign.start,
        style: TextStyle(color: color ?? context.colors.systemBlack,
          fontSize: textSize ?? 18,
          fontStyle: fontStyle ?? FontStyle.normal,
          overflow: TextOverflow.ellipsis,

          fontWeight: fontWeight ?? FontWeight.normal),),
    );
  }
}
