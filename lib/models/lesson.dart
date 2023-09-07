// ignore_for_file: unused_element

class Lesson {
  String name;
  String imgPath;
  String rating;
  String description;

  Lesson(
      {required this.name,
      required this.imgPath,
      required this.rating,
      required this.description});
  String get _name => name;
  String get _imgPath => imgPath;
  String get _rating => rating;
  String get _description => description;
}
