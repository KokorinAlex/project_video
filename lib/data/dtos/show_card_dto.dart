import 'package:json_annotation/json_annotation.dart';

part 'show_card_dto.g.dart';

@JsonSerializable()
class ShowCardDTO {
  @JsonKey(name: 'show')
  final ShowCardDataDTO? show;

  ShowCardDTO({
    this.show,
  });

  factory ShowCardDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDTOFromJson(json);
}

@JsonSerializable()
class ShowCardDataDTO {
  @JsonKey(name: 'id', defaultValue: 0)
  final int id;

  @JsonKey(name: 'name', defaultValue: '')
  final String title;

  @JsonKey(name: 'image')
  final ShowCardDataImageDTO? picture;

  @JsonKey(name: 'premiered')
  final String? releaseDate;

  @JsonKey(name: 'summary')
  final String? description;

  ShowCardDataDTO({
    required this.id,
    required this.title,
    required this.picture,
    this.releaseDate,
    this.description,
  });

  factory ShowCardDataDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataDTOFromJson(json);
}

@JsonSerializable()
class ShowCardDataImageDTO {
  @JsonKey(name: 'original', defaultValue: '')
  final String? original;

  ShowCardDataImageDTO({
    this.original,
  });

  factory ShowCardDataImageDTO.fromJson(Map<String, dynamic> json) =>
      _$ShowCardDataImageDTOFromJson(json);
}
