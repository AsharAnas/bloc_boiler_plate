import 'package:bloc_boiler_plate/core/constants/app_spacing.dart' show AppSpacing;
import 'package:bloc_boiler_plate/core/extensions/context_extensions.dart';
import 'package:bloc_boiler_plate/core/widgets/app_button.dart';
import 'package:bloc_boiler_plate/core/widgets/app_text_field.dart';
import 'package:bloc_boiler_plate/presentation/register/bloc/register_bloc.dart';
import 'package:bloc_boiler_plate/presentation/register/bloc/register_event.dart';
import 'package:bloc_boiler_plate/presentation/register/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    context.hideKeyboard();
    if (!_formKey.currentState!.validate()) return;
    context.read<RegisterBloc>().add(
      RegisterSubmitted(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text,
        confirmPassword: _confirmPasswordController.text,
        phone: _phoneController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterError) {
          context.showSnackBar(state.failure.message, isError: true);
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;
        final obscurePassword = state.obscurePassword;
        final confirmBbscurePassword = state.confirmBbscurePassword;
        return Scaffold(
          appBar: AppBar(title: const Text('Register')),
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
                      controller: _nameController,
                      label: 'Name',
                      hint: 'Ashar Anas',
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Enter name' : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.md),
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
                      // key: ValueKey(obscurePassword),
                      controller: _passwordController,
                      label: 'Password',
                      hint: '*********',
                      obscureText: obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => context.read<RegisterBloc>().add(const PasswordObscureToggled()),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      // key: ValueKey(confirmBbscurePassword),
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      hint: '*********',
                      obscureText: confirmBbscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(confirmBbscurePassword ? Icons.visibility_off : Icons.visibility),
                        onPressed: () => context.read<RegisterBloc>().add(const ConfirmPasswordObscureToggled()),
                      ),
                      validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    AppTextField(
                      controller: _phoneController,
                      label: 'Enter Phone',
                      hint: '*********',

                      validator: (v) => (v == null || v.isEmpty) ? 'Enter password' : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(label: 'Register', onPressed: _submit, isLoading: isLoading),
                    TextButton(
                      child: Text("Already have an account? Login"),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(create: (_) => RegisterBloc(), child: const RegisterPage()),
                        ),
                      ),
                    ),
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
