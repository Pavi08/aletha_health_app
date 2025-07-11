import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/exercise.dart';
import '../../repositories/exercise_repository.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  final ExerciseRepository repository;
  Set<String> completedIds = {};

  ExerciseBloc({required this.repository}) : super(ExerciseInitial()) {
    on<FetchExercises>(_onFetchExercises);
    on<MarkExerciseCompleted>(_onMarkCompleted);
    _loadCompletedIds();
  }

  Future<void> _onFetchExercises(FetchExercises event, Emitter<ExerciseState> emit) async {
    emit(ExerciseLoading());
    try {
      final exercises = await repository.fetchExercises();
      emit(ExerciseLoaded(exercises, completedIds));
    } catch (e) {
      emit(ExerciseError('Failed to fetch exercises'));
    }
  }

  Future<void> _onMarkCompleted(MarkExerciseCompleted event, Emitter<ExerciseState> emit) async {
    completedIds.add(event.id);
    await _saveCompletedIds();
    if (state is ExerciseLoaded) {
      final currentState = state as ExerciseLoaded;
      emit(ExerciseLoaded(currentState.exercises, completedIds));
    }
  }

  Future<void> _loadCompletedIds() async {
    final prefs = await SharedPreferences.getInstance();
    completedIds = prefs.getStringList('completed_ids')?.toSet() ?? {};
    if (state is ExerciseLoaded) {
      final currentState = state as ExerciseLoaded;
      emit(ExerciseLoaded(currentState.exercises, completedIds));
    }
  }

  Future<void> _saveCompletedIds() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('completed_ids', completedIds.toList());
  }
}
