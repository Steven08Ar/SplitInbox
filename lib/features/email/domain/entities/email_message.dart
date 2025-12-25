import 'package:equatable/equatable.dart';

class EmailMessage extends Equatable {
  final String id;
  final String subject;
  final String sender;
  final String snippet;
  final DateTime timestamp;
  final String
  contextId; // The ID of the context this email belongs to (simulated for now)

  const EmailMessage({
    required this.id,
    required this.subject,
    required this.sender,
    required this.snippet,
    required this.timestamp,
    required this.contextId,
  });

  @override
  List<Object?> get props => [
    id,
    subject,
    sender,
    snippet,
    timestamp,
    contextId,
  ];
}
