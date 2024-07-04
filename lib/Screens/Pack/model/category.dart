class Category {
  final String name;
  final String level;
  final String image;

  Category(this.name, this.level, this.image);

  String operator [](String key) {
    switch (key) {
      case 'name':
        return name;
      case 'level':
        return level;
      case 'image':
        return image;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}

List<Category> categories = categoriesData
    .map((item) => Category(item['name'].toString(), item['level'].toString(),
        item['image'].toString()))
    .toList();

var categoriesData = [
  {
    "name": "Math",
    "level": "Classes Preparatoires",
    'image': "assets/images/math.png"
  },
  {
    "name": "SVT",
    "level": "Bac Sciences",
    'image': "assets/images/biology.png"
  },
  {
    "name": "Physique",
    "level": "3eme Maths",
    'image': "assets/images/physics.png"
  },
  {
    "name": "Chimie",
    "level": "Bac Techniques",
    'image': "assets/images/chemistry.png"
  },
];
