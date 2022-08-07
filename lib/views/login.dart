
import 'dart:async';
import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/user_repository/bloc.dart';
import '../routes/routes.dart';
import '../routes/navi_repository.dart';
import 'main_view.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  clientId: '29092948700-eoos5oldkh61np1607m4cg3rrmv3str2.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);


class SignInDemo extends StatefulWidget {
  const SignInDemo({Key? key}) : super(key: key);

  @override
  State createState() => SignInDemoState();
}

class SignInDemoState extends State<SignInDemo> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  late final NavigatorState _rootNavi;
  late final UserRepositoryBloc _getUserBloc;

  @override
  void initState() {
    super.initState();
    init();
     _rootNavi = context.read<NaviRepository>().mainKey.currentState!;
    _getUserBloc = BlocProvider.of<UserRepositoryBloc>(context);

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print('onCurrentUserChanged >>>');

      // setState(() {
      //   _currentUser = account;
      // });

      WidgetsBinding.instance.addPostFrameCallback((_) {

        setState(() {
          _currentUser = account;
        });
      });

      // if (_currentUser != null) {
      //   _handleGetContact(_currentUser!);
      // }
    });


    _googleSignIn.signInSilently();
  }

  Future<void> init() async{
    final result = await _googleSignIn.isSignedIn();

    if(result == true){
      print('로긴된 상태인가');
      await _googleSignIn.signOut();
      await _googleSignIn.disconnect();
      // _currentUser = null;
    }
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    print('핸들 겟 컨택');
    // setState(() {
    //   _contactText = 'Loading contact info...';
    // });
    final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      // setState(() {
      //   _contactText = 'People API gave a ${response.statusCode} '
      //       'response. Check logs for details.';
      // });
      // print('People API ${response.statusCode} response: ${response.body}');
      // return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    // setState(() {
    //   if (namedContact != null) {
    //     _contactText = 'I see you know $namedContact!';
    //   } else {
    //     _contactText = 'No contacts to display.';
    //   }
    // });

    final _getUserBloc = BlocProvider.of<UserRepositoryBloc>(context);
    _getUserBloc.loginId = user.email;
    _getUserBloc.add(Login(currentUser: user, googleSignIn: _googleSignIn));
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
            (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    print('_handleSignIn 실행');
    // final result = await _googleSignIn.isSignedIn();
    //
    // if(result == true){
    //   print('로긴된 상태인가');
    //   await _googleSignIn.signOut();
    //   await _googleSignIn.disconnect();
    //   // _currentUser = null;
    // }
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  Widget _buildBody() {
    final GoogleSignInAccount? user = _currentUser;
    if (user != null) {
      debugPrint('user가 null이 아닐때 출력(GoogleSignInAccount)');

      final _getUserBloc = BlocProvider.of<UserRepositoryBloc>(context);
      _getUserBloc.loginId = user.email;
      _getUserBloc.add(Login(currentUser: user, googleSignIn: _googleSignIn));

      // 원본
      _rootNavi.pushNamed(Routes.main, arguments: '메인뷰');


      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(
              identity: user,
            ),
            title: Text(user.displayName ?? ''),
            subtitle: Text(user.email),
          ),
          const Text('Signed in successfully.'),
          Text(_contactText),
          // ElevatedButton(
          //   onPressed: _handleSignOut,
          //   child: const Text('SIGN OUT'),
          // ),
          // ElevatedButton(
          //   child: const Text('REFRESH'),
          //   onPressed: () => _handleGetContact(user),
          // ),
        ],
      );



    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('You are not currently signed in.'),
          ElevatedButton(
            onPressed: _handleSignIn,
            child: const Text('SIGN IN'),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Google Sign In'),
        ),
        body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: _buildBody(),
        ));
  }
}