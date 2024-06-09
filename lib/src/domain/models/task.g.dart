// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      taskTitle: json['taskTitle'] as String?,
      taskDescription: json['taskDescription'] as String?,
      taskId: json['taskId'] as String?,
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'taskTitle': instance.taskTitle,
      'taskDescription': instance.taskDescription,
      'taskId': instance.taskId,
    };
