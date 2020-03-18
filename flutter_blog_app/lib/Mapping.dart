import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';

class MappingPage extends StatefulWidget {
  final AuthImplementation auth;
  MappingPage({
    this.auth,
  });
  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn;
  @override
  void initState() 
  {
    super.initState();
    widget.auth.getCurrentUser().then((firebaseUserId)
    {
        setState((){
            authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
    });
  }

void _signedIn()
{
  setState(()
  {
      authStatus = AuthStatus.signedIn;
  });  
}
void _signOut()
{
  setState(()
  {
      authStatus = AuthStatus.notSignedIn;
  });  
}


  @override
  Widget build(BuildContext context) {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:  
      return new LoginRegisterPage
      (
        auth: widget.auth, 
        onSignedIn: _signedIn,
      );
      case AuthStatus.signedIn:  
      return new HomePage
      (
        auth: widget.auth, 
        onSignedOut: _signOut,
      );

    }
    return null;
  }
}
