import 'package:astronomy_picture/container_injection.dart';
import 'package:astronomy_picture/presentation/pages/today_apod/apod_today_page.dart';
import 'package:flutter/material.dart';

void main() async {
  await setupContainer();
  runApp(const AstronomyPicture());
}

class AstronomyPicture extends StatelessWidget {
  const AstronomyPicture({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: ApodTodayPage(),
    );
  }
}
