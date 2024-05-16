import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_vaccine_app/app/routes/app_router.dart';
import 'package:my_vaccine_app/app/routes/route_utils.dart';
import 'package:my_vaccine_app/app/theme/colors_my_vaccine_app.dart';
import 'package:my_vaccine_app/features/auth/presentation/controllers/auth_bloc.dart';
import 'package:my_vaccine_app/features/shared/widgets/custom_filled_button.dart';
import 'package:my_vaccine_app/features/shared/widgets/custom_text_form_field.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           child: const Text(
//             'Login',
//           ),
//           onPressed: (){
//             context.read<AuthBloc>().loginUseCase(true);
//             AppRouter.router.go(PAGES.home.screenPath);
//           },
//         ),
//       ),
//     );
//   }

// }
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      100),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/My_Vaccine_App_Logo.png'),
                    fit: BoxFit
                        .cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: size.height -
                    120, // Adjusted size to accommodate keyboard without overflow
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: const _LoginForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  void _login() {
    setState(() {
      _emailError = _emailController.text.isEmpty ? 'Ingrese un correo' : null;
      _passwordError =
          _passwordController.text.isEmpty ? 'Ingrese una contraseña' : null;

      if (_emailError == null && _passwordError == null) {
        context.read<AuthBloc>().add(AuthEvent.authLogin(email: _emailController.text, password: _passwordController.text));
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 50),
          Text('Login', style: textStyles.titleLarge),
          const SizedBox(height: 50),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            errorMessage: _emailError,
          ),
          const SizedBox(height: 30),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            controller: _passwordController,
            errorMessage: _passwordError,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: CustomFilledButton(
              text: 'Ingresar',
              buttonColor: secondaryColor,
              onPressed: _login,
            ),
          ),
          const Spacer(flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿No tienes cuenta?'),
              TextButton(
                  onPressed: () => context.go('/register'),
                  child: const Text('Crea una aquí'))
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
