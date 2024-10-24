import 'package:flutter/material.dart';
import 'package:travel_go/widgets/gradient_text.dart';

class ItemsToPack extends StatelessWidget {
  const ItemsToPack({super.key, required this.itemsList});
  final List<dynamic> itemsList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AnimatedGradientText(
              text: "What To Pack ?",
              startColor: Color.fromARGB(255, 84, 210, 227),
              endColor: Color.fromARGB(255, 255, 47, 47),
              duration: Duration(milliseconds: 600),
              delay: 200),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: itemsList.map<Widget>((item) {
              return Chip(
                label: Text(item),
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
