import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khmerjob_project/models/job_model.dart';
import 'package:khmerjob_project/models/user_model.dart';
import 'package:khmerjob_project/pages/browse_job.dart';
import 'package:khmerjob_project/pages/login_page.dart';
import 'package:khmerjob_project/pages/profile_page.dart';
import 'package:khmerjob_project/repo/job_repo.dart';

class HomePage extends StatefulWidget {
  static UserElement user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _widthOfScreen;

  Future<Job> _jobData;

  @override
  void initState() {
    super.initState();
    _jobData = getJobsData();
  }

  @override
  Widget build(BuildContext context) {
    _widthOfScreen = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      drawer: _buildDrawer,
      appBar: _buildAppBar,
      body: _buildBody,
    );
  }

  // Start Drawer
  get _buildDrawer {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader,
//home page
          _buildMenuItem(
            title: "Home Page",
            icon: Icons.home,
            iconColor: Colors.red,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
//        Manage account
          _buildMenuItem(
            title: "My Account",
            icon: Icons.person,
            iconColor: Colors.red,
            onTap: () {
              //   Navigator.of(context).push(
            },
          ),
//        My Order
          _buildMenuItem(
            title: "My Orders",
            icon: Icons.shopping_basket,
            iconColor: Colors.red,
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => OrderPage()));
            },
          ),
//        category
          _buildMenuItem(
            title: "Category",
            icon: Icons.dashboard,
            iconColor: Colors.red,
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => CategoryMenuPage()));
            },
          ),
