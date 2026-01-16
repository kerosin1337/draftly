class ImageModel {
  final String id;

  final String fileName;
  final String image;
  final String userId;
  final String userName;

  const ImageModel({
    required this.id,
    required this.fileName,
    required this.image,
    required this.userId,
    required this.userName,
  });

  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      id: map['id'],
      fileName: map['fileName'],
      image: map['image'],
      userId: map['userId'],
      userName: map['userName'],
    );
  }
}
