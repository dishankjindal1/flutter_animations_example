import 'dart:math' as math;

import 'package:even_assignment/src/model/model.dart';
import 'package:even_assignment/src/utility/utility.dart';
import 'package:flutter/material.dart';

class HospitalCard extends StatelessWidget {
  const HospitalCard({
    super.key,
    required this.hospital,
  });

  final Hospital hospital;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: IntrinsicWidth(
        child: Stack(
          children: [
            AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.network(
                hospital.image!.first,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(left: 16, top: 16),
                  height: 25,
                  child: Image.network(
                    hospital.logo!,
                  ),
                ),
                const Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.25, 1.0],
                      colors: [
                        Colors.black,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospital.name!,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bold18.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hospital.address!,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.regular12.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColor.yellowColor,
                                borderRadius: BorderRadius.circular(4)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 6),
                            child: Text(
                              '${math.Random().nextInt(100) / 10} km',
                              style: AppTextStyle.regular12.copyWith(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
