class Translation {
  int id;
  String word;
  String reading;
  String english;
  String isCommon;
  String jlptLevel;

  Translation({
    this.word,
    this.reading,
    this.english,
    this.isCommon,
    this.jlptLevel,
  });
  Translation.withId({
    this.id,
    this.word,
    this.reading,
    this.english,
    this.isCommon,
    this.jlptLevel,
  });

  factory Translation.fromJson(Map<String, dynamic> json) {
    print(json['is_common']);
    return Translation(
      word: json['japanese'][0]['word'] as String,
      reading: json['japanese'][0]['reading'] as String,
      english: json['senses'][0]['english_definitions'].toString(),
      isCommon: json['is_common'].toString(),
      jlptLevel: json['jlpt'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['word'] = word;
    map['reading'] = reading;
    map['english'] = english.toString();
    map['isCommon'] = isCommon;
    map['jlptLevel'] = jlptLevel.toString();

    return map;
  }

  factory Translation.fromMap(Map<String, dynamic> map) {
    return Translation.withId(
      id: map['id'],
      word: map['word'],
      reading: map['reading'],
      english: map['english'],
      isCommon: map['isCommon'],
      jlptLevel: map['jlptLevel'],
    );
  }
}
