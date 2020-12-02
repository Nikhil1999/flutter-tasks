import 'package:flutter/material.dart';

import '../model/class_model.dart';
import '../model/user_model.dart';
import '../util/constants.dart';
import '../util/string_assets.dart';
import '../widget/user_card.dart';

class ClassDetailScreen extends StatefulWidget {
  final ClassModel _classModel;

  ClassDetailScreen(this._classModel);

  @override
  _ClassDetailScreenState createState() => _ClassDetailScreenState();
}

class _ClassDetailScreenState extends State<ClassDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width, _height = _size.height;

    Future<void> _showAddMembersDialog() async {
      List<UserModel> userList = await UserModel.getUserList(context);
      showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: _width * 0.05, vertical: _height * 0.02),
          child: StatefulBuilder(
            builder: (context, dialogSetState) => Container(
              margin: EdgeInsets.symmetric(
                  horizontal: _width * 0.05, vertical: _height * 0.02),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              StringAssets.members,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Flexible(
                            child: Text(
                              widget._classModel.userList.length.toString() +
                                  ' ' +
                                  StringAssets.people,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 14.0, letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: _height * 0.025, bottom: _height * 0.015),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            textAlignVertical: TextAlignVertical.center,
                            onChanged: (value) async {
                              userList.clear();
                              List<UserModel> myList =
                                  await UserModel.getUserList(context);
                              if (value != null && value.length >= 1) {
                                for (UserModel i in myList) {
                                  if (i.name
                                      .toLowerCase()
                                      .contains(value.toLowerCase())) {
                                    userList.add(i);
                                  }
                                }
                              } else {
                                userList.addAll(myList);
                              }
                              dialogSetState(() {});
                            },
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(fontSize: 16.0),
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 5.0),
                              isDense: true,
                              prefixIcon: SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: Container(
                                  padding: EdgeInsets.all(12.0),
                                  child: Image.asset(Constants.searchImageURL),
                                ),
                              ),
                              hintText: StringAssets.searchPeople,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black.withAlpha(50),
                                    width: 0.50),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.black, width: 0.50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: BouncingScrollPhysics(),
                        itemCount: userList.length,
                        itemBuilder: (context, index) => UserCard(
                            userModel: userList[index],
                            canAdd: !widget._classModel.userList
                                .contains(userList[index].id),
                            onPressed: () {
                              widget._classModel.userList
                                  .add(userList[index].id);
                              dialogSetState(() {});
                              setState(() {});
                            })),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, widget._classModel);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(widget._classModel.imageURL),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: _width * 0.05, vertical: _height * 0.02),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              widget._classModel.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Text(
                              widget._classModel.type,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              StringAssets.coach,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Text(
                              widget._classModel.coach,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 12.0, letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              StringAssets.time,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5),
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Flexible(
                            child: Text(
                              widget._classModel.timing,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(fontSize: 12.0, letterSpacing: 0.5),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      InkWell(
                        onTap: () => _showAddMembersDialog(),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Text(
                          widget._classModel.userList.length.toString() +
                              ' ' +
                              StringAssets.people,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
