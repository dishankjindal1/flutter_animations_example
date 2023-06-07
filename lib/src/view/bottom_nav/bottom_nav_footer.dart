import 'dart:async';

import 'package:even_assignment/src/view/history/history_screen.dart';
import 'package:flutter/material.dart';

class BottomNavigationFooter extends StatefulWidget {
  const BottomNavigationFooter(
      { super.key});


  @override
  State<BottomNavigationFooter> createState() => _BottomNavigationFooterState();
}

class _BottomNavigationFooterState extends State<BottomNavigationFooter> {
  late bool isPageLoaded;

  late int selectedPageIndex;
  late final PageController pageCtrl;

  @override
  void initState() {
    super.initState();
    isPageLoaded = false;
    selectedPageIndex = 1;
    pageCtrl = PageController(initialPage: 1);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(milliseconds: 250), () {
        setState(() {
          isPageLoaded = true;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
      child: SafeArea(
        top: false,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          color: isPageLoaded ? Colors.white : Colors.blueAccent,
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: PageView(
                  controller: pageCtrl,
                  children: <Widget>[
                    const ColoredBox(
                      color: Color(0xFFC4C4C4),
                      child: Placeholder(),
                    ),
                    HistoryScreen(isSelected: selectedPageIndex == 1),
                    const ColoredBox(
                      color: Color(0xFFC4C4C4),
                      child: Placeholder(),
                    ),
                    const ColoredBox(
                      color: Color(0xFFC4C4C4),
                      child: Placeholder(),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomNavigationModule(
                  index: selectedPageIndex,
                  callback: (index) {
                    pageCtrl.animateToPage(index,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn);
                    setState(() {
                      selectedPageIndex = index;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomNavigationModule extends StatefulWidget {
  const BottomNavigationModule({
    required this.index,
    required this.callback,
    super.key,
  });

  final int index;
  final ValueChanged<int> callback;

  @override
  State<BottomNavigationModule> createState() => _BottomNavigationModuleState();
}

class _BottomNavigationModuleState extends State<BottomNavigationModule>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  late final Animation<double> animatedDouble;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(
        milliseconds: 250,
      ),
    );

    animatedDouble = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animation,
        curve: Curves.easeIn,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      animation.forward();
    });
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return Container(
            color: const Color(0xFFC4C4C4),
            height: kBottomNavigationBarHeight * 1.5,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await animation.reverse();
                          widget.callback(0);
                          await animation.forward();
                        },
                        child: BottomNavigationItem(
                          icon: Icons.home,
                          isSelected: widget.index == 0,
                          navType: NavType.left,
                          animatedDouble: animatedDouble,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await animation.reverse();
                          widget.callback(1);
                          await animation.forward();
                        },
                        child: BottomNavigationItem(
                          icon: Icons.timelapse,
                          isSelected: widget.index == 1,
                          navType: NavType.middle,
                          animatedDouble: animatedDouble,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await animation.reverse();
                          widget.callback(2);
                          await animation.forward();
                        },
                        child: BottomNavigationItem(
                          icon: Icons.follow_the_signs_rounded,
                          isSelected: widget.index == 2,
                          navType: NavType.middle,
                          animatedDouble: animatedDouble,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          await animation.reverse();
                          widget.callback(3);
                          await animation.forward();
                        },
                        child: BottomNavigationItem(
                          icon: Icons.person,
                          isSelected: widget.index == 3,
                          navType: NavType.right,
                          animatedDouble: animatedDouble,
                        ),
                      ),
                    ),
                  ],
                ),
                AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  alignment: Alignment(-0.75 + (0.50 * widget.index), 1),
                  child: const Material(
                    type: MaterialType.circle,
                    color: Colors.white,
                    child: SizedBox.square(dimension: 4),
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    required this.icon,
    required this.isSelected,
    required this.navType,
    required this.animatedDouble,
    super.key,
  });

  final IconData icon;
  final bool isSelected;
  final NavType navType;
  final Animation<double> animatedDouble;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isSelected ? animatedDouble.value : 1,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: CustomPaint(
          painter: isSelected
              ? BellShapePainter(animatedDouble.value, navType)
              : null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.black,
              ),
              const SizedBox(height: 20),
              const Visibility(
                visible: false,
                child: Material(
                  type: MaterialType.circle,
                  color: Colors.white,
                  child: SizedBox.square(dimension: 4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum NavType { left, middle, right }

class BellShapePainter extends CustomPainter {
  final double animatedHeight;
  final NavType navType;

  BellShapePainter(
    this.animatedHeight,
    this.navType,
  );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    // Left
    final leftPath = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.33, 0)
      ..cubicTo(
        size.width * 1.2,
        size.height * 0,
        size.width * 0.6,
        size.height * 1.0,
        size.width * 1.4,
        size.height * 1.0,
      )
      ..lineTo(0, size.height)
      ..close();

    // Middle
    final middlePath = Path()
      ..moveTo(size.width * -0.2, size.height * 1.0)
      ..cubicTo(
        size.width * 0.2,
        size.height * 1,
        size.width * 0.1,
        size.height * 0,
        size.width * 0.5,
        size.height * 0,
      )
      ..cubicTo(
        size.width * 0.9,
        size.height * 0,
        size.width * 0.8,
        size.height * 1.0,
        size.width * 1.2,
        size.height * 1,
      )
      ..close();

    // Right
    final rightPath = Path()
      ..moveTo(size.width, size.height)
      ..lineTo(size.width * 1.0, 0)
      ..lineTo(size.width * 0.66, 0)
      ..cubicTo(
        size.width * 0,
        size.height * 0,
        size.width * 0.4,
        size.height * 1.0,
        size.width * -0.4,
        size.height * 1.0,
      )
      ..lineTo(0, size.height)
      ..close();

    if (navType == NavType.left) {
      canvas.drawPath(leftPath, paint);
    } else if (navType == NavType.right) {
      canvas.drawPath(rightPath, paint);
    } else {
      canvas.drawPath(middlePath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
