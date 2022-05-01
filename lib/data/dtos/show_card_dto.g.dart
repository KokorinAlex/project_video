// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowCardDTO _$ShowCardDTOFromJson(Map<String, dynamic> json) => ShowCardDTO(
      show: json['show'] == null
          ? null
          : ShowCardDataDTO.fromJson(json['show'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowCardDTOToJson(ShowCardDTO instance) =>
    <String, dynamic>{
      'show': instance.show,
    };

ShowCardDataDTO _$ShowCardDataDTOFromJson(Map<String, dynamic> json) =>
    ShowCardDataDTO(
      id: json['id'] as int? ?? 0,
      title: json['name'] as String? ?? '',
      picture: json['image'] == null
          ? null
          : ShowCardDataImageDTO.fromJson(
              json['image'] as Map<String, dynamic>),
      releaseDate: json['premiered'] as String?,
      description: json['summary'] as String?,
      voteAverage: json['rating'] == null
          ? null
          : ShowCardDataAverageDTO.fromJson(
              json['rating'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ShowCardDataDTOToJson(ShowCardDataDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.title,
      'image': instance.picture,
      'premiered': instance.releaseDate,
      'summary': instance.description,
      'rating': instance.voteAverage,
    };

ShowCardDataImageDTO _$ShowCardDataImageDTOFromJson(
        Map<String, dynamic> json) =>
    ShowCardDataImageDTO(
      original: json['original'] as String? ?? '',
    );

Map<String, dynamic> _$ShowCardDataImageDTOToJson(
        ShowCardDataImageDTO instance) =>
    <String, dynamic>{
      'original': instance.original,
    };

ShowCardDataAverageDTO _$ShowCardDataAverageDTOFromJson(
        Map<String, dynamic> json) =>
    ShowCardDataAverageDTO(
      average: (json['average'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ShowCardDataAverageDTOToJson(
        ShowCardDataAverageDTO instance) =>
    <String, dynamic>{
      'average': instance.average,
    };
