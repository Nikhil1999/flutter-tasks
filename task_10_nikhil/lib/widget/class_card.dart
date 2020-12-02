import 'package:flutter/material.dart';

import '../model/class_model.dart';
import '../util/string_assets.dart';

class ClassCard extends StatelessWidget {
  final ClassModel classModel;
  final VoidCallback onPressed;

  ClassCard({@required this.classModel, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black.withAlpha(50), width: 0.5),
          borderRadius: BorderRadius.circular(4.0)),
      child: InkWell(
        onTap: () => onPressed(),
        borderRadius: BorderRadius.circular(4.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 25.0,
                  backgroundImage: NetworkImage(classModel.imageURL),
                  backgroundColor: Colors.black.withAlpha(50),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringAssets.coach,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            classModel.coach,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          StringAssets.time,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5),
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Flexible(
                          child: Text(
                            classModel.timing,
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
                    Text(
                      classModel.userList.length.toString() +
                          ' ' +
                          StringAssets.people,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2
                          .copyWith(fontSize: 12.0, letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                      child: Text(
                        classModel.type,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
