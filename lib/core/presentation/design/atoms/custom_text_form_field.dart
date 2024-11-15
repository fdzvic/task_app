import 'package:flutter/material.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/validators.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;

  final TextEditingController? controller;

  final bool? enabled;

  final InputValueType? inputValueType;

  final String? hintText;

  final String? suffixIconPath;

  final Function(String)? onChanged;

  const CustomTextFormField({
    super.key,
    required this.label,
    this.suffixIconPath,
    this.controller,
    this.enabled = true,
    this.inputValueType = InputValueType.text,
    this.hintText,
    this.onChanged,
  });

  @override
  CustomTextFormFieldState createState() => CustomTextFormFieldState();
}

class CustomTextFormFieldState extends State<CustomTextFormField> {
  FocusNode focusNode = FocusNode();
  bool obscureText = false;
  bool? showError;
  String? errorMessage;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(() {
      setState(() {});
    });

    Future.delayed(
      Duration.zero,
      () => {
        _defineObscureTextValue(),
        _addTextControllerListener(),
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CustomText(
              widget.label,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          height: 48,
          padding: const EdgeInsets.only(left: 16, right: 18),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.fromBorderSide(BorderSide(color: _accentColor())),
          ),
          child: TextFormField(
            focusNode: focusNode,
            controller: widget.controller,
            validator: (x) => _validateInput(x ?? ''),
            onChanged: widget.onChanged,
            enabled: widget.enabled,
            textInputAction: TextInputAction.next,
            inputFormatters: const [],
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              errorStyle:
                  const TextStyle(fontSize: 0.1, color: Colors.transparent),
              hintStyle: TextStyle(
                color: colors.disabledTextColor,
                fontSize: 16,
              ),
            ),
            keyboardType: _keyboardType(),
            obscureText: obscureText,
            cursorWidth: 1,
            cursorColor: colors.primaryColor,
          ),
        ),
        Container(
          height: 20,
          alignment: Alignment.centerLeft,
          child: Column(
            children: [
              /// Mensaje error
              if (showError ?? false) ...[
                const SizedBox(height: 4),
                CustomText(
                  errorMessage,
                  textColor: colors.redNormal,
                  fontSize: 12,
                )
              ]
            ],
          ),
        )
      ],
    );
  }

  void onTapSuffixIcon() {
    obscureText = !obscureText;
    setState(() {});
  }

  Color _accentColor() {
    if (showError ?? false) {
      return colors.redNormal;
    }
    return focusNode.hasFocus ? colors.textColor : colors.textColor;
  }

  _defineObscureTextValue() {
    setState(() {
      obscureText = (widget.inputValueType == InputValueType.password);
    });
  }

  _validate(String text) {
    switch (widget.inputValueType) {
      case InputValueType.email:
        errorMessage = validateEmail(text);
        break;

      case InputValueType.name:
        errorMessage = validateName(text);
        break;
      case InputValueType.none:
        break;

      case InputValueType.text:
      default:
        errorMessage = validateText(text);
        break;
    }
    showError = errorMessage != null;
    return errorMessage;
  }

  _addTextControllerListener() {
    if (widget.controller != null) {
      widget.controller!.addListener(() {});
    }
  }

  String? _validateInput(String x) {
    _validate(x);
    setState(() {});
    return errorMessage;
  }

  _keyboardType() {
    switch (widget.inputValueType) {
      case InputValueType.email:
        return TextInputType.emailAddress;
      case InputValueType.text:
      case InputValueType.name:
      default:
        return TextInputType.text;
    }
  }
}

enum InputValueType {
  text,
  password,
  email,
  name,
  none,
}
