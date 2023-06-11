import 'dart:convert';

import 'package:even_assignment/src/model/doctor/doctor.dart';
import 'package:even_assignment/src/model/dummy/dummy.dart';
import 'package:even_assignment/src/model/hospital/hospital.dart';
import 'package:even_assignment/src/utility/utility.dart';
import 'package:even_assignment/src/view/home/components/hospital_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.selectedPageIndex, super.key});

  final int selectedPageIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GlobalKey<SliverAnimatedListState> verticalListKey;
  late List<Widget> verticalList;

  @override
  void initState() {
    super.initState();

    verticalListKey = GlobalKey<SliverAnimatedListState>();
    verticalList = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 1000)).whenComplete(() {
        if (widget.selectedPageIndex == 0) {
          try {
            insertAllitems();
          } catch (e) {
            //
          }
        }
      });
    });
  }

  @override
  void didUpdateWidget(HomeScreen oldWidget) {
    if (oldWidget.selectedPageIndex != widget.selectedPageIndex) {
      if (widget.selectedPageIndex == 0 && oldWidget.selectedPageIndex != 0) {
        insertAllitems();
      } else if (oldWidget.selectedPageIndex == 0 &&
          widget.selectedPageIndex != 0) {
        removeAllitems();
      }
      super.didUpdateWidget(widget);
    } else {
      super.didUpdateWidget(oldWidget);
    }
  }

  Future<void> removeAllitems() async {
    try {
      for (var element in verticalList.reversed) {
        if (verticalListKey.currentState == null) {
          break;
        }
        verticalListKey.currentState!.removeItem(
          verticalList.indexOf(element),
          (context, animation) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-0.5, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
            ),
            child: element,
          ),
        );
        // await Future.delayed(const Duration(milliseconds: 50));
      }
    } catch (e) {
      //
    }
  }

  Future<void> insertAllitems() async {
    await Future.delayed(const Duration(milliseconds: 50));
    try {
      for (var element in verticalList) {
        if (verticalListKey.currentState == null) {
          break;
        }
        verticalListKey.currentState!.insertItem(verticalList.indexOf(element));
        await Future.delayed(const Duration(milliseconds: 100));
      }
    } catch (e) {
      //
    }
  }

  final List<Hospital> hospitals = List<Hospital>.from(
      (json.decode(hospitalDummy) as List<dynamic>)
          .map((value) => Hospital.fromModal(value)));

  final List<Doctor> doctors = List<Doctor>.from(
    (json.decode(doctorDummy) as List<dynamic>).map(
      (value) => Doctor.fromModal(value),
    ),
  );

  Widget _customTransition(int index, Animation<double> animation) {
    late final Animation<Offset> tween;

    // index 3 is sliver horizontal list
    if (index == 3) {
      tween = Tween<Offset>(
        begin: const Offset(-0.50, 0),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeIn,
          reverseCurve: Curves.easeOutExpo,
        ),
      );
    } else {
      tween = Tween<Offset>(
        begin: const Offset(-0.25, 0),
        end: const Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.fastOutSlowIn,
        ),
      );
    }
    return SlideTransition(
      position: tween,
      child: verticalList[index],
    );
  }

  @override
  Widget build(BuildContext context) {
    verticalList = [
      Container(
        key: UniqueKey(),
        margin: const EdgeInsets.only(bottom: 54),
        height: 411,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 21, bottom: 16),
              child: const Text(
                'Hospital near you',
                style: AppTextStyle.bold14,
              ),
            ),
            Expanded(
              child: CustomScrollView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                slivers: [
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      width: 22,
                    ),
                  ),
                  SliverList.builder(
                    itemBuilder: (context, index) =>
                        HospitalCard(hospital: hospitals[index]),
                    itemCount: hospitals.length,
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width + 22,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        key: UniqueKey(),
        padding: const EdgeInsets.only(left: 21),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: 0.485,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your medical concierge',
                style: AppTextStyle.bold14,
              ),
              const Divider(
                indent: 6,
                endIndent: 24,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(doctors[0].profile!),
                ),
                title: Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: doctors[0].name?.firstName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                      text: doctors[0].name?.lastName,
                    ),
                  ]),
                  style: AppTextStyle.regular14,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox.square(
                      dimension: 40,
                      child: Image.asset(
                        AppImageAsset.whatsappIcon,
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox.square(
                      dimension: 40,
                      child: Image.asset(AppImageAsset.phoneIcon),
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 6,
                endIndent: 24,
              ),
            ],
          ),
        ),
      ),
    ];

    return SafeArea(
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
              child: SizedBox(height: kToolbarHeight),
            ),
            SliverAnimatedList(
              key: verticalListKey,
              itemBuilder: (context, index, animation) {
                return _customTransition(index, animation);
              },
            ),
          ],
        ),
      ),
    );
  }
}
