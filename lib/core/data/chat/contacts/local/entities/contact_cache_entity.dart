import 'package:objectbox/objectbox.dart';

@Entity()
class ContactCacheEntity {
  @Id()
  int profileId;

  bool isCameraAllowed;

  String type;

  int? chatSessionId;

  @Property(type: PropertyType.date)
  DateTime? chatCreatedAt;

  @Property(type: PropertyType.date)
  DateTime? chatManLastActiveAt;

  int? chatUnreadCnt;

  @Property(type: PropertyType.date)
  DateTime? lastMessageTime;

  String? lastMessageText;

  String chatSessionStatus;

  bool isVideostreamViewing;

  bool isVideostreamContactViewing;

  ContactCacheEntity({
    required this.profileId,
    required this.isCameraAllowed,
    required this.type,
    required this.chatSessionId,
    required this.chatCreatedAt,
    required this.chatManLastActiveAt,
    required this.chatUnreadCnt,
    required this.lastMessageTime,
    required this.lastMessageText,
    required this.chatSessionStatus,
    required this.isVideostreamViewing,
    required this.isVideostreamContactViewing,
  });
}
