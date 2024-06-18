import 'package:auksion_app/controllers/authcontroller.dart';
import 'package:auksion_app/views/screens/loginpage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final authcontroller = Authcontroller();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final paswordconfirmcntroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        await authcontroller.register(
          emailcontroller.text,
          passwordcontroller.text,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return const Loginpage();
            },
          ),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Xatolik"),
              content: Text(e.toString()),
            );
          },
        );
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: formkey,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xFF0172AF), Color(0xFF74FEBD)],
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            children: [
              Center(
                child: Text(context.tr('register'),
                  style: GoogleFonts.aboreto(
                      color: Colors.amber,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.tr('input_email');
                  }
                  return null;
                },
                controller: emailcontroller,
                decoration: InputDecoration(
                  fillColor: Colors.blue.shade300,
                  filled: true,
                  label:  Text(context.tr('input_email'),
                    style: TextStyle(color: Colors.amber),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return context.tr('input_password');
                  }
                  return null;
                },
                controller: passwordcontroller,
                decoration: InputDecoration(
                  fillColor: Colors.blue.shade300,
                  filled: true,
                  label:  Text(context.tr('input_password'),
                    style: TextStyle(color: Colors.amber),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (paswordconfirmcntroller.text != passwordcontroller.text) {
                    return 'Your password tog`ri kelmayapti';
                  }
                  return null;
                },
                controller: paswordconfirmcntroller,
                decoration: InputDecoration(
                  fillColor: Colors.blue.shade300,
                  filled: true,
                  label:  Text(context.tr('confirm_password'),
                    style: TextStyle(color: Colors.amber),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  submit();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Text(context.tr('sign_up'),
                    style: GoogleFonts.aboreto(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
