import 'package:flutter/material.dart';
import 'package:khmerjob_project/models/user_model.dart';
import 'package:khmerjob_project/pages/register_page.dart';
import 'package:khmerjob_project/repo/user_repo.dart';
import 'home_page.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  double _widthOfScreen;
  var _keyScaffold = GlobalKey<ScaffoldState>();
  Future<User> _future;

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _keyScaffold,
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }
  get _buildAppBar{
    return AppBar(
      backgroundColor: Colors.blueAccent,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text("Welcome"),
    );
  }
  get _buildAppBarr {
    return AppBar(
      // iconTheme: IconThemeData(
      //   color: Colors.black, //change your color here
      // ),
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Colors.white70,
      title:Container(
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>HomePage()));
          },
          child: Image.asset(
            'assets/images/LogoKhmerjob.png',
            fit: BoxFit.cover,
            height: 22,
            width: 157,
          ),
        ),

      ),
      actions: [
        _buildProfile,
        _buildPostJob,
      ],
    );
  }
  get _buildProfile {
    return IconButton(
        icon: Image.asset('assets/images/profile.png'), onPressed: () {});
  }
  get _buildPostJob {
    return InkWell(
      onTap: (){
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  ));
      },
      child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 6, bottom: 6, right: 15, left: 15),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Text(
        "PostJob",
        style: TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.lightBlue),
      )
    );
  }
  get _buildBody{
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 390,
        child: ListView(
          physics:BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
                  _buildLogoApp,
            Expanded(child: _buildFormLogin)
            ,
          ],
        ),
      ),
    );
  }
  get _buildLogoApp{
    return Container(
      height: 200,
      width: 200,
      alignment: Alignment.center,
      child: Image.asset('assets/images/iconWeb.png',fit: BoxFit.cover,),
    );
  }
  get _buildFormLogin{
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildEmailFill,
          _buildPasswordFill,
          _buildLoginButton,
          _buildRegisterButton,
        ],
      ),
    );
  }

  TextEditingController _emailCtr = TextEditingController();
  get _buildEmailFill{
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20,5,20,5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _emailCtr,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Email",
          icon: Icon(
            Icons.email,
            color:Colors.blue,
          )
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  TextEditingController _passwordCtr = TextEditingController();
  bool _isHidden = true;
  get _buildPasswordFill{
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20,5,20,5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _passwordCtr,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color:Colors.blue,
          ),
          suffixIcon:InkWell(
            onTap: (){
              if(_isHidden){
                setState(() {
                  _isHidden = false;
                });
              }else{
                setState(() {
                  _isHidden = true;
                });
              }
            },
            child: _isHidden ? Icon(
              Icons.visibility,
              color: Colors.black,
            )
                :Icon(
              Icons.visibility_off,
              color: Colors.black,
            ),
          ),
        ),
        obscureText: _isHidden,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  get _buildLoginButton{
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20,3, 20, 3),
      child: MaterialButton(
        onPressed: () {
          if (_emailCtr.text.isNotEmpty && _passwordCtr.text.isNotEmpty) {
            Future<User> future =
                getUser(_emailCtr.text, _passwordCtr.text);
            future.then((value) {
              if (value.users.isNotEmpty) {
                HomePage.user = value.users.first;
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HomePage()));
              } else {
                _showSnackBar("Incorrect Email or Password");
              }
            });
          } else {
            _showSnackBar("You forgot to enter Email or Password");
          }
        },
        child: Text("LogIn",style: TextStyle(color: Colors.white,fontSize: 17),),
        // color: Colors.blue,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue,
      ),
    );
  }

  get _buildRegisterButton{
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
              child: Text("Or"),
          ),
          Container(
            width: 350,
            child: MaterialButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterPage()));
              },
              child: Text("Register",style: TextStyle(color: Colors.white),),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  _showSnackBar(String text) {
    var snackbar = SnackBar(
      // backgroundColor: Colors.blue,
      content: Container(
        height: 50,
        child: Center(child: Text(text)),
      ),
    );
    _keyScaffold.currentState.showSnackBar(snackbar);
  }

}