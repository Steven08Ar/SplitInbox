import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/email_message.dart';

// States
abstract class EmailState {}

class EmailLoading extends EmailState {}

class EmailLoaded extends EmailState {
  final List<EmailMessage> emails;
  EmailLoaded(this.emails);
}

class EmailCubit extends Cubit<EmailState> {
  EmailCubit() : super(EmailLoading());

  final List<EmailMessage> _allEmails = [
    EmailMessage(
      id: '1',
      subject: 'Steam Winter Sale',
      sender: 'Steam',
      snippet: 'Your wishlist is on sale!',
      timestamp: DateTime.now(),
      contextId: 'gamer',
    ),
    EmailMessage(
      id: '2',
      subject: 'Project Deadline',
      sender: 'Boss',
      snippet: 'We need to ship this Friday.',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      contextId: 'work',
    ),
    EmailMessage(
      id: '3',
      subject: 'Mom',
      sender: 'Mom',
      snippet: 'Are you coming for dinner?',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      contextId: 'personal',
    ),
    EmailMessage(
      id: '4',
      subject: 'Epic Games Free Game',
      sender: 'Epic Games',
      snippet: 'Claim your free game now.',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      contextId: 'gamer',
    ),
    EmailMessage(
      id: '5',
      subject: 'HR Policy Update',
      sender: 'HR',
      snippet: 'Please review the new policy.',
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      contextId: 'work',
    ),
  ];

  void filterEmails(String contextId) {
    emit(EmailLoading());
    // Simulate delay
    Future.delayed(const Duration(milliseconds: 300), () {
      final filtered = _allEmails
          .where((e) => e.contextId == contextId)
          .toList();
      emit(EmailLoaded(filtered));
    });
  }
}
