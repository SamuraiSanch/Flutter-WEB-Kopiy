import 'package:flutter/material.dart';
import 'package:flutter_labs/user_repository_impl.dart';
import 'quotes_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Відстань між фото
        children: [
          
          GestureDetector(
            onTap: () async {
              final shouldLogout = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: Colors.black,
                  title: const Text('Log out', style: TextStyle(color: Colors.white)),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false); // Скасувати
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true); // Підтвердити
                      },
                      child: const Text('Log out'),
                    ),
                  ],
                ),
              );

              if (shouldLogout == true) {
                await UserRepositoryImpl().logoutUser();
                Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
              }
            },
            child: Image.asset(
              'assets/exit.png',
              height: 50,
            ),
          ),
          
         
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const QuotesPage()),
              );
            },
            child: Image.asset(
              'assets/secret.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/main'); 
            },
            child: Image.asset(
              'assets/wall.png',
              height: 50,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/profile'); 
            },
            child: Image.asset(
              'assets/user.png',
              height: 50,
            ),
          ),
        ],
      ),
    );
  }
}
