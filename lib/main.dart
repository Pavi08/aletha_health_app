import 'package:alethatestapp/blocs/exercise_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/exercise_bloc.dart';
import 'repositories/exercise_repository.dart';
import 'screens/home/home_screen.dart';

void main() {
  runApp(const ExerciseApp());
}

class ExerciseApp extends StatelessWidget {
  const ExerciseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (_) => ExerciseRepository(),
      child: BlocProvider(
        create: (context) => ExerciseBloc(
          repository: context.read<ExerciseRepository>(),
        )..add(FetchExercises()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Exercise App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: true,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
