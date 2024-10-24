import 'package:flutter/material.dart';
import 'package:travel_go/widgets/gradient_text.dart';

class GradientTextField extends StatefulWidget {
  const GradientTextField({
    super.key,
    required this.textFieldController,
    required this.focusNode,
    required this.onSearch,
  });

  final TextEditingController textFieldController;
  final FocusNode focusNode;
  final void Function() onSearch;

  @override
  State<GradientTextField> createState() => _GradientTextFieldState();
}

class _GradientTextFieldState extends State<GradientTextField> {
  var labelText = 'Search ... ';

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
          width: 1.0,
        ),
      ),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.textFieldController,
        keyboardType: TextInputType.text,
        enableSuggestions: true,
        onTap: () {
          setState(() {
            labelText = '';
          });
        },
        onEditingComplete: () {
          setState(() {
            widget.textFieldController.text.trim().isEmpty
                ? labelText = 'Search ... '
                : '';
          });
          widget.onSearch();          
        },
        decoration: InputDecoration(
          label: AnimatedGradientText(
            text: labelText,
            startColor: Theme.of(context).colorScheme.secondary,
            endColor: Theme.of(context).colorScheme.onSurface ,
            duration: const Duration(milliseconds: 400),
            delay: 400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
        ),
      ),
    );
  }
}
