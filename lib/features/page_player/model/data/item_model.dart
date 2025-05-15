import 'package:equatable/equatable.dart';
import 'text_style_model.dart'; // Import TextStyleModel

class ItemModel extends Equatable {
  final String itemId;
  final String type;
  final dynamic
  content; // Can be String (text), Map (image), or empty Map (shape)
  final TextStyleModel? textStyle;
  final LayoutModel layout;
  final StyleModel style;
  final AnimationsModel? animations;

  const ItemModel({
    required this.itemId,
    required this.type,
    this.content,
    this.textStyle,
    required this.layout,
    required this.style,
    this.animations,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      itemId: json['itemId'] as String,
      type: json['type'] as String,
      content: json['content'], // Content can be various types
      textStyle:
          json['textStyle'] != null
              ? TextStyleModel.fromJson(
                json['textStyle'] as Map<String, dynamic>,
              )
              : null,
      layout: LayoutModel.fromJson(json['layout'] as Map<String, dynamic>),
      style: StyleModel.fromJson(json['style'] as Map<String, dynamic>),
      animations:
          json['animations'] != null
              ? AnimationsModel.fromJson(
                json['animations'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  @override
  List<Object?> get props => [
    itemId,
    type,
    content,
    textStyle,
    layout,
    style,
    animations,
  ];
}

class LayoutModel extends Equatable {
  final PositionModel position;
  final double angle;
  final SizeModel size;

  const LayoutModel({
    required this.position,
    required this.angle,
    required this.size,
  });

  factory LayoutModel.fromJson(Map<String, dynamic> json) {
    return LayoutModel(
      position: PositionModel.fromJson(
        json['position'] as Map<String, dynamic>,
      ),
      angle: (json['angle'] as num).toDouble(),
      size: SizeModel.fromJson(json['size'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [position, angle, size];
}

class PositionModel extends Equatable {
  final String axisYAlignmentType;
  final String axisXAlignmentType;
  final double xPosition;
  final double yPosition;

  const PositionModel({
    required this.axisYAlignmentType,
    required this.axisXAlignmentType,
    required this.xPosition,
    required this.yPosition,
  });

  factory PositionModel.fromJson(Map<String, dynamic> json) {
    return PositionModel(
      axisYAlignmentType: json['axisYAlignmentType'] as String,
      axisXAlignmentType: json['axisXAlignmentType'] as String,
      xPosition: (json['xPosition'] as num).toDouble(),
      yPosition: (json['yPosition'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [
    axisYAlignmentType,
    axisXAlignmentType,
    xPosition,
    yPosition,
  ];
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

class StyleModel extends Equatable {
  final double opacity;
  final FillModel fill;
  final StrokeModel stroke;
  final ShadowModel shadow;
  final BlurModel blur;

  const StyleModel({
    required this.opacity,
    required this.fill,
    required this.stroke,
    required this.shadow,
    required this.blur,
  });

  factory StyleModel.fromJson(Map<String, dynamic> json) {
    return StyleModel(
      opacity: (json['opacity'] as num).toDouble(),
      fill: FillModel.fromJson(json['fill'] as Map<String, dynamic>),
      stroke: StrokeModel.fromJson(json['stroke'] as Map<String, dynamic>),
      shadow: ShadowModel.fromJson(json['shadow'] as Map<String, dynamic>),
      blur: BlurModel.fromJson(json['blur'] as Map<String, dynamic>),
    );
  }

  @override
  List<Object?> get props => [opacity, fill, stroke, shadow, blur];
}

class FillModel extends Equatable {
  final bool isFill;
  final String color;

  const FillModel({required this.isFill, required this.color});

  factory FillModel.fromJson(Map<String, dynamic> json) {
    return FillModel(
      isFill: json['isFill'] as bool,
      color: json['color'] as String,
    );
  }

  @override
  List<Object?> get props => [isFill, color];
}

class StrokeModel extends Equatable {
  final bool hasStroke;
  final double weight;
  final String color;

  const StrokeModel({
    required this.hasStroke,
    required this.weight,
    required this.color,
  });

  factory StrokeModel.fromJson(Map<String, dynamic> json) {
    return StrokeModel(
      hasStroke: json['hasStroke'] as bool,
      weight: (json['weight'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  @override
  List<Object?> get props => [hasStroke, weight, color];
}

class ShadowModel extends Equatable {
  final bool hasShadow;
  final OffsetModel offset;
  final double blur;
  final double opacity;
  final String color;

  const ShadowModel({
    required this.hasShadow,
    required this.offset,
    required this.blur,
    required this.opacity,
    required this.color,
  });

  factory ShadowModel.fromJson(Map<String, dynamic> json) {
    return ShadowModel(
      hasShadow: json['hasShadow'] as bool,
      offset: OffsetModel.fromJson(json['offset'] as Map<String, dynamic>),
      blur: (json['blur'] as num).toDouble(),
      opacity: (json['opacity'] as num).toDouble(),
      color: json['color'] as String,
    );
  }

  @override
  List<Object?> get props => [hasShadow, offset, blur, opacity, color];
}

class OffsetModel extends Equatable {
  final double x;
  final double y;

  const OffsetModel({required this.x, required this.y});

  factory OffsetModel.fromJson(Map<String, dynamic> json) {
    return OffsetModel(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [x, y];
}

class BlurModel extends Equatable {
  final bool hasBlur;
  final double value;

  const BlurModel({required this.hasBlur, required this.value});

  factory BlurModel.fromJson(Map<String, dynamic> json) {
    return BlurModel(
      hasBlur: json['hasBlur'] as bool,
      value: (json['value'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [hasBlur, value];
}

class AnimationsModel extends Equatable {
  final AnimationDetailModel? appear;
  final AnimationDetailModel? dismiss;

  const AnimationsModel({this.appear, this.dismiss});

  factory AnimationsModel.fromJson(Map<String, dynamic> json) {
    return AnimationsModel(
      appear:
          json['appear'] != null
              ? AnimationDetailModel.fromJson(
                json['appear'] as Map<String, dynamic>,
              )
              : null,
      dismiss:
          json['dismiss'] != null
              ? AnimationDetailModel.fromJson(
                json['dismiss'] as Map<String, dynamic>,
              )
              : null,
    );
  }

  @override
  List<Object?> get props => [appear, dismiss];
}

class AnimationDetailModel extends Equatable {
  final String category;
  final String type;
  final int delay;
  final String id;
  final String? eas; // Easing function
  final String? direction;
  final TimesheetModel timesheet;

  const AnimationDetailModel({
    required this.category,
    required this.type,
    required this.delay,
    required this.id,
    this.eas,
    this.direction,
    required this.timesheet,
  });

  factory AnimationDetailModel.fromJson(Map<String, dynamic> json) {
    return AnimationDetailModel(
      category: json['category'] as String,
      type: json['type'] as String,
      delay: json['delay'] as int,
      id: json['id'] as String,
      eas: json['eas'] as String?,
      direction: json['direction'] as String?,
      timesheet: TimesheetModel.fromJson(
        json['timesheet'] as Map<String, dynamic>,
      ),
    );
  }

  @override
  List<Object?> get props => [
    category,
    type,
    delay,
    id,
    eas,
    direction,
    timesheet,
  ];
}

class TimesheetModel extends Equatable {
  final int start;
  final int duration;

  const TimesheetModel({required this.start, required this.duration});

  factory TimesheetModel.fromJson(Map<String, dynamic> json) {
    return TimesheetModel(
      start: json['start'] as int,
      duration: json['duration'] as int,
    );
  }

  @override
  List<Object?> get props => [start, duration];
}

// Specific content models if needed, e.g., for image
class ImageContentModel extends Equatable {
  final String src;
  final double aspectRatio;

  const ImageContentModel({required this.src, required this.aspectRatio});

  factory ImageContentModel.fromJson(Map<String, dynamic> json) {
    return ImageContentModel(
      src: json['src'] as String,
      aspectRatio: (json['aspectRatio'] as num).toDouble(),
    );
  }

  @override
  List<Object?> get props => [src, aspectRatio];
}
