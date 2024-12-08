import 'package:client/core/theme/app_pallete.dart';
import 'package:client/core/utils.dart';
import 'package:client/core/widgets/loader.dart';
import 'package:client/features/auth/repositeries/auth_remote_respositery.dart';
import 'package:client/features/auth/view/pages/signup_page.dart';
import 'package:client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:client/features/auth/view/widgets/custom_field.dart';
import 'package:client/features/auth/viewModel/auth_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fpdart;

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState?.validate();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider)?.isLoading == true;

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (data) {
            //TODO: Implement the home page route

            // ScaffoldMessenger.of(context)
            //   ..hideCurrentSnackBar()
            //   ..showSnackBar(const SnackBar(
            //     content: Text('Account Successfully Created. Please Log In!'),
            //   ));
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const LoginPage(),
            //   ),
            // );
          },
          error: (error, et) {
            showSnackBar(
              context,
              error.toString(),
            );
          },
          loading: () {},
        );
      },
    );
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const ZefenFancyLoader()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/z_icon.png', // Path to your PNG file
                        height: 80,
                        width: 80,
                      ),
                      const Text(
                        "Sign In.",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomeField(
                        hintText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomeField(
                        hintText: 'Password',
                        controller: passwordController,
                        isObsecure: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AuthGradientButton(
                        buttonText: 'Sign In',
                        onTap: () async {
                          final res = await AuthRemoteRepository().login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          final val = switch (res) {
                            fpdart.Left(value: final l) => l,
                            fpdart.Right(value: final r) => r,
                          };
                          print(val);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignupPage(),
                            ),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                              text: 'Don\'t have an account? ',
                              style: Theme.of(context).textTheme.titleMedium,
                              children: const [
                                TextSpan(
                                    text: ' Sign Up ',
                                    style: TextStyle(
                                        color: Pallete.gradient2,
                                        fontWeight: FontWeight.bold))
                              ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
