import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_provider/app/core/auth/auth_provider.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/core/widget/todo_list_footer.dart';
import 'package:todo_list_provider/app/services/user/user_service.dart';

class HomeDrawer extends StatelessWidget {
  final nameVN = ValueNotifier<String>('');

  HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black12,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: context.primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(0.8, 1),
                  colors: [
                    Color.fromARGB(255, 145, 40, 167),
                    Color.fromARGB(255, 21, 1, 95),
                    context.primaryColor
                  ]),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 139, 0, 167),
                  blurRadius: 15,
                  offset: Offset(-10, 5),
                ),
                BoxShadow(
                  color: Color.fromARGB(255, 29, 109, 201),
                  blurRadius: 15,
                  offset: Offset(-5, -10),
                ),
              ],
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
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
                    backgroundColor: Colors.white10,
                    title: Text('Digite seu nome'),
                    titleTextStyle: TextStyle(color: Colors.white),
                    content: TextField(
                      onChanged: ((value) => nameVN.value = value),
                      style: TextStyle(color: Colors.white),
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
            title: Text('Alterar meu nome'),
            textColor: Colors.white,
            trailing: Icon(Icons.edit),
            iconColor: Color.fromARGB(255, 139, 0, 167),
          ),
          ListTile(
            onTap: () => context.read<AuthProvider>().logout(),
            title: Text('Sair'),
            textColor: Colors.white,
            trailing: Icon(Icons.exit_to_app_rounded),
            iconColor: Color.fromARGB(255, 139, 0, 167),
          ),
          SizedBox(
            height: 480,
          ),
          TodoListFooter(),
        ],
      ),
    );
  }
}
