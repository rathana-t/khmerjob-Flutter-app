import 'package:flutter/material.dart';
import 'package:khmerjob_project/pages/home_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double _widthOfScreen;

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: _buildAppBar,
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
        icon: Image.asset('assets/images/profile.png'), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfilePage()));
        });
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

  get _buildBody{
    return Container();
  }

}