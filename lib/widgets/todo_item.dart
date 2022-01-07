import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/Todo.dart';
import '../screens/bloc/todos_bloc.dart';
import '../screens/bloc/todos_event.dart';

class TodoItem extends StatelessWidget {
  final double iconSize = 24.0;
  final Todo todo;

  const TodoItem({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        onTap: () => context.read<TodosBloc>().add(TodoUpdated(todo: todo)),
        onLongPress: () =>
            context.read<TodosBloc>().add(TodoDeleted(todo: todo)),
        leading: SizedBox(
          height: double.infinity,
          child: Icon(
            todo.isComplete ? Icons.check_box : Icons.check_box_outline_blank,
          ),
        ),
        title: Text(
          todo.name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        subtitle: Text(
          todo.description ?? "No description",
          // DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          color: Colors.black,
          onPressed: () =>
              context.read<TodosBloc>().add(TodoDeleted(todo: todo)),
        ),
      ),
    );
  }
}
