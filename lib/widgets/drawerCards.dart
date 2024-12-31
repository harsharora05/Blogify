import 'package:flutter/material.dart';

class drawerWidget extends StatelessWidget {
  const drawerWidget({
    required this.ic,
    required this.title,
    required this.screen,
    super.key,
  });

  final IconData ic;
  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).primaryColorLight,
      onTap: () {
        Navigator.of(context).pop();
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen));
      },
      child: ListTile(
        leading: Icon(
          ic,
          size: 32,
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
