import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/contexts/presentation/cubit/context_cubit.dart';
import 'features/email/presentation/pages/contextual_inbox_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive/Dependencies here if needed later

  runApp(const SplitInboxApp());
}

class SplitInboxApp extends StatelessWidget {
  const SplitInboxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => ContextCubit())],
      child: MaterialApp(
        title: 'SplitInbox',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.redAccent),
        home: const ContextualInboxScreen(),
      ),
    );
  }
}
