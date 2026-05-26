import '../../dto/chat_info_dto.dart';
import '../../dto/contact_dto.dart';
import '../../dto/profile_dto.dart';
import '../../dto/video_stream_info_dto.dart';
import '../entities/contact_cache_entity.dart';

extension XContactCacheEntity on ContactCacheEntity {
  ContactDto fromCacheEntity() => ContactDto(
    type: type,
    profile: ProfileDto(
      id: profileId,
      isCameraAllowed: isCameraAllowed,
    ),
    chatInfo: ChatInfoDto(
      id: chatSessionId,
      time: chatCreatedAt,
      status: chatSessionStatus,
      unreadCount: chatUnreadCnt ?? 0,
      lastMessageTime: chatManLastActiveAt,
      lastMessageText: null,
    ),
    videoStreamInfo: VideoStreamInfoDto(
      isViewing: isVideostreamViewing,
      isContactViewing: isVideostreamContactViewing,
    ),
  );
}

extension XContactDto on ContactDto {
  ContactCacheEntity toCacheEntity() => ContactCacheEntity(
    profileId: profile.id,
    isCameraAllowed: profile.isCameraAllowed,
    type: type ?? 'temporary',
    chatSessionId: chatInfo.id,
    chatCreatedAt: chatInfo.time,
    chatSessionStatus: chatInfo.status ?? 'closed',
    chatUnreadCnt: chatInfo.unreadCount,
    chatManLastActiveAt: chatInfo.lastMessageTime,
    lastMessageTime: chatInfo.lastMessageTime,
    lastMessageText: chatInfo.lastMessageText,
    isVideostreamViewing: videoStreamInfo.isViewing,
    isVideostreamContactViewing: videoStreamInfo.isContactViewing,
  );
}