import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'LoginRegisterPage.dart';
import 'HomePage.dart';

class MappingPage extends StatefulWidget {
  
  MappingPage();
  State<StatefulWidget> createState() {
    return _MappingPageState();
  }
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

class _MappingPageState extends State<MappingPage> {
  AuthStatus authStatus = AuthStatus.notSignedIn; //This variable is not kept up to date after init launch
  @override
  void initState() 
  {
    super.initState();
    AuthImplementation.getCurrentUser().then((firebaseUserId)
    {
        setState((){
            authStatus = firebaseUserId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
        });
    });
  }

// void _signedIn()
// {
//   setState(()
//   {
//       authStatus = AuthStatus.signedIn;
//   });  
// }
// void _signOut()
// {
//   setState(()
//   {
//       authStatus = AuthStatus.notSignedIn;
//   });  
// }


  @override
  Widget build(BuildContext context) {
    switch(authStatus)
    {
      case AuthStatus.notSignedIn:  
      return new LoginRegisterPage
      (

      );
      case AuthStatus.signedIn:  
      return new HomePage
      (
 
      );

    }
    return null;
  }
}
