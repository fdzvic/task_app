import 'package:flutter/material.dart';
import 'package:taks_app/core/presentation/design/atoms/custom_text.dart';
import 'package:taks_app/core/presentation/design/tokens/colors.dart';
import 'package:taks_app/core/presentation/utils/extension/dimens_extension.dart';

///
/// Esta clase contiene todos los mensajes de dialogo que se mostrarán dentro de la aplicación
///

extension CustomDialogs on BuildContext {
  void showAddTaskDialog({
    bool? enableDrag = true,
    bool? isDismissible = true,
    required Widget child,
  }) =>
      showModalBottomSheet(
        context: this,
        isScrollControlled: true,
        enableDrag: enableDrag ?? true,
        isDismissible: isDismissible ?? true,
        backgroundColor: const Color(0XFFFDFDFD),
        barrierColor: const Color(0XFF373737).withOpacity(.8),
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: child,
          );
        },
      );

  void showMessageDialog(
          {required List<Widget> actions,
          String? title,
          String? subtitle,
          bool? dimisible}) =>
      showDialog(
        context: this,
        barrierDismissible: dimisible ?? true,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                  width: context.width(.55),
                  padding: EdgeInsets.symmetric(
                      vertical: context.height(.04),
                      horizontal: context.width(.05)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colors.cardColor),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        title,
                        fontSize: 34,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      CustomText(
                        subtitle,
                        fontSize: 18,
                        textColor: colors.textColor,
                        textAlign: TextAlign.center,
                        height: 1.5,
                      ),
                      const SizedBox(height: 48),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: actions)
                    ],
                  )),
            ),
          );
        },
      );

  void showToast(
      {String? message,
      double? witdh,
      bool? diseabledButton = false,
      void Function()? onTap}) {
    final scaffold = ScaffoldMessenger.of(this);

    scaffold.showSnackBar(
      SnackBar(
        elevation: 3.0,
        backgroundColor: colors.primaryColor.withOpacity(.8),
        actionOverflowThreshold: 0.1,
        width: witdh ?? 450,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 14),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              message,
              textColor: Colors.white,
              fontSize: 18,
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class ShowCardOptionsData {
  final String? title;
  final void Function()? onTap;

  ShowCardOptionsData({
    this.title,
    this.onTap,
  });
}
