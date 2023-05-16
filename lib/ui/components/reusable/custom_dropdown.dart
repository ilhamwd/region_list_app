import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.items,
      required this.onChanged,
      this.value,
      this.hint,
      this.isExpanded,
      this.isDense,
      this.padding,
      this.borderRadius});

  final List<DropdownMenuItem<T>> items;
  final void Function(T? value) onChanged;
  final T? value;
  final String? hint;
  final bool? isExpanded, isDense;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: kIsWeb
          ? BoxDecoration(
              border: Border.all(color: const Color(0xFFDDDDDD)),
              borderRadius: borderRadius ?? BorderRadius.circular(10))
          : BoxDecoration(
              color: Colors.white,
              borderRadius: borderRadius ?? BorderRadius.circular(10)),
      child: DropdownButton<T>(
        isExpanded: isExpanded ?? true,
        items: items,
        onChanged: onChanged,
        isDense: isDense ?? false,
        value: value,
        underline: const SizedBox(),
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        hint: hint == null ? null : Text(hint!),
      ),
    );
  }
}
