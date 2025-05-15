import 'package:equatable/equatable.dart';

class TextStyleModel extends Equatable {
  final String? fontFamily;
  final String? weight;
  final int? size;
  final String? alignment;
  final String? verticalAlignment;
  final String? autoResize;
  final double? lineHeight;
  final double? letterSpacing;
  final String? caseType; // Renamed from 'case' to avoid keyword conflict

  const TextStyleModel({
    this.fontFamily,
    this.weight,
    this.size,
    this.alignment,
    this.verticalAlignment,
    this.autoResize,
    this.lineHeight,
    this.letterSpacing,
    this.caseType,
  });

  factory TextStyleModel.fromJson(Map<String, dynamic> json) {
    return TextStyleModel(
      fontFamily: json['fontFamily'] as String?,
      weight: json['weight'] as String?,
      size: json['size'] as int?,
      alignment: json['alignment'] as String?,
      verticalAlignment: json['verticalAlignment'] as String?,
      autoResize: json['autoResize'] as String?,
      lineHeight: (json['lineHeight'] as num?)?.toDouble(),
      letterSpacing: (json['letterSpacing'] as num?)?.toDouble(),
      caseType: json['case'] as String?, // Use 'case' from JSON
    );
  }

  @override
  List<Object?> get props => [
        fontFamily,
        weight,
        size,
        alignment,
        verticalAlignment,
        autoResize,
        lineHeight,
        letterSpacing,
        caseType,
      ];
}