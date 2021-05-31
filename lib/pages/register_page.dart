import 'package:flutter/material.dart';
import 'package:khmerjob_project/pages/login_page.dart';
import 'package:khmerjob_project/repo/user_repo.dart';
import 'package:khmerjob_project/models/user_model.dart';

import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var _keyScaffold = GlobalKey<ScaffoldState>();
  double _widthOfScreen;

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _keyScaffold,
      // appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  get _buildAppBar {
    return AppBar(
      // iconTheme: IconThemeData(
      //   color: Colors.black, //change your color here
      // ),
      leading: BackButton(
        color: Colors.black,
      ),
      backgroundColor: Colors.white70,
      title: Container(
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
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
        onTap: () {
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
        ));
  }

  get _buildBody {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 390,
        child: ListView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          children: [
            _buildLogoApp,
            Expanded(child: _buildFormLogin),
          ],
        ),
      ),
    );
  }

  get _buildLogoApp {
    return Container(
      height: 200,
      width: 200,
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/iconWeb.png',
        fit: BoxFit.cover,
      ),
    );
  }

  get _buildFormLogin {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildUsernameFill,
          _buildPhoneFill,
          _buildEmailFill,
          _buildDOBandGenderFill,
          _buildPasswordFill,
          _buildConfirmPasswordFill,
          _buildRegisterButton,
          _buildLoginButton,
        ],
      ),
    );
  }

  TextEditingController _usernameCtr = TextEditingController();

  get _buildUsernameFill {
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _usernameCtr,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Username",
            icon: Icon(
              Icons.person,
              color: Colors.blue,
            )),
        keyboardType: TextInputType.name,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  TextEditingController _phoneCtr = TextEditingController();

  get _buildPhoneFill {
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _phoneCtr,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Phone number",
            icon: Icon(
              Icons.phone,
              color: Colors.blue,
            )),
        keyboardType: TextInputType.phone,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  TextEditingController _emailCtr = TextEditingController();

  get _buildEmailFill {
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _emailCtr,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Email",
            icon: Icon(
              Icons.email,
              color: Colors.blue,
            )),
        keyboardType: TextInputType.emailAddress,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  get _buildDOBandGenderFill {
    return Container(
      child: Row(
        children: [
          _buildDOB,
          _buildGender,
        ],
      ),
    );
  }

  // TextEditingController _dobCtr = TextEditingController();

  DateTime _dateTime;
  String _dayOfBirth ;

  get _buildDOB{
    return Container(
      alignment: Alignment.centerRight,
      height: 50,
      width: 170,
      margin: EdgeInsets.fromLTRB(20, 5, 5, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
        child:Row(
          children: [
            Icon(
              Icons.cake,
              color: Colors.blue,
            ),
            Container(
              margin: EdgeInsets.only(left:15),
              padding: EdgeInsets.only(right:5),
              child: Text(_dateTime == null ? "Day of birth" 
                : _dayOfBirth,
                textAlign: TextAlign.right,),
            ),
            Icon(
              Icons.calendar_today,
              color: Colors.black45,
            ),
          ],
        ),
        onTap: (){
          showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1990),
            lastDate: DateTime(2050),
          ).then((date){
            setState(() {
              _dateTime = date;
               _dayOfBirth = _dateTime.toString().substring(0,10);
            });
          });
        },
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

List<String> _genders = ['Male', 'Female', 'Other']; // Option 2
  String _selectedGender;
  
  get _buildGender{
    return Container(
      height: 50,
      width: 170,
      margin: EdgeInsets.fromLTRB(5, 5, 20, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child:  Row(
        children: [
          Icon(
            Icons.accessibility,
          color: Colors.blue,
          ),
          Container(
              margin: EdgeInsets.only(left:15),
            child: DropdownButton(
              underline: SizedBox(),
                  hint: Text('Gender'), // Not necessary for Option 1
                  value: _selectedGender,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  items: _genders.map((gender) {
                    return DropdownMenuItem(
                      child: new Text(gender),
                      value: gender,
                    );
                  }).toList(),
                ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }


  TextEditingController _passwordCtr = TextEditingController();
  bool _isHidden = true;

  get _buildPasswordFill {
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _passwordCtr,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: Colors.blue,
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (_isHidden) {
                setState(() {
                  _isHidden = false;
                });
              } else {
                setState(() {
                  _isHidden = true;
                });
              }
            },
            child: _isHidden
                ? Icon(
                    Icons.visibility,
                    color: Colors.black,
                  )
                : Icon(
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

  TextEditingController _conpasswordCtr = TextEditingController();
  bool _isHidden2 = true;

  get _buildConfirmPasswordFill {
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _conpasswordCtr,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Confirm password",
          icon: Icon(
            Icons.lock_open,
            color: Colors.blue,
          ),
          suffixIcon: InkWell(
            onTap: () {
              if (_isHidden2) {
                setState(() {
                  _isHidden2 = false;
                });
              } else {
                setState(() {
                  _isHidden2 = true;
                });
              }
            },
            child: _isHidden2
                ? Icon(
                    Icons.visibility,
                    color: Colors.black,
                  )
                : Icon(
                    Icons.visibility_off,
                    color: Colors.black,
                  ),
          ),
        ),
        obscureText: _isHidden2,
      ),
      decoration: BoxDecoration(
        color: Colors.lightBlueAccent.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  get _buildRegisterButton {
    return Container(
      height: 50,
      width: _widthOfScreen,
      margin: EdgeInsets.fromLTRB(20, 3, 20, 3),
      child: MaterialButton(
        onPressed: () {

          if (_usernameCtr.text.isNotEmpty && _phoneCtr.text.isNotEmpty
              && _emailCtr.text.isNotEmpty && _dayOfBirth.isNotEmpty
          && _selectedGender.isNotEmpty && _passwordCtr.text.isNotEmpty
          && _conpasswordCtr.text.isNotEmpty ) {
            if(_isEmail(_emailCtr.text)) {
              if (_isPhoneNumber(_phoneCtr.text)){
                if (_validatePassword(_passwordCtr.text)) {
                  if (_passwordCtr.text == _conpasswordCtr.text) {
                    UserElement _user = new UserElement(
                      id: "Auto",
                      username: _usernameCtr.text,
                      phone: _phoneCtr.text,
                      email: _emailCtr.text,
                      dob: _dayOfBirth,
                      gender: _selectedGender,
                      password: _passwordCtr.text,
                      imgProfile: '',
                      createdAt: 'no',
                      updatedAt: 'no',
                    );
                    print('ok');

                    storeUser(_user).then((value){
                      Navigator.of(context).pop();
                      print('ok');

                    });
                  } else {
                    _showSnackBar("Password not match");
                  }
                } else {
                  String str = "Password must be more than 5 digits, lower case, upper case, number, and spacial character.";
                  _showSnackBar(str);
                }
              } else {
                _showSnackBar("Phone number should be 9 or 10 digits");
              }
            } else {
              _showSnackBar("Incorrect email");
            }
          } else {
            _showSnackBar("Please, enter all information");
          }
        },
        child: Text(
          "Register",
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
        // color: Colors.blue,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.blue,
      ),
    );
  }

  get _buildLoginButton {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text("Or"),
          ),
          Container(
            margin: EdgeInsets.only(bottom:70),
            width: 350,
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LogInPage()));
              },
              child: Text(
                "LogIn",
                style: TextStyle(color: Colors.white),
              ),
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

  _isEmail(String email){
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  _isPhoneNumber(String phoneNumber){
    if (phoneNumber.length == 9 || phoneNumber.length == 10) {
      return true;
    } else {
      return false;
    }
  }

  _validatePassword(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(value) && value.length >= 6){
      return true;
    } else {
      return false;
    }
  }

  _showSnackBar(String text){
    var snackbar = SnackBar(
      content: Container(
        height: 50,
        child: Center(child: Text(text)),
      ),
    );
    _keyScaffold.currentState.showSnackBar(snackbar);
  }


}
