import 'package:flutter/material.dart';
import 'package:task_u_devs/core/extension/color.dart';

import 'common_text.dart';

class CommonTextIconButton extends StatelessWidget {
  final IconData? iconData;
  final Function? onTap;
  final String title;
  final Color? color;
  final FontWeight? fontWeight;
  final Color? backgroundColor;

  const CommonTextIconButton({
    required this.title,
    this.onTap,
    this.backgroundColor,

    this.fontWeight,

    this.iconData,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap != null ? () => onTap!() : null,
      child: Container(
        color: backgroundColor?? context.colors.primary ,
        padding: EdgeInsets.zero, // Paddingni olib tashlash
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              iconData ?? Icons.edit_document,
              color: color ?? context.colors.onPrimary,
            ),
            SizedBox(width: 4),
            CommonText(
              text: title,
              color: color ?? context.colors.onTextPrimary,
              padding: 0,
              textSize: 12,
              fontWeight: fontWeight,
            ),
          ],
        ),
      ),
    );
  }
}
