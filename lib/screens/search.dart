import 'package:flutter/material.dart';
import 'package:travel_go/widgets/gradient_text.dart';
import 'package:travel_go/widgets/gradient_text_field.dart';
import 'package:travel_go/widgets/place_details.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() {
    return _SearchScreensState();
  }
}

class _SearchScreensState extends State<SearchScreen> {
  final _textFieldController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  Widget content = const Center(
    child: AnimatedGradientText(
      text: 'Nothing to see here...',
      startColor: Color.fromARGB(255, 120, 216, 223),
      endColor: Color.fromARGB(255, 147, 248, 255),
      duration: Duration(milliseconds: 400),
      delay: 1000,
    ),
  );

  void _searchPlace() {
    _focusNode.unfocus();
    final queryPlace = _textFieldController.text.trim();
    if (queryPlace.isEmpty) {
      return;
    }
    setState(() {
      content = PlaceDetails(queryPlace: queryPlace);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GradientTextField(
          textFieldController: _textFieldController,
          focusNode: _focusNode,
          onSearch : _searchPlace,
        ),
        toolbarHeight: 40,
        actions: [
          IconButton(
            onPressed: _searchPlace,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: content,
    );
  }
}
