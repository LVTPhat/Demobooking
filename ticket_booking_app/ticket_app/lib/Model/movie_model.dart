
class MovieModel {
  String? id;
  String? title;
  String? description;
  String? imageasset;
  String? imagebanner;
  int? favourite;
  String? author;
  String? category;
  String? acter;
  MovieModel.init();
  MovieModel({
     this.title,
     this.description,
     this.id,
     this.acter,
     this.author,
     this.category,
     this.favourite,
     this.imageasset,
     this.imagebanner,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json){
    return MovieModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      author: json['author'],
      acter: json['acter'],
      category: json['category'],
      favourite: json['favourite'],
      imageasset: json['imageasset'],
      imagebanner: json['imagebanner'],
    );
  }
  static List<MovieModel> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((json) => MovieModel.fromJson(json)).toList();
  }

}