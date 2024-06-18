import 'package:flutter/material.dart';

class Profilepagewidget extends StatefulWidget {
  const Profilepagewidget({super.key});

  @override
  State<Profilepagewidget> createState() => _ProfilepagewidgetState();
}

class _ProfilepagewidgetState extends State<Profilepagewidget> {
  final displayNameController = TextEditingController();
  final photoUrlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                TextField(
                  controller: displayNameController,
                  decoration: InputDecoration(
                    labelText: 'Display Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: photoUrlController,
                  decoration: InputDecoration(
                    labelText: 'Photo URL',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.pop(
                      context,
                      {
                        'name': displayNameController.text,
                        'url': photoUrlController.text,
                      },
                    );
                  },
                  child: Text('Update Profile'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
