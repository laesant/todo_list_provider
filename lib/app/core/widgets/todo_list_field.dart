import 'package:flutter/material.dart';

class TodoListField extends StatelessWidget {
  TodoListField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.suffixIconButton,
    this.controller,
    this.validator,
  })  : assert(obscureText ? suffixIconButton == null : true,
            'obscureText Não pode ser enviado em conjuto com o suffixIconButton'),
        obscureTextVN = ValueNotifier(obscureText);
  final String label;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final ValueNotifier<bool> obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextVN,
      builder: (_, value, __) {
        return TextFormField(
          controller: controller,
          validator: validator,
          obscureText: value,
          decoration: InputDecoration(
            isDense: true,
            labelText: label,
            suffixIcon: suffixIconButton ??
                (obscureText
                    ? IconButton(
                        onPressed: () => obscureTextVN.value = !value,
                        icon: Icon(
                            value ? Icons.visibility : Icons.visibility_off))
                    : null),
            labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: const BorderSide(color: Colors.red)),
          ),
        );
      },
    );
  }
}
