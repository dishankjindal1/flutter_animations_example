import 'package:even_assignment/src/utility/color.dart';
import 'package:even_assignment/src/view/bottom_nav/bottom_navigation_item.dart';
import 'package:flutter/material.dart';

class BottomNavigationModule extends StatefulWidget {
  const BottomNavigationModule({
    super.key,
    required this.selectedIndex,
    required this.callback,
  });

  final int selectedIndex;
  final ValueChanged<int> callback;

  @override
  State<BottomNavigationModule> createState() => _BottomNavigationModuleState();
}

class _BottomNavigationModuleState extends State<BottomNavigationModule>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  late final Animation<double> animatedDouble;

  late ValueNotifier<bool> navBlueHighlighterVisible;

  @override
  void initState() {
    super.initState();
    navBlueHighlighterVisible = ValueNotifier(false);
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
    navBlueHighlighterVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.backgroundColor,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, _) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          if (widget.selectedIndex == index) return;
                          navBlueHighlighterVisible.value = true;

                          await animation.reverse();
                          widget.callback(index);
                          await animation.forward();

                          navBlueHighlighterVisible.value = false;
                        },
                        child: BottomNavigationItem(
                          index: index,
                          isSelected: widget.selectedIndex == index,
                          animatedDouble: animatedDouble.value,
                        ),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder<bool>(
                  valueListenable: navBlueHighlighterVisible,
                  builder: (context, isNavBlueHighlighterVisible, child) {
                    return AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: isNavBlueHighlighterVisible ? 1 : 0,
                      child: child!,
                    );
                  },
                  child: AnimatedAlign(
                    duration: const Duration(milliseconds: 250),
                    alignment:
                        Alignment(-0.75 + (0.50 * widget.selectedIndex), 1),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 16),
                        Material(
                          type: MaterialType.circle,
                          color: AppColor.navBlue,
                          child: SizedBox.square(dimension: 16),
                        ),
                        SizedBox(height: 26),
                        Material(
                          type: MaterialType.circle,
                          color: Colors.white,
                          child: SizedBox.square(dimension: 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
