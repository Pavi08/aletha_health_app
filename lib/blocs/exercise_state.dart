import '../../models/exercise.dart';

abstract class ExerciseState {}

class ExerciseInitial extends ExerciseState {}

class ExerciseLoading extends ExerciseState {}

class ExerciseLoaded extends ExerciseState {
  final List<Exercise> exercises;
  final Set<String> completedIds;

  ExerciseLoaded(this.exercises, this.completedIds);
}

class ExerciseError extends ExerciseState {
  final String message;
  ExerciseError(this.message);
}
