import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/todo_screen/bloc/todos_bloc.dart';
import '../screens/todo_screen/bloc/todos_event.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({Key? key}) : super(key: key);

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  Future<void> _saveTodo() async {
    // get the current text field contents
    String name = _nameController.text;
    String description = _descriptionController.text;

    if (name.isEmpty) {
      return;
    }

    context
        .read<TodosBloc>()
        .add(TodoAdded(name: name, description: description));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 30),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  controller: _nameController,
                  decoration:
                      const InputDecoration(filled: true, labelText: 'Title'),
                ),
                TextFormField(
                  onFieldSubmitted: (_) => _saveTodo(),
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      filled: true, labelText: 'Description'),
                ),
                ElevatedButton(onPressed: _saveTodo, child: const Text('Save'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
