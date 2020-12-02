import 'package:flutter/material.dart';
import 'package:task_10_nikhil/model/user_model.dart';
import 'package:task_10_nikhil/util/string_assets.dart';

class UserCard extends StatelessWidget {
  final UserModel userModel;
  final bool canAdd;
  final VoidCallback onPressed;

  UserCard(
      {@required this.userModel,
      @required this.canAdd,
      @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    double _width = _size.width;

    return Card(
      elevation: 0.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(right: 2.0),
              child: CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(userModel.imageURL),
                backgroundColor: Colors.black.withAlpha(50),
              ),
            ),
          ),
          Expanded(
            flex: (canAdd) ? 6 : 9,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
              child: Text(
                userModel.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(letterSpacing: 0.5),
              ),
            ),
          ),
          (!canAdd)
              ? Container()
              : Expanded(
                  flex: 3,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: SizedBox(
                          width: _width,
                          height: 30.0,
                          child: Container(
                            margin: EdgeInsets.only(left: 8.0),
                            child: RaisedButton(
                              elevation: 0.0,
                              color: Colors.white,
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(0xFF3C6DEE), width: 0.75),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              onPressed: () => onPressed(),
                              child: Text(
                                StringAssets.add.toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                        fontSize: 12.0,
                                        color: Color(0xFF3C6DEE)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
