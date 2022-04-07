import 'package:flutter/material.dart';
import 'widgets/add_item_form.dart';

class AddScreen extends StatelessWidget {
  final FocusNode _dateFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _dateFocusNode.unfocus();
          _titleFocusNode.unfocus();
          _descriptionFocusNode.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add Note"),
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  bottom: 20.0,
                ),
                child: AddItemForm(
                  dateFocusNode: _dateFocusNode,
                  titleFocusNode: _titleFocusNode,
                  descriptionFocusNode: _descriptionFocusNode,
                ),
              ),
            ),
          ),
        ));
  }
}
