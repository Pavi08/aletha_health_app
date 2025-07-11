import 'package:alethatestapp/blocs/exercise_state.dart';
import 'package:alethatestapp/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/exercise_bloc.dart';
import '../../screens/detail/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercises'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<ExerciseBloc, ExerciseState>(
        builder: (context, state) {
          if (state is ExerciseLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ExerciseLoaded) {
            if (state.exercises.isEmpty) {
              return const Center(child: Text('No exercises found.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.exercises.length,
              itemBuilder: (context, index) {
                final exercise = state.exercises[index];
                final completed = state.completedIds.contains(exercise.id);

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Text(
                        exercise.duration.toString(),
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    title: Text(
                      exercise.name.capitalizeFirst(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text('Duration: ${exercise.duration} sec'),
                    trailing: completed
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.fitness_center, color: Colors.grey),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(exercise: exercise),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ExerciseError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
