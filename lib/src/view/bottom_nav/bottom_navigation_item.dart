import 'package:even_assignment/src/utility/utility.dart';
import 'package:even_assignment/src/view/bottom_nav/nav_active_state_shape_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavigationItem extends StatelessWidget {
  const BottomNavigationItem({
    super.key,
    required this.index,
    required this.isSelected,
    required this.animatedDouble,
  });

  final int index;
  final bool isSelected;
  final double animatedDouble;

  @override
  Widget build(BuildContext context) {
    final NavType navType = index == 0
        ? NavType.left
        : index == 3
            ? NavType.right
            : NavType.middle;

    final List<String> iconsOff = [
      AppImageAsset.homeNavIconOff,
      AppImageAsset.historyNavIconOff,
      AppImageAsset.mindfulnessNavIconOff,
      AppImageAsset.accountNavIconOff
    ];
    final List<String> iconsOn = [
      AppImageAsset.homeNavIconOn,
      AppImageAsset.historyNavIconOn,
      AppImageAsset.mindfulnessNavIconOn,
      AppImageAsset.accountNavIconOn
    ];

    return CustomPaint(
      painter: isSelected
          ? NavActiveStateShapePainter(animatedDouble, navType)
          : null,
      child: Opacity(
        opacity: isSelected ? animatedDouble : 1,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            SvgPicture.asset(
              isSelected ? iconsOn[index] : iconsOff[index],
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 0),
              curve: Curves.slowMiddle,
              opacity: isSelected ? 1 : 0,
              child: const Material(
                type: MaterialType.circle,
                color: Colors.white,
                child: SizedBox.square(dimension: 4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
