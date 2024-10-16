import 'package:flutter/material.dart';
import 'package:todo_app/views/home/components/todo_card.dart';
import 'package:todo_app/widgets/todo_alert.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  List todos = [
    {
      'title': 'Test',
      'description': 'Testing Todo',
      'completed': false,
    },
    {
      'title': 'Test 2',
      'description': 'Testing Todo 2',
      'completed': true,
    },
  ];
  updateTodoInList(int index, String title, String description) {
    setState(() {
      todos[index]['title'] = title;
      todos[index]['description'] = description;
    });
  }

  updateTodo(int index) {
    setState(() {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: ToDoAlert(
                index: index,
                item: todos[index],
                save: updateTodoInList,
                title: 'Edit Todo',
                isAdd: false,
              ),
            ),
          );
        },
      );
    });
  }

  addTodoToList(String title, String description) {
    setState(() {
      todos.add({
        'title': title,
        'description': description,
        'completed': false,
      });
    });
  }

  addTodo() {
    setState(() {
      showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel: '',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation1, animation2) {
          return Container();
        },
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
            child: FadeTransition(
              opacity: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: ToDoAlert(
                index: todos.length,
                item: const {},
                save: addTodoToList,
                title: 'Add Todo',
                isAdd: true,
              ),
            ),
          );
        },
      );
    });
  }

  deleteTodo(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  completeTodoItem(int index) {
    setState(() {
      todos[index]['completed'] = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text('Todo'),
        actions: [
          IconButton(
            onPressed: () => addTodo(),
            icon: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
        child: LayoutBuilder(builder: (context, constraints) {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 30,
            runSpacing: 20,
            children: List.generate(
              todos.length,
              (index) {
                return ToDoCard(
                  width: constraints.maxWidth,
                  index: index,
                  item: todos[index],
                  edit: updateTodo,
                  delete: deleteTodo,
                  complete: completeTodoItem,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
