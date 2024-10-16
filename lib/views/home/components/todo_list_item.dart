import 'package:flutter/material.dart';

class ToDoListItem extends StatefulWidget {
  final int index;
  final Map item;
  final Function delete;
  final Function edit;
  final Function complete;

  const ToDoListItem({
    super.key,
    required this.index,
    required this.item,
    required this.delete,
    required this.edit,
    required this.complete,
  });

  @override
  State<ToDoListItem> createState() => _ToDoListItemState();
}

class _ToDoListItemState extends State<ToDoListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 8, 25, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Text(
                  widget.item['title'],
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    fontFamily: 'Inter',
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                borderRadius: BorderRadius.circular(40),
                child: Tooltip(
                  message: 'More',
                  child: PopupMenuButton<int>(
                    tooltip: '',
                    surfaceTintColor:
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Colors.white
                            : Theme.of(context).cardColor,
                    position: PopupMenuPosition.under,
                    itemBuilder: (context) => [
                      if (!widget.item['completed'])
                        PopupMenuItem(
                          value: 1,
                          onTap: () => widget.complete(widget.index),
                          child: const Text("Complete"),
                        ),
                      PopupMenuItem(
                        value: 2,
                        onTap: () => widget.edit(widget.index),
                        child: const Text("Edit"),
                      ),
                      PopupMenuItem(
                        value: 3,
                        onTap: () => widget.delete(widget.index),
                        child: const Text("Delete"),
                      ),
                    ],
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Colors.black,
                      size: 20,
                    ),
                    color: MediaQuery.of(context).platformBrightness ==
                            Brightness.light
                        ? Colors.white
                        : Theme.of(context).cardColor,
                    elevation: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 85,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.item['description'],
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
