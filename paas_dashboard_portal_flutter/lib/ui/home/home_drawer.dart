//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.
//

import 'package:flutter/material.dart';
import 'package:paas_dashboard_portal_flutter/generated/l10n.dart';
import 'package:paas_dashboard_portal_flutter/route/page_route_const.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('assets/images/background/joy_valley_slide.png'))),
            child: Text(
              'Dashboard',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          ListTile(
            title: Text(S.of(context).aboutAuthor),
            onTap: () => {Navigator.of(context).pushNamed(PageRouteConst.Author)},
          ),
          ListTile(
            title: Text(S.of(context).settings),
            onTap: () => {Navigator.of(context).pushNamed(PageRouteConst.Settings)},
          ),
        ],
      ),
    );
  }
}
