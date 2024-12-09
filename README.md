a custom stepper without used any packages and simple to use.

## Features

This is a demo of my custom widget:

![Demo of Custom Stepper](example/assets/simple_flutter_stepper.gif)

## Usage


```dart
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SimpleFlutterStepper(
        buttonPadding: const EdgeInsets.all(8),
        nextOnTap: () => goToStep(currentStep + 1),
        previousOnTap: () => goToStep(currentStep - 1),
        itemCount: 8,
        disableColor: Colors.grey,
        activeStep: currentStep,
        textStyle: const TextStyle(fontSize: 14.0, color: Colors.black),
        titles: const ['Step 1', 'Step 2', 'Step 3', 'Step 4', 'Step 5', 'Step 6', 'Step 7', 'Step 8'],
        duration: const Duration(milliseconds: 2000),
        activeColor: Colors.blueAccent,
        hasAppBar: true,
        leadingIcon: Icons.arrow_back,
        centerTitle: true,
        appBarTitle: const Text('Simple Stepper'),
        previousButtonTitle: currentStep == 0 ? 'Previous' : 'null',
        nextButtonTitle: 'Next',
        bodyChild: Container(
          color: getColor(currentStep),
        ),
      ),
    );
  }


```
