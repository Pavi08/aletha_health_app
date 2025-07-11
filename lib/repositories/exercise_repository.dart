import 'package:dio/dio.dart';
import '../models/exercise.dart';

class ExerciseRepository {
  final String apiUrl = 'https://68252ec20f0188d7e72c394f.mockapi.io/dev/workouts';
  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      responseType: ResponseType.json,
    ),
  );

  Future<List<Exercise>> fetchExercises() async {
    try {
      final response = await dio.get(apiUrl);

      if (response.statusCode == 200 && response.data is List) {
        print(response.data);
        final List<dynamic> data = response.data;
        return data.map((e) => Exercise.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected response format or status');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Connection timed out. Please try again.');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else if (e.type == DioExceptionType.unknown) {
        throw Exception('No internet connection.');
      } else {
        throw Exception('Unexpected error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }
}
