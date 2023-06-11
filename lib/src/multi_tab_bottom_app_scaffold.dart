import 'package:even_assignment/src/utility/utility.dart';
import 'package:even_assignment/src/view/bottom_nav/bottom_nav_module.dart';
import 'package:even_assignment/src/view/history/history_screen.dart';
import 'package:even_assignment/src/view/home/home_screen.dart';
import 'package:flutter/material.dart';

class MultiTabBottomAppScaffold extends StatefulWidget {
  const MultiTabBottomAppScaffold({super.key});

  @override
  State<MultiTabBottomAppScaffold> createState() =>
      _MultiTabBottomAppScaffoldState();
}

class _MultiTabBottomAppScaffoldState extends State<MultiTabBottomAppScaffold>
    with SingleTickerProviderStateMixin {
  late bool isPageLoaded;

  late int selectedPageIndex;
  late final ScrollController scrollCtrl;

  late final AnimationController animation;

  @override
  void initState() {
    super.initState();
    animation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    isPageLoaded = false;
    selectedPageIndex = 0;
    scrollCtrl = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        Future.delayed(const Duration(milliseconds: 600), () {
          setState(() {
            isPageLoaded = true;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollCtrl.dispose();
    animation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColor.backgroundColor,
      child: SafeArea(
        top: false,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      /// long vertical line on history screen
                      AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          if (animation.value == 0) {
                            return const SizedBox();
                          }

                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: const Offset(0, 0.1),
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.ease,
                            )),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 1,
                                end: 0,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeIn,
                              )),
                              child: Align(
                                alignment: const Alignment(0, -0.7),
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Align(
                          alignment: const Alignment(-0.74, 0.7),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.7,
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
                        ),
                      ),
                      // add circle button
                      AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          if (animation.value == 0) {
                            return const SizedBox();
                          }
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: Offset.zero,
                              end: const Offset(0, -0.1),
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.ease,
                            )),
                            child: FadeTransition(
                              opacity: Tween<double>(
                                begin: 1,
                                end: 0,
                              ).animate(CurvedAnimation(
                                parent: animation,
                                curve: Curves.ease,
                              )),
                              child: child,
                            ),
                          );
                        },
                        child: Align(
                          alignment: const Alignment(-0.89, -0.673),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor:
                                AppColor.blueColor.withOpacity(0.25),
                            child: const CircleAvatar(
                              radius: 26,
                              backgroundColor: AppColor.blueColor,
                              child: Center(
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // add circle button with consultation text
                      AnimatedBuilder(
                        animation: animation,
                        builder: (context, child) {
                          if (animation.value == 0) {
                            return const SizedBox();
                          }
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 1,
                              end: 0,
                            ).animate(CurvedAnimation(
                              parent: animation,
                              curve: Curves.ease,
                            )),
                            child: Align(
                              alignment: const Alignment(-0.16, -0.62575),
                              child: child,
                            ),
                          );
                        },
                        child: Text(
                          'Add consultation',
                          style: AppTextStyle.bold14.copyWith(
                            color: AppColor.blueColor,
                          ),
                        ),
                      ),

                      SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: scrollCtrl,
                        scrollDirection: Axis.horizontal,
                        // shrinkWrap: true,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  AppConstant.deviceWidthFactorForNavBarPages,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HomeScreen(
                                  selectedPageIndex: selectedPageIndex,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  AppConstant.deviceWidthFactorForNavBarPages,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: HistoryScreen(
                                  selectedPageIndex: selectedPageIndex,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  AppConstant.deviceWidthFactorForNavBarPages,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('Mindfulness Page'),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  AppConstant.deviceWidthFactorForNavBarPages,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: const Align(
                                    alignment: Alignment.center,
                                    child: Text('Account Page'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(20),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: BottomNavigationModule(
                      selectedIndex: selectedPageIndex,
                      callback: (index) async {
                        if (index == 1) {
                          animation.reverse();
                        } else if (index == 0 || index == 2) {
                          animation.forward();
                        }
                        setState(() {
                          selectedPageIndex = index;
                        });
                        await Future.delayed(Duration.zero);
                        scrollCtrl.animateTo(
                          // ignore: use_build_context_synchronously
                          MediaQuery.of(context).size.width *
                              AppConstant.deviceWidthFactorForNavBarPages *
                              index,
                          duration: kTabScrollDuration,
                          curve: Curves.decelerate,
                        );
                      },
                    ),
                  ),
                ),
              ],
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
      ),
    );
  }
}
