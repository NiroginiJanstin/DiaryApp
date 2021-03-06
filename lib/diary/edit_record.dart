import 'package:diary_app/diary/widgets/edit_item_form.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  final String currentDateTime;
  final String currentTitle;
  final String currentDescription;
  final String currentRating;
  final String documentId;
  final DateTime actTime;

  EditScreen({
    this.currentDateTime,
    this.currentTitle,
    this.currentDescription,
    this.currentRating,
    this.documentId,
    this.actTime
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
          appBar: AppBar(
            elevation: 0,
            title: Text("Edit  " + widget.currentTitle),
            actions: [
              _isDeleting
                  ? const Padding(
                      padding: EdgeInsets.only(
                        top: 10.0,
                        bottom: 10.0,
                        right: 16.0,
                      ),
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.redAccent,
                        ),
                        strokeWidth: 3,
                      ),
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.redAccent,
                        size: 32,
                      ),
                      onPressed: () async {
                        setState(() {
                          _isDeleting = true;
                        });

                        await DiaryCrud.deleteItem(
                          docId: widget.documentId,
                        );

                        setState(() {
                          _isDeleting = false;
                        });

                        Navigator.of(context).pop();
                      },
                    ),
            ],
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
                child: EditItemForm(
                    documentId: widget.documentId,
                    dateFocusNode: _dateTimeFocusNode,
                    titleFocusNode: _titleFocusNode,
                    descriptionFocusNode: _descriptionFocusNode,
                    oldTime : widget.actTime,
                    currentDate: widget.currentDateTime,
                    currentTitle: widget.currentTitle,
                    currentDescription: widget.currentDescription,
                    currentRating: widget.currentRating),
              ),
            ),
          )),
    );
  }
}
