import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../_converters/videostream_status2bool_converter.dart';

part 'video_stream_info_dto.freezed.dart';
part 'video_stream_info_dto.g.dart';

@freezed
abstract class VideoStreamInfoDto with _$VideoStreamInfoDto {
  const VideoStreamInfoDto._();

  const factory VideoStreamInfoDto({
    @VideoStreamStatusToBoolConverter() @JsonKey(name: 'view') required bool isViewing,
    @VideoStreamStatusToBoolConverter() @JsonKey(name: 'broadcast') required bool isContactViewing,
  }) = _VideoStreamInfoDto;

  factory VideoStreamInfoDto.fromJson(Map<String, dynamic> json) => _$VideoStreamInfoDtoFromJson(json);
}
