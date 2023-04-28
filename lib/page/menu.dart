import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.3;
    return Scaffold(
      appBar: AppBar(
        title: const Text('選單'),
        actions: [
          TextButton(
            child: const Text(
              "紀錄",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/history');
            },
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: width,
              height: width,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/create_match');
                },
                child: const Text('建立'),
              ),
            ),
            SizedBox(
              width: width,
              height: width,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/connectable_list');
                },
                child: const Text('連線'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
