import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

abstract class BaseNavigator {
  void showLoading({String meassage});

  void showMessage(String meassage);

  void hideDialog();
}

class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
  NAV? navigator = null;
}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

  VM initviewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initviewModel();
  }

  @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void ShowLoading({String message = "Loading"}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Row(
              children: [
                Text(message),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void showMessage(String meassage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(meassage),
        );
      },
    );
  }
}
