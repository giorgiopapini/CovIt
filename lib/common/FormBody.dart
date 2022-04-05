import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';


Widget formPageBody(List <Widget>fields, BuildContext context, GlobalKey<FormState> _formKey) {
  return SafeArea(
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Padding(
          padding: const_padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: fields,
            ),
          ),
        ),
      )
  );
}