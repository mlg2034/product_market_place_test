import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final String? errorText;
  final VoidCallback? tryAgainTap;

  const AppErrorWidget({super.key, this.errorText, this.tryAgainTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            errorText??'Что-то пошло не так',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: tryAgainTap,
            child: const Text('Повторить'),
          ),
        ],
      ),
    );
  }
}
