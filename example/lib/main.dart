import 'package:flutter/material.dart';
import 'package:custom_stepper/custom_stepper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentStep = 0;

  void goToStep(int step) {
    setState(() {
      currentStep = step.clamp(0, 7);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomStepper(
        itemCount: 8,
        activeStep: currentStep,
        textStyle: const TextStyle(fontSize: 14.0, color: Colors.black),
        titles: const ['شروع', 'کارشناسی', 'اظهارات', 'کالا', 'خدمت', 'اتمام کار', 'صورت حساب', 'پرداخت'],
        duration: const Duration(milliseconds: 2000),
        color: Colors.blueAccent,
        bodyChild: Container(),
        footerChild: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                goToStep(currentStep + 1);
              },
              child: const Text('plus'),
            ),
            ElevatedButton(
              onPressed: () {
                goToStep(currentStep - 1);
              },
              child: const Text('mineus'),
            ),
          ],
        ),
      ),
    );
  }
}
