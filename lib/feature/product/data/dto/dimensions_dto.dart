

class DimensionsDto{
  const DimensionsDto({
    required this.width,
    required this.height,
    required this.depth,
  });

  final double width;
  final double height;
  final double depth;

  factory DimensionsDto.fromJson(Map<String, dynamic> json) => DimensionsDto(
    width: (json['width'] as num).toDouble(),
    height: (json['height'] as num).toDouble(),
    depth: (json['depth'] as num).toDouble(),
  );

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'depth': depth,
  };
}
