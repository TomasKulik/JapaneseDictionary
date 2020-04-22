import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;

  var words;

  _fetchData(String find) async {
    final url = 'https://jisho.org/api/v1/search/words?keyword=$find';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final wordsJson = map['data'];

      setState(() {
        words = wordsJson;
        _isLoading = false;
      });
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
                itemCount: words != null ? words.length : 0,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: words[index]['japanese'][0]['word'] == ''
                        ? Text(words[index]['japanese'][0]['word'])
                        : Text(words[index]['japanese'][0]['reading']),
                    subtitle: Text(words[index]['japanese'][0]['reading']),
                    trailing: Text(
                        words[index]['senses'][0]['english_definitions'][0]),
                  );
                },
              ),
      ),
    );
  }
}
