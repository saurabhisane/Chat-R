import 'dart:io';
import 'package:chat_app/screens/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widget/image_picker.dart';
import '../services/uploadImage_to_cloudinary.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  File? _selectedImage;
  bool isLoading = false;

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    const String emailPattern =
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(emailPattern);
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _signup() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        Get.snackbar(
          'Signup Error',
          "Please upload an image",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }
      setState(() {
        isLoading = true;
      });
      try {
        // Create user with email and password
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword (
            email: _emailController.text.trim(),
            password: _passwordController.text.trim());

        // Upload image to Cloudinary and await the result
        String? imageUrl = await UploadImageToCloudinary(_selectedImage!);

        // Check if the image upload was successful
        if (imageUrl != null) {
          // Save user data to Firestore
          await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
            'userName': _usernameController.text.trim(),
            'userEmail': _emailController.text.trim(),
            'imgUrl': imageUrl, // Use the actual image URL
          });

          Get.snackbar(
            'Successful Signup',
            "You can login now!!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );

          // Navigate to the login page
          Get.to(()=> LoginPage());
        } else {
          Get.snackbar(
            'Signup Error',
            "Image upload failed. Please try again.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'The account already exists for that email.';
        } else {
          message = 'An error occurred. Please try again.';
        }
        Get.snackbar(
          'Signup Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueAccent,
              Colors.purpleAccent,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomImagePicker(
                      onPick: (pickedFile) {
                        _selectedImage = pickedFile;
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildTextField(
                        'Username', false, _usernameController, null),
                    const SizedBox(height: 16),
                    _buildTextField(
                        'Email', false, _emailController, _validateEmail),
                    const SizedBox(height: 16),
                    _buildTextField('Password', true, _passwordController,
                        _validatePassword),
                    const SizedBox(height: 16),
                    _buildTextField('Confirm Password', true,
                        _confirmPasswordController, _validateConfirmPassword),
                    const SizedBox(height: 20),
                    // ElevatedButton(
                    //   onPressed: _signup,
                    //   style: ElevatedButton.styleFrom(
                    //     padding: const EdgeInsets.symmetric(
                    //         horizontal: 32, vertical: 16),
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(30),
                    //     ),
                    //   ),
                    //   child: const Text('Sign Up'),
                    // ),
                    ElevatedButton(
                      onPressed: isLoading ? null : _signup, // Disable the button when loading
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                          : const Text('Sign Up'),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            // Navigate to login page
                            Navigator.pop(
                                context); // Assuming you want to go back to the login page
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, bool isPassword,
      TextEditingController controller, String? Function(String?)? validator) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }
}
