import 'package:flutter/material.dart';
import 'package:shop_app/widgets/navigation_bar/main/categories/categories.dart';

import 'categories/user_info.dart';

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      minimum: EdgeInsets.only(top: 45),
      child: Scaffold(
        appBar: UserInfo(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Categories(),
        ),
      ),
    );
  }
}
