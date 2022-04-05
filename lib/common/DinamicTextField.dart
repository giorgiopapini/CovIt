import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';

class DinamicTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final bool isEmail;
  final Icon suffixIcon;
  final String variableToUpdate;
  final Function(String, String) callback;

  DinamicTextField({
    @required this.labelText,
    @required this.obscureText,
    @required this.isEmail,
    @required this.variableToUpdate,
    @required this.callback,
    this.suffixIcon,
  });

  @override
  _DinamicTextFieldState createState() => _DinamicTextFieldState();
}

class _DinamicTextFieldState extends State<DinamicTextField> {
  final controller = new TextEditingController();

  String result = "";
  int count = 0;
  bool firstAttempt = true;
  bool obscureText = false;
  TextInputType keyboardType;
  Icon suffixIcon;

  @override
  void initState() {
    super.initState();
    this.obscureText = widget.obscureText;
    this.suffixIcon = widget.suffixIcon;
    if (widget.isEmail == true) {
      this.keyboardType = TextInputType.emailAddress;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getValue(String text, String nameOfField) {
    setState(() {
      this.result = text;
      this.firstAttempt = false;
      widget.callback(this.result, nameOfField);
    });
  }

  void viewPassword() {
    setState(() {
      if (this.obscureText == true) {
        this.obscureText = false;
        this.suffixIcon = Icon(Icons.close_rounded);
      } else {
        this.obscureText = true;
        this.suffixIcon = widget.suffixIcon;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: this.keyboardType,
      controller: this.controller,
      autocorrect: false,
      obscureText: this.obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Questo campo è obbligatorio";
        } else if (widget.isEmail == true &&
            !RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return "Questa email non è valida";
        }
        return null;
      },
      style: TextStyle(
        color: const_black,
      ),
      onChanged: (text) => this.getValue(text, widget.variableToUpdate),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: TextStyle(
          fontSize: 18,
        ),
        errorText: this.result == "" && this.firstAttempt == false
            ? "Questo campo è obbligatorio"
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        contentPadding: EdgeInsets.all(20),
        suffixIcon: (widget.suffixIcon != null)
            ? IconButton(
                icon: this.suffixIcon,
                color: (this.result == "" && this.firstAttempt == false)
                    ? const_red
                    : null,
                onPressed: () => this.viewPassword())
            : null,
      ),
    );
  }
}
