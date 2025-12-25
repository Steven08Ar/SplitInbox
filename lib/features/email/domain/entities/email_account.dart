import 'package:equatable/equatable.dart';

enum EmailProvider { google, outlook, imap }

class EmailAccount extends Equatable {
  final String id;
  final String emailAddress;
  final String displayName;
  final EmailProvider provider;
  final String? accessToken; // For OAuth2
  final String? refreshToken;

  // For IMAP/SMTP manual config
  final String? imapHost;
  final int? imapPort;
  final String? smtpHost;
  final int? smtpPort;

  const EmailAccount({
    required this.id,
    required this.emailAddress,
    required this.displayName,
    required this.provider,
    this.accessToken,
    this.refreshToken,
    this.imapHost,
    this.imapPort,
    this.smtpHost,
    this.smtpPort,
  });

  @override
  List<Object?> get props => [
    id,
    emailAddress,
    displayName,
    provider,
    accessToken,
    refreshToken,
    imapHost,
    imapPort,
    smtpHost,
    smtpPort,
  ];
}
