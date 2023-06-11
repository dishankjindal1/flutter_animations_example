// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:even_assignment/src/utility/color.dart';
import 'package:even_assignment/src/utility/style.dart';
import 'package:even_assignment/src/view/add_consultation/add_consultation_screen.dart';
import 'package:even_assignment/src/view/history/components/history_tile.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({required this.selectedPageIndex, super.key});

  final int selectedPageIndex;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  late final AnimationController transitionAnimation;
  late final AnimationController animation;
  late final ScrollController scrollController;
  late final GlobalKey<SliverAnimatedListState> verticalListKey;
  late List<Widget> verticalList;
  late final ValueNotifier<double> dynamicHeightForBar;

  @override
  void didUpdateWidget(HistoryScreen oldWidget) {
    if (oldWidget.selectedPageIndex != widget.selectedPageIndex) {
      if (widget.selectedPageIndex == 1 && oldWidget.selectedPageIndex != 1) {
        _addAll();
        if (!animation.isCompleted) {
          animation.forward();
        }
      } else if (oldWidget.selectedPageIndex == 1 &&
          widget.selectedPageIndex != 1) {
        _reverseAll();
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 100),
          curve: Curves.linear,
        );
        if (animation.isCompleted) {
          animation.reverse();
        }
      }
    } else {
      super.didUpdateWidget(oldWidget);
    }
  }

  Future<void> _reverseAll() async {
    try {
      for (var element in verticalList.reversed) {
        if (verticalListKey.currentState == null) {
          continue;
        }
        verticalListKey.currentState!.removeItem(
          verticalList.indexOf(element),
          (context, animation) {
            if (verticalList.indexOf(element) > 0) {
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.5, 0),
                  end: const Offset(0, 0),
                ).animate(
                  CurvedAnimation(
                    parent: animation,
                    curve: Curves.easeIn,
                  ),
                ),
                child: element,
              );
            }
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeIn,
                ),
              ),
              child: element,
            );
          },
        );
        await Future.delayed(
          Duration(
            milliseconds:
                10 * (verticalList.length - verticalList.indexOf(element)),
          ),
        );
      }

      if (verticalListKey.currentState != null) {
        verticalListKey.currentState!.removeAllItems(
            (context, animation) => const SizedBox(),
            duration: Duration.zero);
      }
    } catch (e) {
      //
    }
  }

  Future<void> _addAll() async {
    await Future.delayed(const Duration(milliseconds: 100));

    try {
      for (var element in verticalList) {
        if (verticalListKey.currentState == null) {
          break;
        }

        verticalListKey.currentState!.insertItem(verticalList.indexOf(element));
        await Future.delayed(const Duration(milliseconds: 50));
      }
    } catch (e) {
      //
    }
  }

  @override
  void initState() {
    super.initState();

    transitionAnimation = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 10.0,
      duration: const Duration(milliseconds: 500),
    );

    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();

    dynamicHeightForBar = ValueNotifier(0);

    scrollController = ScrollController();

    scrollController.addListener(() {
      dynamicHeightForBar.value = scrollController.offset;
    });

    verticalListKey = GlobalKey<SliverAnimatedListState>();
    verticalList = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 600)).whenComplete(() {
        if (widget.selectedPageIndex == 1) {
          _addAll();
        }
      });
    });
  }

  @override
  void dispose() {
    verticalList.clear();
    dynamicHeightForBar.dispose();
    super.dispose();
  }

  Widget verticalListWidget(Animation<double> animation, Widget child) {
    if (verticalList.indexOf(child) > 0) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.5, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeIn,
          ),
        ),
        child: child,
      );
    }
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
        ),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    verticalList = [
      AnimatedBuilder(
        key: UniqueKey(),
        animation: animation,
        builder: (context, child) {
          if (animation.value == 1) {
            return Opacity(
              opacity: 1,
              child: child,
            );
          }

          return Opacity(
            opacity: 0,
            child: child,
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () async {
                  _reverseAll();
                  transitionAnimation.forward();
                  await Future.delayed(const Duration(milliseconds: 100));
                  await showGeneralDialog(
                      context: context,
                      barrierColor: Colors.transparent,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return AnimatedBuilder(
                          animation: animation,
                          builder: (context, _) {
                            return const AddConsultationScreen();
                          },
                        );
                      });
                  transitionAnimation.reverse();
                  _addAll();
                },
                child: AnimatedBuilder(
                  animation: transitionAnimation,
                  builder: (context, child) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: OverflowBox(
                          alignment: Alignment.center,
                          maxWidth: 70 * ((transitionAnimation.value * 10) - 9),
                          minWidth: 70 * ((transitionAnimation.value * 10) - 9),
                          maxHeight: 70 * transitionAnimation.value * 10,
                          minHeight: 70 * transitionAnimation.value * 10,
                          child: CircleAvatar(
                            radius: 32 * transitionAnimation.value,
                            backgroundColor:
                                AppColor.blueColor.withOpacity(0.25),
                            child: CircleAvatar(
                              radius:
                                  26 * ((transitionAnimation.value * 10) - 9),
                              backgroundColor: AppColor.blueColor,
                              child: Transform.translate(
                                offset: Offset(
                                    10 - (transitionAnimation.value * 10),
                                    10 - (transitionAnimation.value * 10)),
                                child: Transform.rotate(
                                  angle: (10 * transitionAnimation.value) - 10,
                                  child: const Icon(
                                    Icons.add_rounded,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 24),
              Text(
                'Add consultation',
                style: AppTextStyle.bold14.copyWith(
                  color: AppColor.blueColor,
                ),
              ),
            ],
          ),
        ),
      ),
      HistoryTile(
        key: UniqueKey(),
      ),
      HistoryTile(
        key: UniqueKey(),
      ),
      HistoryTile(
        key: UniqueKey(),
      ),
    ];

    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.transparent,
      child: SafeArea(
        child: Stack(
          children: [
            if (scrollController.hasClients)
              ValueListenableBuilder<double>(
                valueListenable: dynamicHeightForBar,
                builder: (context, dynamicHeightForBarValue, _) {
                  return Align(
                    alignment: const Alignment(-0.74, 0.75),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7 +
                          dynamicHeightForBarValue,
                      width: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColor.blueColor.withOpacity(0.25),
                            AppColor.blueColor.withOpacity(0.0)
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            CustomScrollView(
              controller: scrollController,
              slivers: [
                const SliverToBoxAdapter(
                  child: SizedBox(height: 40),
                ),
                SliverToBoxAdapter(
                  child: Text(
                    'My History',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.bold18.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 8),
                ),
                SliverAnimatedList(
                  key: verticalListKey,
                  itemBuilder: (context, index, animation) =>
                      verticalListWidget(animation, verticalList[index]),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 40),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
