import 'package:diary_app/diary/diary_home.dart';
import 'package:diary_app/utils/diary_collection_crud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

import '../../common/home.dart';
import '../../res/custom_colors.dart';
import '../../utils/validator.dart';
import '../common/get_rate_icon.dart';
import 'custom_form_field.dart';
//import 'package:intl/intl.dart';

var title = "";
var note = "";

class EditItemForm extends StatefulWidget {
  final FocusNode dateFocusNode;
  final FocusNode titleFocusNode;
  final FocusNode descriptionFocusNode;
  final String currentDate;
  final String currentTitle;
  final String currentDescription;
  final String currentRating;
  final String documentId;
  final DateTime oldTime;

  const EditItemForm({
    this.dateFocusNode,
    this.titleFocusNode,
    this.descriptionFocusNode,
    this.currentTitle,
    this.currentDate,
    this.currentDescription,
    this.currentRating,
    this.documentId,
    this.oldTime
  });

  @override
  _EditItemFormState createState() => _EditItemFormState();
}

class _EditItemFormState extends State<EditItemForm> {
  final _editItemFormKey = GlobalKey<FormState>();

  bool _isProcessing = false;
  bool isInitialIcon = true;
  double rate = 0;
  Icon icon = const Icon(
    Icons.sentiment_very_dissatisfied,
    color: Colors.red,
  );
  DateTime actualDateVal =  DateTime.now();

  TextEditingController _dateTimeController;
  TextEditingController _titleController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    _dateTimeController = TextEditingController(
      text: widget.currentDate,
    );

    _titleController = TextEditingController(
      text: widget.currentTitle,
    );

    _descriptionController = TextEditingController(
      text: widget.currentDescription,
    );

    icon = returnIcon(double.parse(widget.currentRating));
    rate = double.parse(widget.currentRating);
    actualDateVal = widget.oldTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Form(
      key: _editItemFormKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
              bottom: 24.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                IconButton(
                  icon: icon,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                         AlertDialog(
                    title: const Text('Please rate your day'),
                    content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                    RatingBar.builder(
                    initialRating: 3,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                    switch (index) {
                    case 0:
                    return const Icon(
                    Icons.sentiment_very_dissatisfied,
                    color: Colors.red,
                    );
                    case 1:
                    return const Icon(
                    Icons.sentiment_dissatisfied,
                    color: Colors.redAccent,
                    );
                    case 2:
                    return const Icon(
                    Icons.sentiment_neutral,
                    color: Colors.amber,
                    );
                    case 3:
                    return const Icon(
                    Icons.sentiment_satisfied,
                    color: Colors.lightGreen,
                    );
                    case 4:
                    return const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                    );
                    default:
                    return const Icon(
                    Icons.sentiment_very_satisfied,
                    color: Colors.green,
                    );
                    }
                    },
                    onRatingUpdate: (rating) {
                      setState(() {
                        rate = rating-1;
                        icon = returnIcon(rating-1);
                      });
                      Navigator.of(context).pop();
                    },
                    )
                    ],
                    ),
                    )
                    );

                  },
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Date',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    fontSize: 15.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  controller:
                      _dateTimeController, //editing controller of this TextField
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_today),
                    labelText: "Enter Date",
                    labelStyle: TextStyle(color: CustomColors.firebaseYellow),
                    errorStyle: const TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: CustomColors.firebaseAmber,
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: CustomColors.firebaseGrey.withOpacity(0.5),
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.redAccent,
                        width: 2,
                      ),
                    ),
                  ),
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DatePicker.showDateTimePicker(context,
                        showTitleActions: true, onChanged: (date) {
                          String dateString = DateFormat('yyyy-MM-dd hh:mm a').format(date);

                      setState(() {
                        actualDateVal = date;
                        _dateTimeController.text = dateString;
                        //set output date to TextField value.
                      });
                    }, onConfirm: (date) {}, currentTime: DateTime.now());
                  },
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Title',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    fontSize: 15.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomFormField(
                  isLabelEnabled: false,
                  controller: _titleController,
                  focusNode: widget.titleFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Title',
                  hint: 'Enter your note title',
                ),
                const SizedBox(height: 20.0),
                Text(
                  'Description',
                  style: TextStyle(
                    color: CustomColors.firebaseGrey,
                    fontSize: 15.0,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10.0),
                CustomFormField(
                  maxLines: 5,
                  isLabelEnabled: false,
                  controller: _descriptionController,
                  focusNode: widget.descriptionFocusNode,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.done,
                  validator: (value) => Validator.validateField(
                    value: value,
                  ),
                  label: 'Description',
                  hint: 'Enter your note description',
                ),
              ],
            ),
          ),
          _isProcessing
              ? Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      CustomColors.firebaseOrange,
                    ),
                  ),
                )
              : SizedBox(
                  width: double.maxFinite,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        CustomColors.firebaseOrange,
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      widget.titleFocusNode.unfocus();
                      widget.descriptionFocusNode.unfocus();

                      if (_editItemFormKey.currentState.validate()) {
                        setState(() {
                          _isProcessing = true;
                        });

                        title = _titleController.text;
                        note = _descriptionController.text;
                        DiaryCrud.updateItem(
                        docId: widget.documentId,
                        dateTime: actualDateVal,
                        title: title,
                        note: note,
                        rating: rate);
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const home()));

                        setState(() {
                          _isProcessing = false;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'UPDATE',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.white,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
