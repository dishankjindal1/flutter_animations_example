import 'package:flutter/material.dart';

class HistoryCardModule extends StatefulWidget {
  const HistoryCardModule({super.key});

  @override
  State<HistoryCardModule> createState() => _HistoryCardModuleState();
}

class _HistoryCardModuleState extends State<HistoryCardModule>
    with SingleTickerProviderStateMixin, RouteAware {
  @override
  Widget build(BuildContext context) {
    return Container(
      transformAlignment: Alignment.center,
      constraints: const BoxConstraints(
        minHeight: 50.0,
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
              height: 50.0 + 50.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
              ),
              
            ),
          ),
        ],
      ),
    );
  }
}
