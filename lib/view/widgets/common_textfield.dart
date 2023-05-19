import 'package:e_commerce/view/widgets/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTexField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final Widget? prefix;
  final Widget? sufix;
  final EdgeInsetsGeometry? contentPadding;
  final Color? bgColor;
  final Function(String v)? onChange;
  final bool? readOnly;
  final Color? color;
  final bool? needValidation;
  final bool? isEmailValidator;
  final bool? isPasswordValidator;
  final bool? isPhoneNumberValidator;
  final String? validationMessage;
  final TextInputType? inputType;
  final bool? visible;
  final List<TextInputFormatter>? inputFormatters;
  const CommonTexField(
      {Key? key,
        required this.controller,
        required this.hintText,
        this.prefix,
        this.sufix,
        this.contentPadding,
        required this.labelText,
        this.bgColor,
        this.onChange,
        this.readOnly,
        this.color,
        this.needValidation = false,
        this.isEmailValidator = false,
        this.isPasswordValidator = false,
        this.isPhoneNumberValidator = false,
        this.validationMessage,
        this.inputType,
        this.inputFormatters,
        this.visible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText != ""
            ? Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            labelText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        )
            : const SizedBox(),
        SizedBox(
          // height: 50,
          width: MediaQuery.of(context).size.width,

          child: TextFormField(
            cursorColor: Color(0xff800000),
            obscureText: visible ?? false,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            validator: needValidation ?? false
                ? (v) {
              return TextFieldValidation.validation(
                  isEmailValidator: isEmailValidator ?? false,
                  isPasswordValidator: isPasswordValidator ?? false,

                  message: validationMessage,
                  value: v!.trim());
            }
                : null,
            onChanged: onChange,
            readOnly: readOnly ?? false,
            controller: controller,
            style: TextStyle(
              fontSize: 14,
              color: color ?? Colors.black,
            ),
            decoration: InputDecoration(
              suffixIcon: sufix ?? null,
              prefixIcon: prefix ?? null,
              contentPadding: contentPadding ??
                  const EdgeInsets.only(top: 16, left: 14, right: 14),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.3),
              ),
              filled: true,
              fillColor: bgColor ?? Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.transparent,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xff800000),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xff800000),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
