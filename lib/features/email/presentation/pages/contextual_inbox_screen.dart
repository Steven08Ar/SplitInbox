import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/design_system.dart';
import '../../contexts/presentation/cubit/context_cubit.dart';
import '../../navigation/presentation/widgets/context_switcher.dart';

class ContextualInboxScreen extends StatelessWidget {
  const ContextualInboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContextCubit, ContextState>(
      builder: (context, state) {
        final activeContext = state.activeContext;
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
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activeContext.name,
                      style: design.headlineLarge.copyWith(
                        color: activeContext.id == 'gamer'
                            ? Colors
                                  .redAccent // Example dynamic change
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
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: 10, // Mock count
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return design.card(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: design.primaryColor.withOpacity(
                                0.1,
                              ),
                              child: Text(
                                'JS',
                                style: TextStyle(color: design.primaryColor),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'John Smith',
                                    style: design.bodyMedium.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Project Update: Phase 2 verified',
                                    style: design.bodyMedium.copyWith(
                                      fontSize: 14,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'The latest build for the Flutter app is ready...',
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
                            Column(
                              children: [
                                Text(
                                  '10:42',
                                  style: design.bodyMedium.copyWith(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
