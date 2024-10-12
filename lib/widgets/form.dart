import 'package:app_coaching/constantes/constantes.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType keyboardType;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;

  const CustomTextField({
    required this.keyboardType,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.obscureText = false, // Par défaut, le texte n'est pas masqué
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      //cachez le texte a la saisir)
      obscureText: obscureText,
      // cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Icon(
            prefixIcon,
            color: AppColors.primaryColor,
            size: 16,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              // width: 1,
              ),
        ),
      ),
    );
  }
}

class CustomPasswordField extends StatefulWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String hintText;
  final String labelText;
  final IconData prefixIcon;
  final bool isObscure;

  const CustomPasswordField({
    required this.keyboardType,
    required this.obscureText,
    required this.hintText,
    required this.labelText,
    required this.prefixIcon,
    this.isObscure = true,
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText && isObscure,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Icon(
            widget.prefixIcon,
            color: AppColors.primaryColor,
            size: 16,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primaryColor,
            size: 16,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              // width: 1,
              ),
        ),
      ),
    );
  }
}

class CustomIntlPhoneField extends StatefulWidget {
  final String initialCountryCode;
  final Color? cursorColor;
  final String hintText;
  final String labelText;

  const CustomIntlPhoneField({
    required this.initialCountryCode,
    required this.cursorColor,
    required this.hintText,
    required this.labelText,
  });

  @override
  _CustomIntlPhoneFieldState createState() => _CustomIntlPhoneFieldState();
}

class _CustomIntlPhoneFieldState extends State<CustomIntlPhoneField> {
  bool filled = true;

  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      initialCountryCode: widget.initialCountryCode,
      cursorColor: widget.cursorColor,
      decoration: InputDecoration(
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              // width: 1,
              ),
        ),
      ),
    );
  }
}

class CTextFormField extends StatelessWidget {
  final TextInputType keyboardType;
  // final String hintText;
  final String initialValue;
  final IconData prefixIcon;
  final bool obscureText;

  const CTextFormField({
    required this.keyboardType,
    // required this.hintText,
    required this.prefixIcon,
    required this.initialValue,
    this.obscureText = false, // Par défaut, le texte n'est pas masqué
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      initialValue: initialValue,
      obscureText: obscureText,
      decoration: InputDecoration(
        // hintText: hintText,
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Icon(
            prefixIcon,
            color: AppColors.primaryColor,
            size: 16,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              // width: 1,
              ),
        ),
      ),
    );
  }
}

class CpasswordFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final bool obscureText;
  final String initialValue;
  final String labelText;
  final IconData prefixIcon;
  final bool isObscure;

  const CpasswordFormField({
    required this.keyboardType,
    required this.obscureText,
    required this.initialValue,
    required this.labelText,
    required this.prefixIcon,
    this.isObscure = true,
  });

  @override
  _CpasswordFormFieldState createState() => _CpasswordFormFieldState();
}

class _CpasswordFormFieldState extends State<CpasswordFormField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText && isObscure,
      decoration: InputDecoration(
        hintText: widget.initialValue,
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: AppColors.secondaryColor,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: defaultPadding),
          child: Icon(
            widget.prefixIcon,
            color: AppColors.primaryColor,
            size: 16,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isObscure = !isObscure;
            });
          },
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primaryColor,
            size: 16,
          ),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(
              // width: 1,
              ),
        ),
      ),
    );
  }
}
