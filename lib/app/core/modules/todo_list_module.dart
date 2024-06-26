import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:todo_list_provider/app/core/modules/todo_list_page.dart';

abstract class TodoListModule {
  final Map<String, WidgetBuilder> _routes;
  final List<SingleChildWidget>? _bindings;

  TodoListModule(
      {List<SingleChildWidget>? bindings,
      required Map<String, WidgetBuilder> routes})
      : _routes = routes,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routes => _routes.map(
        (key, pageBuilder) => MapEntry(
          key,
          (_) => TodoListPage(
            bindings: _bindings,
            page: pageBuilder,
          ),
        ),
      );
  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _routes[path];

    if (widgetBuilder == null) throw Exception();

    return TodoListPage(
      bindings: _bindings,
      page: widgetBuilder,
    );
  }
}
