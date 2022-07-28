class ImageModal {
  String id;
  String title;
  String imgURL;

  ImageModal({this.id = "x", required this.title, required this.imgURL});

// JSON to Image object mapping
  static ImageModal fromjson(Map<String, dynamic> json) => ImageModal(
        id: json['id'] as String,
        title: json['title'] as String,
        imgURL: json['imageUrl'] as String,
      );
}
