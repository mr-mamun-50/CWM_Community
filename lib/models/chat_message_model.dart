import 'package:coding_with_mamun_community/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_message_model.freezed.dart';
part 'chat_message_model.g.dart';

@freezed
class ChatMessageEntityModel with _$ChatMessageEntityModel {
  factory ChatMessageEntityModel({
    required int id,
    @JsonKey(name: "chat_id") required int chatId,
    @JsonKey(name: "user_id") required int userId,
    required String message,
    @JsonKey(name: "created_at") required String createdAt,
    @JsonKey(name: "updated_at") required String updatedAt,
    required UserEntity user,
  }) = _ChatMessageEntityModel;

  factory ChatMessageEntityModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageEntityModelFromJson(json);
}
