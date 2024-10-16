// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:languagetool_textfield/core/controllers/language_tool_controller.dart';
import 'package:languagetool_textfield/presentation/language_tool_text_field.dart';

class ToDoAlert extends StatefulWidget {
  const ToDoAlert({
    super.key,
    required this.save,
    required this.index,
    required this.item,
    required this.title,
    required this.isAdd,
  });
  final Function save;
  final int index;
  final Map item;
  final String title;
  final bool isAdd;

  @override
  State<ToDoAlert> createState() => _ToDoAlertState();
}

class _ToDoAlertState extends State<ToDoAlert> {
  final descriptionController = LanguageToolController();
  final titleController = LanguageToolController();
  @override
  void initState() {
    super.initState();
    if (mounted) {
      titleController.text = widget.item['title'] ?? '';
      descriptionController.text = widget.item['description'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var device = MediaQuery.sizeOf(context);
    Widget saveButton = ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white),
      onPressed: () async {
        if (titleController.text.isNotEmpty) {
          setState(() {
            if (widget.isAdd) {
              widget.save(titleController.text, descriptionController.text);
            } else {
              widget.save(widget.index, titleController.text,
                  descriptionController.text);
            }
            titleController.clear();
            descriptionController.clear();
          });
          Navigator.of(context, rootNavigator: true).pop();
        }
      },
      child: const SelectionContainer.disabled(
        child: Text(
          'Save',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    Widget cancelButton = OutlinedButton(
      style: OutlinedButton.styleFrom(
          backgroundColor: Theme.of(context).canvasColor,
          side: BorderSide(color: Theme.of(context).primaryColor, width: 1)),
      onPressed: () {
        setState(() {
          titleController.clear();
          descriptionController.clear();
        });
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: SelectionContainer.disabled(
        child: Text(
          'Cancel',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );

    return AlertDialog(
      surfaceTintColor:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20),
        child: Text(
          widget.title,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      actions: [
        Container(
          width: device.width / 2 > 500 ? device.width / 2 : 500,
          color: MediaQuery.of(context).platformBrightness == Brightness.light
              ? Colors.white
              : Theme.of(context).scaffoldBackgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: device.width > 360
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      cancelButton,
                      const SizedBox(
                        width: 20,
                      ),
                      saveButton,
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      cancelButton,
                      const SizedBox(
                        height: 20,
                      ),
                      saveButton,
                    ],
                  ),
          ),
        ),
      ],
      content: SizedBox(
        width: 500,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LanguageToolTextField(
                controller: titleController,
                maxLines: 1,
                minLines: 1,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9).withOpacity(0.23),
                  hintText: 'Add Title',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Urbanist',
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                    gapPadding: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                    gapPadding: 10,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              LanguageToolTextField(
                controller: descriptionController,
                maxLines: 8,
                minLines: 8,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9).withOpacity(0.23),
                  hintText: 'Add Description',
                  hintStyle: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'Urbanist',
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 20,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                    gapPadding: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                    gapPadding: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
