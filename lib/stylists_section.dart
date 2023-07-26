import 'package:flutter/material.dart';

class StylistsSection extends StatelessWidget {
  const StylistsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Estilistas',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 70,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1553521041-d168abd31de3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fGJhcmJlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1582893561942-d61adcb2e534?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzF8fGJhcmJlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1602982903808-29f783644d21?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTQ2fHxiYXJiZXJ8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://plus.unsplash.com/premium_photo-1664048713110-f5ac3a19b29d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8cGVsdXF1ZXJhfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1527772837295-9150784b5ae5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTU5fHxwZWx1cXVlcmF8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1639511177364-0866c0da16fa?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzI3fHxiYXJiZXJvfGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
