import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../contexts/presentation/cubit/context_cubit.dart';
import '../../../../core/theme/design_system.dart';

class ContextSwitcher extends StatelessWidget {
  const ContextSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ContextCubit>();
    final activeId = cubit.state.activeContext.id;
    final design = DesignSystem.instance;

    return Container(
      width: 80,
      color: design.surfaceColor,
      child: Column(
        children: [
          const SizedBox(height: 40),
          ...cubit.availableContexts.map((ctx) {
            final isActive = ctx.id == activeId;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: GestureDetector(
                onTap: () => cubit.switchContext(ctx.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isActive ? 56 : 48,
                  height: isActive ? 56 : 48,
                  decoration: BoxDecoration(
                    color: isActive
                        ? design.primaryColor
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isActive
                        ? [
                            BoxShadow(
                              color: design.primaryColor.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    _getIconData(ctx.iconData),
                    color: isActive ? Colors.white : Colors.grey,
                    size: 24,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'person':
        return Icons.person;
      case 'work':
        return Icons.work;
      case 'gamepad':
        return Icons.gamepad;
      default:
        return Icons.circle;
    }
  }
}
