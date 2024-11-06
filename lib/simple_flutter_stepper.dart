import 'package:flutter/material.dart';

///Build simple and easy stepper for your project
class SimpleFlutterStepper extends StatefulWidget {
  ///in this constructors you need to set a series of values ​​for a better display.
  const SimpleFlutterStepper({
    super.key,
    this.curve,
    this.width,
    this.appBar,
    this.textDirection,
    this.backgroundColor,
    required this.previousOnTap,
    required this.nextOnTap,
    this.previousButtonTitle,
    this.nextButtonTitle,
    this.nextButtonTextStyle,
    this.previousButtonTextStyle,
    this.nextButtonStyle,
    this.previousButtonStyle,
    required this.activeColor,
    required this.disableColor,
    required this.titles,
    required this.duration,
    required this.textStyle,
    required this.itemCount,
    required this.activeStep,
    required this.bodyChild,
  });

  ///The Color for active step
  final Color activeColor;

  ///The Color for active step
  final Color disableColor;

  ///The curve for how show animations
  final Curve? curve;

  ///Width for stepper containers
  final double? width;

  ///How many step you need build in stepper
  final int itemCount;

  ///which step is active in your steps
  final int activeStep;

  ///The middle Widget to show users and work with for complete the steps
  final Widget bodyChild;

  ///Time to show and work animations
  final Duration duration;

  ///Style of step text
  final TextStyle textStyle;

  ///Show rtl or ltr default is rtl
  final TextDirection? textDirection;

  ///The list of title of step
  final List<String> titles;

  ///The appbar for show in scaffold
  final PreferredSizeWidget? appBar;

  ///Background Color of scaffold
  final Color? backgroundColor;

  ///Set onPressed for previous button
  final VoidCallback previousOnTap;

  ///Set onPressed for next button
  final VoidCallback nextOnTap;

  ///Title for previous button
  final String? previousButtonTitle;

  ///Title for next button
  final String? nextButtonTitle;

  ///Style of next button title
  final TextStyle? nextButtonTextStyle;

  ///Style of previous button title
  final TextStyle? previousButtonTextStyle;

  ///Style of next button
  final ButtonStyle? nextButtonStyle;

  ///Style of previous button
  final ButtonStyle? previousButtonStyle;

  @override
  State<SimpleFlutterStepper> createState() => _SimpleFlutterStepperState();
}

class _SimpleFlutterStepperState extends State<SimpleFlutterStepper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<bool> stepShown;
  int previousActiveStep = -1;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    if (widget.itemCount == widget.titles.length) {
      stepShown = List<bool>.filled(widget.itemCount, false);

      stepShown[0] = true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text('Please check your itemCount and titles list length'),
          ),
        ),
      );
    }
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
      backgroundColor: widget.backgroundColor,
      appBar: widget.appBar,
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
                              width: widget.width ??
                                  defaultWidth(
                                    context,
                                    condition: widget.activeStep == index,
                                  ),
                              height: widget.activeStep == index ? 10 : 4,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50.0),
                                ),
                                color: stepShown[index] == true
                                    ? widget.activeColor
                                    : widget.disableColor,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            SizedBox(
                              height: 20.0,
                              child:
                                  widget.activeStep == index && stepShown[index]
                                      ? FadeTransition(
                                          opacity: _controller,
                                          child: Text(
                                            widget.titles[index],
                                            style: widget.textStyle.copyWith(
                                              color: widget.activeStep == index
                                                  ? widget.activeColor
                                                  : null,
                                            ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Visibility(
                      visible: widget.nextButtonTitle != null,
                      child: ElevatedButton(
                        style: widget.nextButtonStyle,
                        onPressed: () {
                          setState(() {
                            stepShown[widget.activeStep] = true;
                          });
                          widget.nextOnTap();
                        },
                        child: Text(
                          widget.nextButtonTitle!,
                          style: widget.nextButtonTextStyle,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: widget.previousButtonTitle != null,
                      child: ElevatedButton(
                        style: widget.previousButtonStyle,
                        onPressed: () {
                          setState(() {
                            stepShown[widget.activeStep] = false;
                          });

                          widget.previousOnTap();
                        },
                        child: Text(
                          widget.previousButtonTitle!,
                          style: widget.previousButtonTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///if User has no size for width step container we use this method to get width in active and deActive step
double defaultWidth(BuildContext context, {required bool condition}) {
  if (condition) {
    return MediaQuery.sizeOf(context).width * 0.2;
  } else {
    return MediaQuery.sizeOf(context).width * 0.07;
  }
}
