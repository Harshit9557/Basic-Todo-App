import 'package:flutter/material.dart';
import 'package:todo_app/views/home/components/todo_list_item.dart';

class ToDoCard extends StatefulWidget {
  const ToDoCard({
    super.key,
    required this.width,
    required this.index,
    required this.item,
    required this.delete,
    required this.edit,
    required this.complete,
  });
  final double width;
  final int index;
  final Map item;
  final Function delete;
  final Function edit;
  final Function complete;

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 171,
          width: widget.width <= 700 ? widget.width : 260,
          decoration: BoxDecoration(
            color: MediaQuery.of(context).platformBrightness == Brightness.light
                ? Colors.white
                : Colors.black,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                offset: Offset.zero,
                blurRadius: 7,
                spreadRadius: 4,
                color: MediaQuery.of(context).platformBrightness ==
                        Brightness.light
                    ? Colors.grey.shade200
                    : Colors.black12,
              ),
            ],
          ),
          child: ToDoListItem(
            index: widget.index,
            item: widget.item,
            edit: widget.edit,
            delete: widget.delete,
            complete: widget.complete,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: widget.item['completed'] ? Colors.green : Colors.red,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
