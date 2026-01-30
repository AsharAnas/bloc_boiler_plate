import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_spacing.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../home/pages/home_page.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginBloc>().add(LoginSubmitted(email: _emailController.text.trim(), password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (prev, curr) => (curr is LoginSuccess && prev is! LoginSuccess) || (curr is LoginError && prev is! LoginError),
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.showSnackBar('Logged in. Token: ${state.response.token}');
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
        }
        if (state is LoginError) {
          context.showSnackBar(state.failure.message, isError: true);
        }
      },
      buildWhen: (prev, curr) => prev.obscurePassword != curr.obscurePassword || prev.runtimeType != curr.runtimeType,
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        final obscurePassword = state.obscurePassword;
        return Scaffold(
          appBar: AppBar(title: const Text('Login (POST example)')),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: AppSpacing.lg),
                    Text('Test: eve.holt@reqres.in / cityslicka', style: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.onSurfaceVariant)),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      controller: _emailController,
                      label: 'Email',
                      hint: 'eve.holt@reqres.in',
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter email' : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      key: ValueKey(obscurePassword),
                      controller: _passwordController,
                      label: 'Password',
                      hint: 'cityslicka',
                      obscureText: obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => context.read<LoginBloc>().add(const PasswordObscureToggled()),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(label: 'Login', onPressed: _submit, isLoading: isLoading),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
