import 'package:get/get.dart';
import 'package:material_ui/material_ui.dart';
import 'package:responsi/view/controller/login_controller.dart';
import 'package:responsi/view/page/recipe_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController _controller = Get.put(LoginController());
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _checkAutoLogin();
  }

  /// If the user is already logged in (persisted in shared_preferences),
  /// go straight to the recipe page so the login screen is skipped.
  Future<void> _checkAutoLogin() async {
    final loggedIn = await _controller.getInitialLoginStatus();
    if (mounted && loggedIn) {
      Get.offAll(() => RecipePage());
    }
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final username = _controller.usernameController.text.trim();
    final password = _controller.passwordController.text.trim();

    _controller.login(username, password).then((success) {
      if (success) {
        Get.offAll(() => RecipePage());
      } else {
        Get.snackbar(
          'Login gagal',
          'username atau password salah!',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    });
  }

  @override
  void dispose() {
    Get.delete<LoginController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Login',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _controller.usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username wajib dimasukkan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _controller.passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib dimasukkan';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
