import 'package:equatable/equatable.dart';

class ContextContainer extends Equatable {
  final String id;
  final String name;
  final String
  iconData; // Storing icon as string (e.g. codepoint or asset name)
  final List<String> linkedAccountIds;
  final int index;

  const ContextContainer({
    required this.id,
    required this.name,
    required this.iconData,
    this.linkedAccountIds = const [],
    required this.index,
  });

  @override
  List<Object?> get props => [id, name, iconData, linkedAccountIds, index];

  ContextContainer copyWith({
    String? id,
    String? name,
    String? iconData,
    List<String>? linkedAccountIds,
    int? index,
  }) {
    return ContextContainer(
      id: id ?? this.id,
      name: name ?? this.name,
      iconData: iconData ?? this.iconData,
      linkedAccountIds: linkedAccountIds ?? this.linkedAccountIds,
      index: index ?? this.index,
    );
  }

  static const empty = ContextContainer(
    id: '',
    name: '',
    iconData: '',
    index: 0,
  );
}
