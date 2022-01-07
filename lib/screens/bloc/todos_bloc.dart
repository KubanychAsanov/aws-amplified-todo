import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/todo_repo.dart';
import 'package:todo_app/models/error_model.dart';

import 'todos_event.dart';
import 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, FetchTodosState> {
  TodosRepo repo = TodosRepo();

  TodosBloc() : super(FetchTodosInitial()) {
    on<TodosEvent>((event, emit) async {
      if (event is FetchTodosData) {
        emit(FetchTodosLoading());
        try {
          final data = await repo.getItems();

          emit(FetchTodosLoaded(todos: data));
        } on FetchDataError catch (e) {
          emit(FetchTodosError(error: e));
        } catch (e) {
          emit(FetchTodosError(error: FetchDataError('something went wrong')));
        }
      }

      if (event is TodoAdded) {
        try {
          await repo.createItem(event.name, event.description ?? '');
          add(FetchTodosData());
        } catch (e) {
          log(e.toString());
        }
      }

      if (event is TodoUpdated) {
        try {
          await repo.updateItemComplete(event.todo);
          add(FetchTodosData());
        } catch (e) {
          log(e.toString());
        }
      }

      if (event is TodoDeleted) {
        try {
          await repo.deleteItem(event.todo);
          add(FetchTodosData());
        } catch (e) {
          log(e.toString());
        }
      }
    });
  }
}
