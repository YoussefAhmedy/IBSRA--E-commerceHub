import '../entities/poster_entity.dart';

class PosterModel {
  final String id;
  final String title;
  final String size;
  final String frame;
  final double price;

  PosterModel({
    required this.id,
    required this.title,
    required this.size,
    required this.frame,
    required this.price,
  });

  factory PosterModel.fromEntity(PosterEntity poster) {
    return PosterModel(
      id: poster.id,
      title: poster.title,
      size: poster.size,
      frame: poster.frame,
      price: poster.price,
    );
  }

  PosterEntity toEntity() {
    return PosterEntity(
      id: id,
      title: title,
      size: size,
      frame: frame,
      price: price,
    );
  }
}
