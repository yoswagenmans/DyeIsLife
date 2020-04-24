import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'DialogBox.dart';
import 'HomePage.dart';

class LoginRegisterPage extends StatefulWidget {
  LoginRegisterPage();
  
  //final VoidCallback onSignedIn;
  State<StatefulWidget> createState() {
    return _LoginRegisterState();
  }
}

enum FormType { login, register }

class _LoginRegisterState extends State<LoginRegisterPage> {
  DialogBox dialogBox = new DialogBox();
  final formKey = new GlobalKey<FormState>();
  FormType _formType = FormType.login;
  String _email = "";
  String _password = "";
  String _username = "";

  //methods
  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId = await AuthImplementation.signIn(_email, _password);
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return new HomePage();
                      }),
                    );
          //dialogBox.information(context, "Congratulations", "you are logged in succesfully");
          print("login userId = " + userId);
        } else {
          String userId = await AuthImplementation.signUp(_email, _password);
          //dialogBox.information(context, "Congratulations", "your account has been created succesfully");
          print("Register userId = " + userId);
        }
        //widget.onSignedIn();
      } catch (e) {
        dialogBox.information(context, "Error", e.toString());
        print("Error = " + e.toString());
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login;
    });
  }

  //Design
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Flutter Blog App"),
        automaticallyImplyLeading: false,
      ),
      body: new Container(
        margin: EdgeInsets.all(15.8),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: createInputs() + createButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> createInputs() {
    return [
      SizedBox(
        height: 10.0,
      ),
      logo(),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Email'),
        validator: (value) {
          return value.isEmpty ? 'Email is required' : null;
        },
        onSaved: (value) {
          return _email = value;
        },
      ),
      SizedBox(
        height: 10.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Username'),
        obscureText: false,
        validator: (value) {
          return value.isEmpty ? 'Username is required' : null;
        },
        onSaved: (value) {
          return _username = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
      new TextFormField(
        decoration: new InputDecoration(labelText: 'Password'),
        obscureText: true,
        validator: (value) {
          return value.isEmpty ? 'Password is required' : null;
        },
        onSaved: (value) {
          return _password = value;
        },
      ),
      SizedBox(
        height: 20.0,
      ),
    ];
  }

  Widget logo() {
    return new Hero(
        tag: 'hero',
        child: new CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 200.0,
          child: Image.asset('images/app_logo.jpeg'),
        ));
  }

  List<Widget> createButtons() {
    if (_formType == FormType.login) {
      return [
        new RaisedButton(
          child: new Text("Login", style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.pink,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text("Don't have an account",
              style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.red,
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        new RaisedButton(
          child:
              new Text("Create Account", style: new TextStyle(fontSize: 20.0)),
          textColor: Colors.white,
          color: Colors.pink,
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text("Already have an account? Login",
              style: new TextStyle(fontSize: 14.0)),
          textColor: Colors.red,
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
