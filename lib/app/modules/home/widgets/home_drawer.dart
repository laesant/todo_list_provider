import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  final nameVN = ValueNotifier<String>('');

  @override
  void dispose() {
    nameVN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration:
                BoxDecoration(color: context.primaryColor.withAlpha(70)),
            child: Row(
              children: [
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.photoURL ??
                        'https://st2.depositphotos.com/6564638/10596/v/450/depositphotos_105962630-stock-illustration-male-avatar-profile-picture-vector.jpg';
                  },
                  builder: (_, value, __) {
                    return CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(value),
                    );
                  },
                ),
                Selector<AuthProvider, String>(
                  selector: (context, authProvider) {
                    return authProvider.user?.displayName ?? 'Não informado';
                  },
                  builder: (_, value, __) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          value,
                          style: context.textTheme.titleSmall,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('Alterar Nome'),
                      content: TextField(
                        onChanged: (value) => nameVN.value = value,
                      ),
                      actions: [
                        TextButton(
                            style: TextButton.styleFrom(
                                foregroundColor: Colors.red),
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Cancelar')),
                        TextButton(
                            onPressed: () async {
                              final value = nameVN.value;
                              if (value.isEmpty) {
                                Messages.of(context)
                                    .showError('Nome obrigatório');
                              } else {
                                Loader.show(context);
                                await context
                                    .read<UserService>()
                                    .updateDisplayName(value);
                                Loader.hide();
                                if (context.mounted) Navigator.pop(context);
                              }
                            },
                            child: const Text('Alterar'))
                      ],
                    );
                  });
            },
            trailing: const Icon(Icons.change_circle_outlined),
            title: const Text('Alterar Nome'),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            trailing: const Icon(Icons.exit_to_app_outlined),
            title: const Text('Sair'),
          ),
        ],
      ),
    );
  }
}
