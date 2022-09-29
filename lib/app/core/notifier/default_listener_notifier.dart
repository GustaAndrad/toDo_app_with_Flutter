// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifier.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifier changeNotifier;

  DefaultListenerNotifier({
    required this.changeNotifier,
  });

  void listener({
    required BuildContext context,
    required SucessVoidCallBack sucessCallBack,
    ErrorVoidCallBack? errorCallBack,
  }) {
    changeNotifier.addListener(() {
      if (changeNotifier.loading) {
        Loader.show(
          context,
          overlayColor: Colors.black45,
          progressIndicator: CircularProgressIndicator(
              backgroundColor: Colors.purple.shade600),
        );
      } else {
        Loader.hide();
      }

      if (changeNotifier.hasError) {
        if (errorCallBack != null) {
          errorCallBack(changeNotifier, this);
        }
        Messages.of(context).showError(changeNotifier.error ?? 'Erro interno');
      } else if (changeNotifier.isSucess) {
        sucessCallBack(changeNotifier, this);
        Messages.of(context).showInfo('Cadastro realizado com sucesso!!');
      }
    });
  }

  void dispose() {
    changeNotifier.removeListener(() {});
  }
}

typedef SucessVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);

typedef ErrorVoidCallBack = void Function(
    DefaultChangeNotifier notifier, DefaultListenerNotifier listenerNotifier);
