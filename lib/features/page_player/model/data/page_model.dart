import 'package:equatable/equatable.dart';
import 'item_model.dart'; // Assuming ItemModel will be in the same directory

class PageModel extends Equatable {
  final String screenId;
  final BackgroundModel background;
  final ConstraintsModel constraints;
  final List<ItemModel> items;

  const PageModel({
    required this.screenId,
    required this.background,
    required this.constraints,
    required this.items,
  });

  factory PageModel.fromJson(Map<String, dynamic> json) {
    return PageModel(
      screenId: json['screenId'] as String,
      background: BackgroundModel.fromJson(json['background'] as Map<String, dynamic>),
      constraints: ConstraintsModel.fromJson(json['constraints'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>)
          .map((itemJson) => ItemModel.fromJson(itemJson as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [screenId, background, constraints, items];
}

// Placeholder models - will be defined in separate files
class BackgroundModel extends Equatable {
  final String color;
  final String? image;

  const BackgroundModel({required this.color, this.image});

  factory BackgroundModel.fromJson(Map<String, dynamic> json) {
    return BackgroundModel(
      color: json['color'] as String,
      image: json['image'] as String?,
    );
  }

  @override
  List<Object?> get props => [color, image];
}

class ConstraintsModel extends Equatable {
  final String format;
  final SizeModel size;

  const ConstraintsModel({required this.format, required this.size});

  factory ConstraintsModel.fromJson(Map<String, dynamic> json) {
    return ConstraintsModel(
      format: json['format'] as String,
      size: SizeModel.fromJson(json['size'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [format, size];
}

class SizeModel extends Equatable {
  final double width;
  final double height;

  const SizeModel({required this.width, required this.height});

  factory SizeModel.fromJson(Map<String, dynamic> json) {
    return SizeModel(
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [width, height];
}