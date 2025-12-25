import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/design_system.dart';
import '../../contexts/presentation/cubit/context_cubit.dart';
import '../../navigation/presentation/widgets/context_switcher.dart';
import '../cubit/email_cubit.dart';

class ContextualInboxScreen extends StatelessWidget {
  const ContextualInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          EmailCubit()
            ..filterEmails(context.read<ContextCubit>().state.activeContext.id),
      child: const _ContextualInboxView(),
    );
  }
}

class _ContextualInboxView extends StatelessWidget {
  const _ContextualInboxView();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ContextCubit, ContextState>(
      listener: (context, state) {
        context.read<EmailCubit>().filterEmails(state.activeContext.id);
      },
      child: BlocBuilder<ContextCubit, ContextState>(
        builder: (context, contextState) {
          final activeContext = contextState.activeContext;
          final design = DesignSystem.instance;

          return design.scaffold(
            sidebar: const ContextSwitcher(),
            body: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activeContext.name,
                        style: design.headlineLarge.copyWith(
                          color: activeContext.id == 'gamer'
                              ? Colors.redAccent
                              : design.textColor,
                        ),
                      ),
                      Text(
                        '${activeContext.linkedAccountIds.length} Linked Accounts',
                        style: design.bodyMedium.copyWith(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                // Email List
                Expanded(
                  child: BlocBuilder<EmailCubit, EmailState>(
                    builder: (context, emailState) {
                      if (emailState is EmailLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (emailState is EmailLoaded) {
                        if (emailState.emails.isEmpty) {
                          return Center(
                            child: Text(
                              'No emails in ${activeContext.name} context',
                              style: design.bodyMedium.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                          );
                        }

                        return ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: emailState.emails.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final email = emailState.emails[index];
                            return design.card(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: design.primaryColor
                                          .withOpacity(0.1),
                                      child: Text(
                                        email.sender[0].toUpperCase(),
                                        style: TextStyle(
                                          color: design.primaryColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            email.sender,
                                            style: design.bodyMedium.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            email.subject,
                                            style: design.bodyMedium.copyWith(
                                              fontSize: 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            email.snippet,
                                            style: design.bodyMedium.copyWith(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
