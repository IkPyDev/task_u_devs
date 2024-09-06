
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_u_devs/core/extension/color.dart';

class CommonTextField extends StatelessWidget {
  final Function(String) onChanged;
  final bool? enabled;
  final String? endText;
  final IconData? icon;
  final bool? description;
  final double? borderRadius;
  final TextEditingController? controller;

  const CommonTextField({
    super.key,
    this.enabled,
    this.icon,
    this.description,
    this.borderRadius,
    this.endText,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: description == true ? 140 : 50,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s\b\w*'))
        ],
        textCapitalization: TextCapitalization.sentences,
        autocorrect: true,
        enabled: enabled,
        maxLines: description == true ? 5 : 1,
        style: TextStyle(
          color: context.colors.systemBlack,
          fontSize: 16,
        ),
        cursorColor: context.colors.primary,
        decoration: InputDecoration(
          suffixIcon: icon != null
              ? Icon(icon, color: context.colors.primary)
              : null,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
          filled: true,
          fillColor: context.colors.systemGrey,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