//        Favorite
          _buildMenuItem(
            title: "Favorite",
            icon: Icons.favorite,
            iconColor: Colors.red,
            onTap: () {
              // Navigator.of(context).push(
              //     MaterialPageRoute(builder: (context) => FavoritePage()));
            },
          ),
          Divider(),
          _buildMenuItem(
            title: "Setting",
            icon: Icons.settings,
            iconColor: Colors.grey,
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => SettingPage()));
            },
          ),
          _buildMenuItem(
            title: "About",
            icon: Icons.article,
            iconColor: Colors.blue,
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => AboutPage()));
            },
          ),
          Divider(),
          _buildMenuItem(
            title: "Log out",
            icon: Icons.logout,
            iconColor: Colors.grey,
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text(
                      "Are you sure to log out?",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    actions: [
                      MaterialButton(
                        child: Text(
                          "No",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      MaterialButton(
                        child: Text(
                          "Yes",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => LogInPage()));
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  get _buildDrawerHeader {
    return UserAccountsDrawerHeader(
      // onDetailsPressed: (){
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyAccountPage()));
      // },
      accountName: Text(
        '${HomePage.user.email}',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      accountEmail: Text(
        '0${HomePage.user.phone}',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
      currentAccountPicture: CircleAvatar(
        backgroundColor: Colors.white,
        child: Icon(Icons.person),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(50)),
        color: Colors.red,
      ),
    );
  }

  _buildMenuItem({String title,
    IconData icon,
    Color iconColor,
    Color titleColor,
    Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          icon,
          color: iconColor == null ? Colors.grey : iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 15,
            color: titleColor == null ? Colors.black : titleColor,
          ),
        ),
      ),
    );
  }

  get _buildAppBar {
    return AppBar(
      automaticallyImplyLeading: false,
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
            height: 32,
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
        icon: Image.asset('assets/images/profile.png'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ProfilePage()));
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

  get _buildBody {
    return Container(
      child: ListView(
        children: [
          _buildSearchJob,
          _buildBrowseJob,
          _buildJobFutureAPI,
        ],
      ),
    );
  }

  get _buildSearchJob {
    return Container(
      color: Colors.black87.withOpacity(0.8),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            "Find the Job in Cambodia",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            alignment: Alignment.center,
            child: Row(
              children: [
                _buildSearchFill,
                _buildSearchButton,
              ],
            ),
          )
        ],
      ),
    );
  }

  TextEditingController _searchCtr = TextEditingController();

  get _buildSearchFill {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: _widthOfScreen / 1.5,
      margin: EdgeInsets.fromLTRB(20, 5, 5, 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        controller: _searchCtr,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Search....",
        ),
        keyboardType: TextInputType.name,
      ),
      decoration: BoxDecoration(
        color: Colors.white70.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  get _buildSearchButton {
    return InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> BrowseJob() ));
        },
        child: Container(
          height: 50,
          width: 50,
          child: Icon(
            Icons.search,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white70.withOpacity(0.9),
          ),
        ));
  }

  get _buildBrowseJob {
    return Container(
      color: Colors.white60,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Browse Categories',
              style: TextStyle(
                fontSize: 20,
                // letterSpacing: 3,
              ),
            ),
          ),
          GridView(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              // mainAxisSpacing: 10,
              // crossAxisSpacing: 20,
            ),
            shrinkWrap: true,
            children: <Widget>[
              _buildIconCategory('assets/images/icons/management.png',
                  'Management', 'Management'),
              _buildIconCategory(
                  'assets/images/icons/cleaner.png', 'Cleaner', 'Cleaner'),
              _buildIconCategory('assets/images/icons/accounting.jpg',
                  'Accounting', 'Accounting'),
              _buildIconCategory('assets/images/icons/customer.png',
                  'Customer Service', 'Customer Service'),
              _buildIconCategory(
                  'assets/images/icons/lawyer.png', 'Lawyer', 'Lawyer'),
              _buildIconCategory(
                  'assets/images/icons/design.png', 'Design', 'Design'),
              _buildIconCategory('assets/images/icons/marketing.png',
                  'Marketing', 'Marketing'),
              _buildIconCategory(
                  'assets/images/icons/finance.jpg', 'Finance', 'Finance'),
              _buildIconCategory('assets/images/icons/education.png',
                  'Education', 'Education/Training'),
              _buildIconCategory('assets/images/icons/assistant.png',
                  'Assistant', 'Assistant'),
              _buildIconCategory(
                  'assets/images/icons/security.png', 'Security', 'Security'),
              _buildIconCategory('assets/images/icons/technology.jpg',
                  'Technology', 'Information Technology'),
              _buildIconCategory('assets/images/icons/cashier.png',
                  'Cashier Receptionist', 'Cashier Receptionist'),
              _buildIconCategory('assets/images/icons/architecture.png',
                  'Architecture', 'Architecture/Engineering'),
              _buildIconCategory(
                  'assets/images/icons/driver.png', 'Driver', 'Driver'),
              _buildIconCategory(
                  'assets/images/icons/other.png', 'Other', 'Other'),
            ],
          ),
        ],
      ),
    );
  }

  _buildIconCategory(String img, String title, String catego) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BrowseJob(catego)));
      },
      child: Container(
        // alignment: Alignment.center,
        // margin: EdgeInsets.all(0),
        child: Column(
          children: [
            Container(
              height: 50,
              // padding: EdgeInsets.only(top: 2),
              margin: EdgeInsets.only(bottom: 0),
              child: Image.asset(img),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 5),
                // alignment: Alignment.center,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  get _buildJobFutureAPI {
    return Container(
      child: FutureBuilder<Job>(
        future: _jobData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }
          if (snapshot.hasData) {
            return _buildJobs(snapshot.data.jobs);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  _buildJobs(List<JobElement> itemList) {
    return Container(
      alignment: Alignment.center,
      // color: Colors.lightBlueAccent,
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(top: 15),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 15),
            alignment: Alignment.center,
            child: Text(
              'Latest Jobs',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            width: _widthOfScreen,
            child: ListView.builder(
              // GridView.builder
              physics: NeverScrollableScrollPhysics(),
              // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //   crossAxisCount: 1,
              // mainAxisSpacing: 10,
              // crossAxisSpacing: 10,
              // ),
              itemCount: itemList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return _buildItemJob(itemList[index],index);
              },
            ),
          ),
        ],
      ),
    );
  }

// img, title, catogory, location, type, salary
  _buildItemJob(JobElement item,index) {
    return InkWell(
      onTap: () {
        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=> JobDetail() ));
      },
      child: Container(
        color: index.isEven ? Colors.lightBlueAccent.withOpacity(0.1) : Colors.white54.withOpacity(0.1),

        // width: 150,  useless
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.blueAccent,
              padding: EdgeInsets.all(2),
              width: 150,
              height: 130,
              margin: EdgeInsets.only(right: 10),
              child: Image.asset(
                'assets/images/jobs/' + item.image,
                fit: BoxFit.cover,
              ),
              // child: Image.asset('assets/images/jobs/jobImage/' + item.image),
            ),
            Expanded(
              child: Container(
                // padding: EdgeInsets.all(6),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Container(
                      // color: Colors.yellowAccent,
                      margin: EdgeInsets.only(bottom: 5),
                      alignment: Alignment.topLeft,
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        // strutStyle: StrutStyle(fontSize:12.0),
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 17,
                          ),
                          text: item.title,
                        ),
                      ),
                      // decoration: BoxDecoration(
                        // border:Bor
                        // color: Colors.blue,

                      // ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom:4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.category,
                            color: Colors.blue,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              // strutStyle: StrutStyle(fontSize:12.0),
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                text: item.category,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(bottom:4),
                      child: Row(
                        children: [
                          Icon(
                              Icons.location_on,
                            color: Colors.blue,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              // strutStyle: StrutStyle(fontSize:12.0),
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                text: item.location,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            color: Colors.blue,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5),
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              // strutStyle: StrutStyle(fontSize:12.0),
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 16,
                                ),
                                text: item.typeJob.toString().substring(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // width: 100,
                      alignment: Alignment.topRight,
                      margin: EdgeInsets.only(top:6,bottom:6),
                      child: Container(
                        alignment: Alignment.center,
                        height: 30,
                        width: 100,
                        // strutStyle: StrutStyle(fontSize:12.0),
                        child: Text("\$ " + item.salary,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                      ),

                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
