import 'package:flutter/material.dart';

class ConfirmDialog extends StatefulWidget {
  ConfirmDialog({Key? key}) : super(key: key);

  @override
  State<ConfirmDialog> createState() => _ConfirmDialogState();
}

class _ConfirmDialogState extends State<ConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(title: Text("Confirm"),);
  }
}
