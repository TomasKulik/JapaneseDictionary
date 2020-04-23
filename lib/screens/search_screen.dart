import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:japanese_dictionary/models/translation_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  List<Translation> _translations;

  _fetchData(String find) async {
    final url = 'https://jisho.org/api/v1/search/words?keyword=$find';
    _translations = [];

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> translationList = data['data'];

        translationList.forEach(
          (json) => _translations.add(Translation.fromJson(json)),
        );

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      throw (e);
    }
  }

  _clearSearch() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _searchController.clear());
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.0),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 30.0,
            ),
            hintText: 'Search',
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: Colors.black,
              ),
              onPressed: _clearSearch,
            ),
          ),
          onSubmitted: (input) {
            setState(() {
              _isLoading = true;
            });
            _fetchData(input);
          },
        ),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : ListView.builder(
                itemCount: _translations.length,
                itemBuilder: (BuildContext context, int index) {
                  final translation = _translations[index];
                  return ListTile(
                    title: translation.word == ''
                        ? Text(translation.word)
                        : Text(translation.reading),
                    subtitle: Text(translation.reading),
                    trailing: Text(translation.english),
                  );
                },
              ),
      ),
    );
  }
}
