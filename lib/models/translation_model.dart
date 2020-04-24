class Translation {
  String word;
  String reading;
  List<dynamic> english = [];

  Translation({this.word, this.reading, this.english});

  factory Translation.fromJson(Map<String, dynamic> json) {
    return Translation(
      word: json['japanese'][0]['word'] as String,
      reading: json['japanese'][0]['reading'] as String,
      english: json['senses'][0]['english_definitions'] as List<dynamic>,
    );
  }
}
