import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:alethatestapp/blocs/exercise_event.dart';
import 'package:alethatestapp/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../blocs/exercise_bloc.dart';
import '../../models/exercise.dart';

class DetailScreen extends StatefulWidget {
  final Exercise exercise;

  const DetailScreen({super.key, required this.exercise});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isStarted = false;
  Timer? timer;
  late int remaining;
  late int total;
  late Uint8List decodedImage;

  @override
  void initState() {
    super.initState();
    total = widget.exercise.duration;
    remaining = total;

    // Decode base64 once here
    const base64Image =
        'data:image/jpeg;base64,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'; // your full string
    decodedImage = base64Decode(base64Image.split(',').last);
  }

  void startTimer() {
    setState(() => isStarted = true);
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      setState(() {
        remaining--;
        if (remaining <= 0) {
          t.cancel();
          context
              .read<ExerciseBloc>()
              .add(MarkExerciseCompleted(widget.exercise.id));
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Done!'),
              content: const Text('Exercise completed.'),
              actions: [
                TextButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double percent = (total - remaining) / total;

    return Scaffold(
      appBar: AppBar(title: Text(widget.exercise.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.memory(
                decodedImage,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.description, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.exercise.description,
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.timer, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '${widget.exercise.duration} seconds',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.fitness_center, color: Colors.orange),
                const SizedBox(width: 8),
                Text(
                  widget.exercise.difficulty.capitalizeFirst(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (!isStarted) ...[
              ElevatedButton.icon(
                icon: const Icon(Icons.play_arrow),
                label: const Text('Start Exercise'),
                onPressed: startTimer,
              ),
            ] else ...[
              const SizedBox(height: 24),
              CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 12.0,
                animation: true,
                animateFromLastPercent: true,
                percent: percent.clamp(0.0, 1.0),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$remaining s',
                        style: const TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold)),
                    Text('${(percent * 100).toStringAsFixed(0)}% complete'),
                  ],
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.blue,
                backgroundColor: Colors.grey.shade300,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
