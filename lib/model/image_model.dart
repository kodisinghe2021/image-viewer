class ImageModal {
  String id;
  String title;
  String imgURL;
  String imgDestination;
  ImageModal(
      {required this.id,
      required this.title,
      required this.imgURL,
      required this.imgDestination});

// JSON to Image object mapping
  static ImageModal fromjson(Map<String, dynamic> json) => ImageModal(
        id: json['id'] as String,
        title: json['title'] as String,
        imgURL: json['imageUrl'] as String,
        imgDestination: json['imgDestination'] as String,
      );
}
