import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_10_nikhil/model/user_model.dart';
import 'package:task_10_nikhil/screen/sign_in_screen.dart';
import 'package:task_10_nikhil/util/constants.dart';

import '../model/class_model.dart';
import '../screen/class_detail_screen.dart';
import '../util/string_assets.dart';
import '../widget/class_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<ClassModel> _classList = [];

  Future<List<ClassModel>> _getClassList() async {
    if (_classList.length == 0) {
      _classList.addAll(await ClassModel.getClassList(context));
    }
    return _classList;
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width, _height = _size.height;

    Future<void> _logout() async {
      await UserModel.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
        ),
      );
    }

    Future<void> _navigateToClassDetail(int index) async {
      _classList[index] = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ClassDetailScreen(_classList[index]),
        ),
      ) as ClassModel;
      setState(() {});
    }

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: _getClassList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Theme(
                data:
                    Theme.of(context).copyWith(primaryColor: Color(0xFF3C6DEE)),
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError &&
              snapshot.hasData) {
            return CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  expandedHeight: _height * 0.25,
                  stretch: true,
                  backgroundColor: Color(0xFF3C6DEE),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      Constants.dashboardImageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                  leading: IconButton(
                    onPressed: () => SystemNavigator.pop(),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  actions: [
                    Container(
                      padding: EdgeInsets.only(right: 4.0),
                      child: IconButton(
                        onPressed: () => _logout(),
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: _height * 0.025,
                      bottom: _height * 0.01,
                      left: _width * 0.035,
                      right: _width * 0.035,
                    ),
                    child: Text(
                      StringAssets.availableClasses,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: _width * 0.025),
                      child: ClassCard(
                        classModel: _classList[index],
                        onPressed: () => _navigateToClassDetail(index),
                      ),
                    ),
                    childCount: _classList.length,
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
