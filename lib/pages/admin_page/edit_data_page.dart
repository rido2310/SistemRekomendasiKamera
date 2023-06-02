import 'package:camera_market_app/pages/admin_page/insert_page.dart';
import 'package:camera_market_app/pages/admin_page/list_page.dart';
import 'package:flutter/material.dart';

class EditDataPage extends StatelessWidget {
  const EditDataPage({Key? key}) : super(key: key);
  static const routeName = 'editDataPageRoute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: SizedBox(
          height: 50,
          width: 90,
          child: Image.asset(
            'assets/icons/Logo.png',
            color: Colors.black,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(18.0),
              height: constraints.maxHeight,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Selamat datang, Admin <adminID>',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            'Edit Data',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 140,
                  ),
                  _buildEditButton(
                    'Insert Data',
                    () => Navigator.pushNamed(context, InsertPage.routeName),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _buildEditButton(
                    'List Data Camera',
                    () => Navigator.pushNamed(context, DataListPage.routeName),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InkWell _buildEditButton(String title, Function onTap) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          // border: Border.all(),
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        width: 200,
        height: 40,
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
