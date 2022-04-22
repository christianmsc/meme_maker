class MemeModel {
  int? id;
  String image;
  String upperText;
  String bottomText;

  MemeModel(this.id, this.image, this.upperText, this.bottomText);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'upperText': upperText,
      'bottomText': bottomText,
    };
  }

  String toUrl() {
    return 'meme?meme=' +
        image +
        '&top=' +
        upperText.replaceAll(' ', '+') +
        '&bottom=' +
        bottomText.replaceAll(' ', '+');
  }

  @override
  String toString() {
    return 'MemeModel{id: $id, image: $image, upperText: $upperText, bottomText: $bottomText}';
  }
}
