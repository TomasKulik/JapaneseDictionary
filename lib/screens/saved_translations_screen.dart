import 'package:flutter/material.dart';
import 'package:japanese_dictionary/helpers/database_helper.dart';
import 'package:japanese_dictionary/models/translation_model.dart';

class SavedTranslationsScreen extends StatefulWidget {
  @override
  _SavedTranslationsScreenState createState() =>
      _SavedTranslationsScreenState();
}

class _SavedTranslationsScreenState extends State<SavedTranslationsScreen> {
  Future<List<Translation>> _translationList;

  @override
  void initState() {
    super.initState();
    _translationList = DatabaseHelper.instance.getTranslationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved'),
      ),
      body: FutureBuilder(
        future: _translationList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final translation = snapshot.data[index];
              return ListTile(
                title: translation.word == null
                    ? Text(translation.reading)
                    : Text(
                        translation.word + '  (' + translation.reading + ')'),
                subtitle: Text(translation.english.toString()),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    translation.jlptLevel.contains('jlpt')
                        ? Text(
                            translation.jlptLevel,
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          )
                        : SizedBox.shrink(),
                    translation.isCommon.contains('true')
                        ? Text(
                            'Common',
                            style: TextStyle(color: Colors.green),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                onTap: () {
                  print(translation.id);
                  DatabaseHelper.instance.deleteTranslation(translation.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
