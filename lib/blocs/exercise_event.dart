abstract class ExerciseEvent {}

class FetchExercises extends ExerciseEvent {}

class MarkExerciseCompleted extends ExerciseEvent {
  final String id;
  MarkExerciseCompleted(this.id);
}
