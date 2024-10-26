import 'package:flutter/material.dart';

class SimpleFlutterStepper extends StatefulWidget {
  const SimpleFlutterStepper({
    super.key,
    this.curve,
    this.width,
    this.textDirection,
    required this.color,
    required this.titles,
    required this.duration,
    required this.textStyle,
    required this.itemCount,
    required this.activeStep,
    required this.bodyChild,
    required this.footerChild,
  });

  final Color color;

  final Curve? curve;

  final double? width;

  final int itemCount;

  final int activeStep;

  final Widget bodyChild;

  final Duration duration;

  final Widget footerChild;

  final TextStyle textStyle;

  final TextDirection? textDirection;

  final List<String> titles;

  @override
  State<SimpleFlutterStepper> createState() => _SimpleFlutterStepperState();
}

class _SimpleFlutterStepperState extends State<SimpleFlutterStepper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<bool> stepShown;
  int previousActiveStep = -1;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    stepShown = List<bool>.filled(widget.itemCount, false);

    stepShown[0] = true;

    super.initState();
  }

  @override
  void didUpdateWidget(covariant SimpleFlutterStepper oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeStep != previousActiveStep) {
      setState(() {
        _controller.reset();
        _controller.forward();
        stepShown[widget.activeStep] = true;
        previousActiveStep = widget.activeStep;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: widget.textDirection ?? TextDirection.rtl,
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: SizedBox(
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.itemCount,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: widget.duration,
                              width: widget.width ?? defaultWidth(context, condition: widget.activeStep == index),
                              height: widget.activeStep == index ? 10 : 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                color: widget.color,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            SizedBox(
                              height: 20.0,
                              child: widget.activeStep == index && stepShown[index]
                                  ? FadeTransition(
                                      opacity: _controller,
                                      child: Text(
                                        widget.titles[index],
                                        style: widget.textStyle,
                                      ),
                                    )
                                  : const SizedBox(),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Flexible(
                flex: 12,
                child: widget.bodyChild,
              ),
              Flexible(
                flex: 1,
                child: widget.footerChild,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

double defaultWidth(BuildContext context, {required bool condition}) {
  if (condition) {
    return MediaQuery.sizeOf(context).width * 0.2;
  } else {
    return MediaQuery.sizeOf(context).width * 0.07;
  }
}
