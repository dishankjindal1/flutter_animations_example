import 'dart:async';
import 'dart:math';

import 'package:even_assignment/src/view/history/components/history_card.dart';
import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({required this.isSelected, super.key});

  final bool isSelected;
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin, RouteAware {
  late final GlobalKey<SliverAnimatedListState> listKey;
  late final List<Widget> historyList;

  late final AnimationController animation;

  late final Animation<double> plusWidget;


  @override
  void didUpdateWidget(HistoryScreen oldWidget) {
    if (widget.isSelected != oldWidget.isSelected) {
      _reverseAll();
      super.didUpdateWidget(widget);
    } else {
      super.didUpdateWidget(oldWidget);
    }
  }

  Future<void> _reverseAll() async {
    animation.reverse();
    for (var i = historyList.length - 1; i >= 0; i--) {
      listKey.currentState!.removeItem(
        i,
        (context, animation) {
          return TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 50),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeIn,
            builder: (context, value, _) {
              return Transform.translate(
                offset: Offset(value, 0),
                child: historyList[i],
              );
            },
          );
        },
        duration: const Duration(seconds: 1),
      );
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))..forward();

    plusWidget = Tween<double>(begin: -100, end: 0).animate(CurvedAnimation(parent: animation, curve: Curves.easeIn));

    listKey = GlobalKey<SliverAnimatedListState>();
    historyList = List.empty(growable: true);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (timer.tick > 2 || !mounted) {
          timer.cancel();
        }
        if (mounted) {
          setState(() {
            listKey.currentState!.insertItem(
              historyList.length,
              duration: const Duration(milliseconds: 0),
            );

            historyList.add(const HistoryCardModule());
          });
        }
      });
    });
  }

  @override
  void dispose() {
    animation.dispose();
    historyList.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFC4C4C4),
      child: SafeArea(
        child: CustomScrollView(slivers: [
          const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'My History',
                  style: TextStyle(
                    fontSize: 32,
                  ),
                )
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedBuilder(
                      animation: animation,
                        builder: (context, _) {
                          return Transform.translate(
                            offset: Offset(0, plusWidget.value),
                            child: Center(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                    const Color(0xFF0055FF).withOpacity(0.25),
                                child: const CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Color(0xFF0055FF),
                                  child: Center(
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Colors.white,
                                      size: 42,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                      child: Text(
                    'Add consultation',
                    style: TextStyle(
                      color: Color(0xFF0055FF),
                    ),
                  )),
                ],
              ),
            ),
          ),
          SliverAnimatedList(
            key: listKey,
            itemBuilder: (context, index, animation) {
              return TweenAnimationBuilder(
                tween: Tween<double>(begin: 50, end: 0),
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeIn,
                builder: (context, value, _) {
                  return Transform.translate(
                    offset: Offset(value, 0),
                    child: historyList[index],
                  );
                },
              );
            },
            initialItemCount: 0,
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
        ]),
      ),
    );
  }
}


class HistoryCardAddButton extends StatefulWidget {
  const HistoryCardAddButton({super.key});

  @override
  State<HistoryCardAddButton> createState() => _HistoryCardAddButtonState();
}

class _HistoryCardAddButtonState extends State<HistoryCardAddButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animation;

  late final Animation<Offset> animatedSlide;
  late final Animation<double> animatedOpacity;

  bool isBottomCard = Random().nextBool();

  double isRandomHeight = Random().nextInt(100).toDouble();

  @override
  void initState() {
    super.initState();

    animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400))
      ..forward();

    animatedSlide =
        Tween<Offset>(begin: const Offset(0.0, 50.0), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(
          0,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );

    animatedOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animation,
        curve: const Interval(
          0.25,
          1,
          curve: Curves.easeIn,
        ),
      ),
    );
  }

  @override
  void dispose() {
    animation.stop();
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          return SliverToBoxAdapter(
            child: Transform.translate(
              offset: animatedSlide.value,
              child: Opacity(
                opacity: animatedOpacity.value,
                child: Container(
                  transformAlignment: Alignment.center,
                  constraints: const BoxConstraints(
                    minHeight: 200.0,
                    maxHeight: 300.0,
                    minWidth: double.infinity,
                  ),
                  color: const Color(0xFFC4C4C4),
                  padding: const EdgeInsets.symmetric(horizontal: 20).add(
                    const EdgeInsets.only(bottom: 20),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('DD-MM-YYYY'),
                            SizedBox(height: 8),
                            Text('Today'),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        flex: 5,
                        child: Container(
                          height: 200.0 + isRandomHeight,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const Spacer(),
                              if (isBottomCard)
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: 50,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.vertical(
                                        bottom: Radius.circular(20),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
