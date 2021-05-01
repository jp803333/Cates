import 'package:cates/Provider/AuthProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../colors.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  bool _obscurePasswordText = true;

  void _changeobscure() {
    setState(() {
      _obscurePasswordText = !_obscurePasswordText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffffffff),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
            painter: CtmShapeLoginTop(),
            child: Form(
              key: _formkey,
              child: Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .3,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _email,
                        validator: (value) {
                          if (value.trim() == null ||
                              value.trim() == '' ||
                              value.isEmpty) {
                            return 'Text is Empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: primaryColorDark,
                        cursorWidth: 2,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextFormField(
                        controller: _password,
                        validator: (value) {
                          if (value.trim() == null ||
                              value.trim() == '' ||
                              value.isEmpty) {
                            return 'password is Empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.vpn_key,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              _changeobscure();
                            },
                          ),
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 20,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        obscureText: _obscurePasswordText,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: primaryColorDark,
                        cursorWidth: 2,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Consumer<AuthProvider>(
                        builder: (context, authProvider, child) {
                      return InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Container(
                          margin: EdgeInsets.all(10),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0),
                          ),
                        ),
                        onTap: () {
                          print(_email.text);
                          print(_password.text);
                          if (_formkey.currentState.validate()) {
                            authProvider.logInWithEmailAndPassword(
                                email: _email.text.trim(),
                                password: _password.text.trim());
                          }
                        },
                      );
                    }),
                    InkWell(
                      child: Text(
                        'forgot password?',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: primaryColorLight,
                        ),
                      ),
                      onTap: () {
                        print('forgotpassword');
                        Navigator.pushNamed(context, '/ForgotPasswordScreen');
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColorLight,
                            ),
                          ),
                          InkWell(
                            child: Text(
                              ' Create one',
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: secondaryColorDark,
                              ),
                            ),
                            onTap: () {
                              print('signup pressed');

                              Navigator.pushNamed(context, '/Signup');
                            },
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class CtmShapeLoginTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = primaryColor;
    paint.style = PaintingStyle.fill;
    var path = Path();
    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(
      size.width * .25,
      size.height * .1,
      size.width * .5,
      size.height * .15,
    );
    path.quadraticBezierTo(
      size.width * .9,
      size.height * .2,
      size.width,
      size.height * .1,
    );
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
