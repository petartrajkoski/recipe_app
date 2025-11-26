class Category {
  final String id;
  final String name;
  final String thumbnail;
  final String desc;

  Category({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.desc,
  });

  factory Category.fromJson(Map<String, dynamic> json){
    return Category(
      id: json['idCategory']?.toString() ?? '',
      name: json['strCategory']?.toString() ?? '',
      thumbnail: json['strCategoryThumb']?.toString() ?? '',
      desc: json['strCategoryDescription']?.toString() ?? '',
    );
  }
}