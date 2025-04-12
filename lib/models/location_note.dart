class LocationNote {
  String name;
  String description;
  String? imagePath;

  LocationNote({required this.name, required this.description, this.imagePath});

  Map<String, dynamic> toMap() => {
    'name': name,
    'description': description,
    'imagePath': imagePath,
  };

  static LocationNote fromMap(Map<String, dynamic> map) => LocationNote(
    name: map['name'],
    description: map['description'],
    imagePath: map['imagePath'],
  );
}
