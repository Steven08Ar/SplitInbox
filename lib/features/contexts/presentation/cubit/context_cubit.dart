import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/context_container.dart';

// States
abstract class ContextState {
  final ContextContainer activeContext;
  const ContextState(this.activeContext);
}

class ContextInitial extends ContextState {
  const ContextInitial(super.activeContext);
}

class ContextChanged extends ContextState {
  const ContextChanged(super.activeContext);
}

// Cubit
class ContextCubit extends Cubit<ContextState> {
  ContextCubit()
    : super(
        const ContextInitial(
          ContextContainer(
            id: 'personal',
            name: 'Personal',
            iconData: 'person',
            index: 0,
            linkedAccountIds: ['gmail_1'],
          ),
        ),
      );

  final List<ContextContainer> _availableContexts = [
    const ContextContainer(
      id: 'personal',
      name: 'Personal',
      iconData: 'person',
      index: 0,
      linkedAccountIds: ['gmail_1'],
    ),
    const ContextContainer(
      id: 'work',
      name: 'Work',
      iconData: 'work',
      index: 1,
      linkedAccountIds: ['outlook_1'],
    ),
    const ContextContainer(
      id: 'gamer',
      name: 'Gamer',
      iconData: 'gamepad',
      index: 2,
      linkedAccountIds: ['steam_1'],
    ),
  ];

  List<ContextContainer> get availableContexts => _availableContexts;

  void switchContext(String contextId) {
    final newContext = _availableContexts.firstWhere(
      (c) => c.id == contextId,
      orElse: () => _availableContexts.first,
    );
    emit(ContextChanged(newContext));
  }
}
