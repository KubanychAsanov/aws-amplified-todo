import 'package:todo_app/models/ModelProvider.dart';
import '../../../models/error_model.dart';

abstract class FetchTodosState {}

class FetchTodosInitial extends FetchTodosState {}

class FetchTodosLoading extends FetchTodosState {}

class FetchTodosLoaded extends FetchTodosState {
  final List<Todo> todos;
  FetchTodosLoaded({
    required this.todos,
  });
}

class FetchTodosError extends FetchTodosState {
  final FetchDataError error;
  FetchTodosError({
    required this.error,
  });
}
