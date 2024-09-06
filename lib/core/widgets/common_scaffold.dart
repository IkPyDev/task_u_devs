import 'package:flutter/material.dart';
import 'package:task_u_devs/core/extension/color.dart';

class CommonScaffold extends StatelessWidget {
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? endDrawer;
  final bool resizeToAvoidBottomInset;

  const CommonScaffold({
    super.key,
    this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.bottomNavigationBar,
    this.drawer,
    this.endDrawer,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.onPrimary, // You can change the default color
      appBar: appBar, // You can pass an AppBar here
      body: body ?? const SizedBox.shrink(), // Main content
      floatingActionButton: floatingActionButton, // For FAB if needed
      floatingActionButtonLocation: floatingActionButtonLocation ?? FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: bottomNavigationBar, // Bottom navigation bar if required
      drawer: drawer, // Drawer if needed
      endDrawer: endDrawer, // End drawer if needed
      resizeToAvoidBottomInset: resizeToAvoidBottomInset, // Whether to resize for the keyboard
    );
  }
}
