import 'package:flutter/material.dart';
import 'package:storeapp/constant.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                blurRadius: 60,
                color: Colors.grey.withOpacity(0.1),
                offset: const Offset(1, 1),
                spreadRadius: 0,
              ),
            ]),
            child: Card(
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'product name',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '\$price',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.add,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: -50,
            child: Image.asset(
              'assets/images/logo.png',
              height: 80,
              width: 100,
            ),
          )
        ],
      ),
    );
  }
}
