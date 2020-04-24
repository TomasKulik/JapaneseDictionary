class Translation {
  int id;
  String word;
  String reading;
  List<dynamic> english = [];

  Translation({this.word, this.reading, this.english});
  Translation.withId({this.id, this.word, this.reading, this.english});

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      word: json['japanese'][0]['word'] as String,
      reading: json['japanese'][0]['reading'] as String,
      english: json['senses'][0]['english_definitions'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['word'] = word;
    map['reading'] = reading;
    // map['english'] = english;

    return map;
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation.withId(
      id: map['id'],
      word: map['word'],
      reading: map['reading'],
      // english: map['english'],
    );
  }
}
