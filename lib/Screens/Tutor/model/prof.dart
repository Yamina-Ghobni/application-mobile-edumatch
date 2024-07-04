class Professor {
  final String name;
  final String field;
  final String image;

  Professor(this.name, this.field, this.image);

  String operator [](String key) {
    switch (key) {
      case 'name':
        return name;
      case 'field':
        return field;
      case 'image':
        return image;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}

class Tutor {
  final String email;
  final String name;
  final String field;
  final String institute;
  final String num;
  final String role;

  Tutor(this.email, this.name, this.field, this.institute, this.num, this.role );

  String operator [](String key) {
    switch (key) {
      case 'email':
        return email;
      case 'name':
        return name;
      case 'field':
        return field;
      case 'institute':
        return institute;
      case 'num':
        return num;
      case 'role':
        return role;
      default:
        throw ArgumentError('Invalid key: $key');
    }
  }
}

List<Professor> professors = professorsData
    .map((item) => Professor(item['name'].toString(), item['field'].toString() , item['image'].toString()))
    .toList();

var professorsData = [
  {"name": "Prof1", "field" : "Math", 'image': "assets/images/p1.png"},
  {"name": "Prof2", "field" : "Sciences", 'image': "assets/images/p2.png"},
  {
    "name": "Prof3",
    "field" : "Physique",
    'image': "assets/images/p3.png"
  },
  {"name": "Prof4", "field" : "Techniques", 'image': "assets/images/p4.png"},
];
