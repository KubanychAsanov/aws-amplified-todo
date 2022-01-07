import 'dart:async';
import 'dart:developer';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../amplifyconfiguration.dart';
import '../../models/ModelProvider.dart';
import '../../widgets/add_todo_form.dart';
import '../widgets/error_page.dart';
import '../widgets/todo_list.dart';
import 'bloc/todos_bloc.dart';
import 'bloc/todos_state.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({Key? key}) : super(key: key);

  @override
  _TodosPageState createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  // loading ui state - initially set to a loading state
  bool _isAmplifyConfigured = true;

  // list of Todos - initially empty
  // List<Todo> _todos = [];

  // amplify plugins
  final AmplifyDataStore _dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();

  // subscription of Todo QuerySnapshots - to be initialized at runtime
  // StreamSubscription<QuerySnapshot<Todo>>? _subscription;

  @override
  void initState() {
    // kick off app initialization
    _configureAmplify();

    super.initState();
  }

  @override
  void dispose() {
    // to be filled in a later step
    super.dispose();
  }

  // Future<void> _initializeApp() async {
  // configure Amplify
  // await _configureAmplify();

  // Query and Observe updates to Todo models. DataStore.observeQuery() will
  // emit an initial QuerySnapshot with a list of Todo models in the local store,
  // and will emit subsequent snapshots as updates are made
  //
  // each time a snapshot is received, the following will happen:
  // _isLoading is set to false if it is not already false
  // _todos is set to the value in the latest snapshot
  // Amplify.DataStore.observeQuery(Todo.classType)
  //     .listen((QuerySnapshot<Todo> snapshot) {
  //   setState(() {
  //     if (_isAmplifyConfigured) _isAmplifyConfigured = false;
  //     _todos = snapshot.items;
  //   });
  // });
  // }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([_dataStorePlugin, _apiPlugin, _authPlugin]);

      await Amplify.configure(amplifyconfig);
      setState(() {
        if (_isAmplifyConfigured) _isAmplifyConfigured = false;
      });
    } catch (e) {
      log('An error occurred while configuring Amplify: $e');
    }
  }

  void _startAddNewTodo(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return BlocProvider.value(
              value: context.read<TodosBloc>(),
              child: GestureDetector(
                onTap: () {},
                behavior: HitTestBehavior.opaque,
                child: const AddTodoForm(),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Todo List'),
      ),
      body: _isAmplifyConfigured
          ? const Center(child: CircularProgressIndicator())
          : BlocBuilder<TodosBloc, FetchTodosState>(
              builder: (context, state) {
                if (state is FetchTodosLoaded) {
                  return TodosList(todos: state.todos);
                } else if (state is FetchTodosLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is FetchTodosError) {
                  return const ErrorPage();
                }
                return Center(child: Text('$state'));
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _startAddNewTodo(context);
        },
        tooltip: 'Add Todo',
        label: Row(
          children: const [Icon(Icons.add), Text('Add todo')],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
