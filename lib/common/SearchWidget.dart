import 'package:flutter/material.dart';
import 'package:flutter_application_1/Constants.dart';

class SearchWidget extends StatefulWidget {

  final String oldQuery;
  final Function(String) callback;

  SearchWidget(
    {
      @required this.oldQuery,
      @required this.callback,
    }
  );

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  final TextEditingController controller = new TextEditingController();
  bool focused;

  @override
  void dispose() {
    super.dispose();
    this.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(15, 0, 15, 19),
      child: FocusScope(
        child: Focus(
          onFocusChange: (focus) {
            setState(() {
              this.focused = focus;
              if (focus == false) {
                FocusScope.of(context).requestFocus(FocusNode());
              }
            });
          },
          child: TextFormField(
            controller: this.controller,
            style: TextStyle(
              color: const_black,
            ),
            decoration: InputDecoration(
              hintText: "Cerca una regione...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              contentPadding: EdgeInsets.all(10),
              prefixIcon: Icon(Icons.search),
              suffixIcon: this.controller.text == "" ? null : IconButton(
                icon: Icon(Icons.close_rounded),
                color: this.focused == true ? const_blue : const_grey,
                onPressed: () {
                  setState(() {
                    this.controller.clear();
                    widget.callback(this.controller.text);
                  });
                },
              ),
            ),
            onChanged: (text) => widget.callback(text),
          ),
        ),
      ),
    );
  }
}