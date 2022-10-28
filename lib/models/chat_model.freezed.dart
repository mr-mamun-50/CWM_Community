// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) {
  return _ChatEntity.fromJson(json);
}

/// @nodoc
mixin _$ChatEntity {
  int get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: "is_private")
  int get isprivate => throw _privateConstructorUsedError;
  @JsonKey(name: "created_at")
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: "updated_at")
  String get updatedAt => throw _privateConstructorUsedError;
  @JsonKey(name: "last_message")
  ChatMessageEntityModel? get lastMessage => throw _privateConstructorUsedError;
  List<ChatParticipantEntity> get participants =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatEntityCopyWith<ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatEntityCopyWith<$Res> {
  factory $ChatEntityCopyWith(
          ChatEntity value, $Res Function(ChatEntity) then) =
      _$ChatEntityCopyWithImpl<$Res, ChatEntity>;
  @useResult
  $Res call(
      {int id,
      String? name,
      @JsonKey(name: "is_private") int isprivate,
      @JsonKey(name: "created_at") String createdAt,
      @JsonKey(name: "updated_at") String updatedAt,
      @JsonKey(name: "last_message") ChatMessageEntityModel? lastMessage,
      List<ChatParticipantEntity> participants});

  $ChatMessageEntityModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class _$ChatEntityCopyWithImpl<$Res, $Val extends ChatEntity>
    implements $ChatEntityCopyWith<$Res> {
  _$ChatEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? isprivate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastMessage = freezed,
    Object? participants = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isprivate: null == isprivate
          ? _value.isprivate
          : isprivate // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessageEntityModel?,
      participants: null == participants
          ? _value.participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ChatParticipantEntity>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatMessageEntityModelCopyWith<$Res>? get lastMessage {
    if (_value.lastMessage == null) {
      return null;
    }

    return $ChatMessageEntityModelCopyWith<$Res>(_value.lastMessage!, (value) {
      return _then(_value.copyWith(lastMessage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatEntityCopyWith<$Res>
    implements $ChatEntityCopyWith<$Res> {
  factory _$$_ChatEntityCopyWith(
          _$_ChatEntity value, $Res Function(_$_ChatEntity) then) =
      __$$_ChatEntityCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? name,
      @JsonKey(name: "is_private") int isprivate,
      @JsonKey(name: "created_at") String createdAt,
      @JsonKey(name: "updated_at") String updatedAt,
      @JsonKey(name: "last_message") ChatMessageEntityModel? lastMessage,
      List<ChatParticipantEntity> participants});

  @override
  $ChatMessageEntityModelCopyWith<$Res>? get lastMessage;
}

/// @nodoc
class __$$_ChatEntityCopyWithImpl<$Res>
    extends _$ChatEntityCopyWithImpl<$Res, _$_ChatEntity>
    implements _$$_ChatEntityCopyWith<$Res> {
  __$$_ChatEntityCopyWithImpl(
      _$_ChatEntity _value, $Res Function(_$_ChatEntity) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? isprivate = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? lastMessage = freezed,
    Object? participants = null,
  }) {
    return _then(_$_ChatEntity(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isprivate: null == isprivate
          ? _value.isprivate
          : isprivate // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: freezed == lastMessage
          ? _value.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as ChatMessageEntityModel?,
      participants: null == participants
          ? _value._participants
          : participants // ignore: cast_nullable_to_non_nullable
              as List<ChatParticipantEntity>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatEntity implements _ChatEntity {
  _$_ChatEntity(
      {required this.id,
      this.name,
      @JsonKey(name: "is_private") required this.isprivate,
      @JsonKey(name: "created_at") required this.createdAt,
      @JsonKey(name: "updated_at") required this.updatedAt,
      @JsonKey(name: "last_message") this.lastMessage,
      required final List<ChatParticipantEntity> participants})
      : _participants = participants;

  factory _$_ChatEntity.fromJson(Map<String, dynamic> json) =>
      _$$_ChatEntityFromJson(json);

  @override
  final int id;
  @override
  final String? name;
  @override
  @JsonKey(name: "is_private")
  final int isprivate;
  @override
  @JsonKey(name: "created_at")
  final String createdAt;
  @override
  @JsonKey(name: "updated_at")
  final String updatedAt;
  @override
  @JsonKey(name: "last_message")
  final ChatMessageEntityModel? lastMessage;
  final List<ChatParticipantEntity> _participants;
  @override
  List<ChatParticipantEntity> get participants {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_participants);
  }

  @override
  String toString() {
    return 'ChatEntity(id: $id, name: $name, isprivate: $isprivate, createdAt: $createdAt, updatedAt: $updatedAt, lastMessage: $lastMessage, participants: $participants)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isprivate, isprivate) ||
                other.isprivate == isprivate) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            const DeepCollectionEquality()
                .equals(other._participants, _participants));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      isprivate,
      createdAt,
      updatedAt,
      lastMessage,
      const DeepCollectionEquality().hash(_participants));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatEntityCopyWith<_$_ChatEntity> get copyWith =>
      __$$_ChatEntityCopyWithImpl<_$_ChatEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatEntityToJson(
      this,
    );
  }
}

abstract class _ChatEntity implements ChatEntity {
  factory _ChatEntity(
      {required final int id,
      final String? name,
      @JsonKey(name: "is_private") required final int isprivate,
      @JsonKey(name: "created_at") required final String createdAt,
      @JsonKey(name: "updated_at") required final String updatedAt,
      @JsonKey(name: "last_message") final ChatMessageEntityModel? lastMessage,
      required final List<ChatParticipantEntity> participants}) = _$_ChatEntity;

  factory _ChatEntity.fromJson(Map<String, dynamic> json) =
      _$_ChatEntity.fromJson;

  @override
  int get id;
  @override
  String? get name;
  @override
  @JsonKey(name: "is_private")
  int get isprivate;
  @override
  @JsonKey(name: "created_at")
  String get createdAt;
  @override
  @JsonKey(name: "updated_at")
  String get updatedAt;
  @override
  @JsonKey(name: "last_message")
  ChatMessageEntityModel? get lastMessage;
  @override
  List<ChatParticipantEntity> get participants;
  @override
  @JsonKey(ignore: true)
  _$$_ChatEntityCopyWith<_$_ChatEntity> get copyWith =>
      throw _privateConstructorUsedError;
}
