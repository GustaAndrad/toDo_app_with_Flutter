import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor.withAlpha(70),
            ),
            child: Row(
              children: [
                Selector<AuthProvider, String>(builder: (_, value, __) {
                  return CircleAvatar(
                    backgroundImage: NetworkImage(value),
                    radius: 30,
                  );
                }, selector: (context, authProvider) {
                  return authProvider.user?.photoURL ??
                      'https://images.fineartamerica.com/images/artworkimages/mediumlarge/3/human-skull-in-headphones-on-black-background-konstantin-petrov.jpg';
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Selector<AuthProvider, String>(builder: (_, value, __) {
                      return Text(
                        value,
                        style: context.textTheme.subtitle2,
                      );
                    }, selector: (context, authProvider) {
                      return authProvider.user?.displayName ?? 'Não informado';
                    }),
                  ),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: Text('Alterar Nome'),
                    content: TextField(
                      onChanged: ((value) => nameVN.value = value),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          final nameValue = nameVN.value;
                          if (nameValue.isEmpty) {
                            Messages.of(context).showError('Nome obrigatorio');
                          } else {
                            await context
                                .read<UserService>()
                                .updateDisplayName(nameValue);
                            Navigator.of(context).pop();
                          }
                        },
                        child: Text('Alterar'),
                      ),
                    ],
                  );
                },
              );
            },
            title: Text('Alterar nome'),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: Text('Sair'),
          ),
        ],
      ),
    );
  }
}
