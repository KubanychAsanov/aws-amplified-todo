import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/bloc/todos_bloc.dart';
import 'package:todo_app/screens/bloc/todos_event.dart';

import '../screens/todo_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.indigo,
          ),
          fontFamily: GoogleFonts.openSans().fontFamily,
          textTheme: ThemeData.light().textTheme.copyWith(
              subtitle1: TextStyle(
                fontFamily: GoogleFonts.openSans().fontFamily,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              button: const TextStyle(color: Colors.white)),
        ),
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => TodosBloc()..add(FetchTodosData()),
          child: const TodosPage(),
        ));
  }
}
