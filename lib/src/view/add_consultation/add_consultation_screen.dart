import 'package:even_assignment/src/app.dart';
import 'package:even_assignment/src/utility/utility.dart';
import 'package:flutter/material.dart';

class AddConsultationScreen extends StatefulWidget {
  const AddConsultationScreen({super.key});

  @override
  State<AddConsultationScreen> createState() => _AddConsultationScreenState();
}

class _AddConsultationScreenState extends State<AddConsultationScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  late final AnimationController transitionAnimation;

  late bool isPageLoaded;

  @override
  void didPop() {
    super.didPop();
    transitionAnimation.reverse();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void initState() {
    super.initState();
    transitionAnimation = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 11.0,
      duration: const Duration(milliseconds: 500),
    );

    isPageLoaded = false;
    Future.delayed(const Duration(milliseconds: 600), () async {
      if (mounted) {
        setState(() {
          isPageLoaded = true;
        });
        transitionAnimation.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    transitionAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            color: AppColor.backgroundColor.withOpacity(0.8),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: AnimatedBuilder(
                                animation: transitionAnimation,
                                builder: (context, _) => Transform.translate(
                                      offset: Offset(
                                        (11 - transitionAnimation.value) * 5,
                                        (11 - transitionAnimation.value) * 5,
                                      ),
                                      child: Transform.rotate(
                                        angle: (22 ~/ 7) *
                                            transitionAnimation.value,
                                        child: const Icon(
                                          Icons.close_rounded,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    )),
                          ),
                          const Align(
                            alignment: Alignment.center,
                            child: Text('Choose type of service'),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Tele-Consultation'),
                          SizedBox(height: 32),
                          Text('Consultation'),
                          SizedBox(height: 32),
                          Text('Lab tests'),
                          SizedBox(height: 32),
                          Text('Diagnostics'),
                          SizedBox(height: 32),
                          Text('Health Checkup'),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: isPageLoaded ? 0 : 1,
              curve: Curves.linear,
              child: const ColoredBox(
                color: AppColor.blueColor,
                child: SizedBox.expand(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
