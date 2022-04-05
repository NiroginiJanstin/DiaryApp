import 'package:diary_app/diary/widgets/edit_item_form.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';

import '../res/custom_colors.dart';

class EditScreen extends StatefulWidget {
  final String currentDateTime;
  final String currentTitle;
  final String currentDescription;
  final String currentRating;
  final String documentId;

  EditScreen({
    required this.currentDateTime,
    required this.currentTitle,
    required this.currentDescription,
    required this.currentRating,
    required this.documentId,
  });

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final FocusNode _dateTimeFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _dateTimeFocusNode.unfocus();
        _titleFocusNode.unfocus();
        _descriptionFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: CustomColors.firebaseNavy,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: CustomColors.firebaseNavy,
          title: Text("Edit  " + widget.currentTitle),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 20.0,
            ),
            child: EditItemForm(
                documentId: widget.documentId,
                dateFocusNode: _dateTimeFocusNode,
                titleFocusNode: _titleFocusNode,
                descriptionFocusNode: _descriptionFocusNode,
                currentDate: widget.currentDateTime,
                currentTitle: widget.currentTitle,
                currentDescription: widget.currentDescription,
                currentRating: widget.currentRating),
          ),
        ),
      ),
    );
  }
}
