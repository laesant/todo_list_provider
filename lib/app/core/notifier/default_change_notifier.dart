import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/ui/messages.dart';

class DefaultChangeNotifier extends ChangeNotifier {
  bool _loading = false;
  String? _error;
  bool _success = false;

  bool get loading => _loading;
  String? get error => _error;
  bool get hasError => _error != null;
  bool get isSuccess => _success;

  void showLoading() => _loading = true;
  void hideLoading() => _loading = false;
  void success() => _success = true;
  void setError(String? error) => _error = error;

  void showLoadingAndResetState() {
    showLoading();
    resetState();
  }

  void resetState() {
    setError(null);
    _success = false;
  }

  /// Quando o parametro [success] for igual a [true], a função [onSuccess] será executada.
  /// [alwaysRun] sempre que for DIFERENTE de [null] será executado antes de tudo.
  void implementDefaultListenerNotifier({
    required BuildContext context,
    required SuccessVoidCallback onSuccess,
    ErrorVoidCallback? onError,
    EverVoidCallback? alwaysRun,
  }) {
    addListener(() {
      if(alwaysRun != null){
        alwaysRun(this);
      }
      if (loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }

      if (hasError) {
        if (onError != null) {
          onError(this);
        }
        Messages.of(context).showError(error ?? 'Erro interno');
      } else if (isSuccess) {
        onSuccess(this);
      }
    });
  }
}

typedef SuccessVoidCallback = void Function(
  DefaultChangeNotifier notifier,
);
typedef ErrorVoidCallback = void Function(
  DefaultChangeNotifier notifier,
);
typedef EverVoidCallback = void Function(
  DefaultChangeNotifier notifier,
);
