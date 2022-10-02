import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/ui/theme_extensions.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_background.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_drawer.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_filters.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_header.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_tasks.dart';
import 'package:todo_list_provider/app/modules/home/widgets/home_week_filter.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton(
            icon: Icon(Icons.filter_alt_rounded),
            itemBuilder: (_) => [
              PopupMenuItem<bool>(
                child: Text('Mostrar tarefas concluidas'),
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.primaryColorLight,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      drawer: HomeDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              HomeBackground(),
              Container(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                    minWidth: constraints.maxWidth,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 60),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HomeHeader(),
                          HomeFilters(),
                          HomeWeekFilter(),
                          HomeTasks(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
