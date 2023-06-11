import 'package:even_assignment/src/utility/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTile extends StatefulWidget {
  const HistoryTile({
    super.key,
  });

  @override
  State<HistoryTile> createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  late final ValueNotifier<bool> editNotifier;

  @override
  void initState() {
    super.initState();
    editNotifier = ValueNotifier(false);
  }

  @override
  void dispose() {
    super.dispose();
    editNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> images = [
      ConsultationImageCard(editNotifier: editNotifier),
      ConsultationImageCard(editNotifier: editNotifier),
      ConsultationImageCard(editNotifier: editNotifier),
    ];

    return Container(
      alignment: Alignment.topCenter,
      constraints: const BoxConstraints(
        minHeight: 200.0,
        maxHeight: double.infinity,
        minWidth: double.infinity,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16).add(
        const EdgeInsets.only(bottom: 16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('hh:mm a').format(DateTime.now()),
                  style: AppTextStyle.regular12.copyWith(
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Today',
                  style: AppTextStyle.bold12.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 9,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IntrinsicWidth(
                                stepWidth: 8,
                                child: Stack(
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(0, 9),
                                      child: Container(
                                        height: 8,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                    Text(
                                      'Consultation'.toUpperCase(),
                                      style: AppTextStyle.regular12.copyWith(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Image.network(
                                'https://ik.imagekit.io/dishankjindal/amcare_logo.png',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Dr. Jordan Henderson',
                          style: AppTextStyle.bold14.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Aster RV - Multispeciality Hospital, JP Nagar, Bengaluru',
                          style: AppTextStyle.regular10.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            ...images
                                .map((e) => Row(
                                      children: [
                                        e,
                                        const SizedBox(width: 8),
                                      ],
                                    ))
                                .toList(),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.blueColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6, horizontal: 18),
                              child: Text(
                                'Upload Docs'.toUpperCase(),
                                style: AppTextStyle.bold10.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            ValueListenableBuilder<bool>(
                                valueListenable: editNotifier,
                                builder: (context, isEdit, child) {
                                  if (isEdit) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color:
                                            AppColor.redColor.withOpacity(0.24),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 18),
                                      child: Text(
                                        'Delete'.toUpperCase(),
                                        style: AppTextStyle.bold10.copyWith(
                                          color: AppColor.redColor,
                                        ),
                                      ),
                                    );
                                  }
                                  return const SizedBox();
                                }),
                          ],
                        ),
                        const SizedBox(height: 18),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F4F9),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ValueListenableBuilder<bool>(
                        valueListenable: editNotifier,
                        builder: (context, isEdit, _) {
                          if (isEdit) {
                            return Text(
                              'Please provide feedback for this session.',
                              style: AppTextStyle.regular12.copyWith(
                                color: Colors.black,
                              ),
                            );
                          }
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Feedback',
                                    style: AppTextStyle.bold10.copyWith(
                                      color: Colors.black,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      editNotifier.value = !editNotifier.value;
                                    },
                                    child: Text(
                                      'Edit',
                                      style: AppTextStyle.bold10.copyWith(
                                        color: AppColor.blueColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Every interaction with the hospital was great!',
                                style: AppTextStyle.regular12.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ConsultationImageCard extends StatelessWidget {
  const ConsultationImageCard({required this.editNotifier, super.key});

  final ValueNotifier<bool> editNotifier;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        editNotifier.value = !editNotifier.value;
      },
      child: ValueListenableBuilder<bool>(
          valueListenable: editNotifier,
          builder: (context, isEdit, _) {
            return SizedBox.square(
              dimension: 50,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        'https://ik.imagekit.io/dishankjindal/amcare_photo_1.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (isEdit)
                    Transform.translate(
                      offset: const Offset(6, -6),
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: AppColor.redColor,
                        child: Transform.translate(
                          offset: const Offset(0, -5),
                          child: const Icon(
                            Icons.minimize_rounded,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
