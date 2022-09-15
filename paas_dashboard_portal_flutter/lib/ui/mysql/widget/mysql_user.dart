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
import 'package:paas_dashboard_portal_flutter/ui/util/exception_util.dart';
import 'package:paas_dashboard_portal_flutter/ui/util/spinner_util.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_instance_view_model.dart';
import 'package:provider/provider.dart';

class MysqlUserWidget extends StatefulWidget {
  const MysqlUserWidget();

  @override
  State<StatefulWidget> createState() {
    return MysqlUserState();
  }
}

class MysqlUserState extends State<MysqlUserWidget> {
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<MysqlInstanceViewModel>(context, listen: false);
    vm.fetchMysqlUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MysqlInstanceViewModel>(context);
    if (vm.loading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SpinnerUtil.create();
      });
    }
    ExceptionUtil.processLoadExceptionPageable(vm, context);
    ExceptionUtil.processOpExceptionPageable(vm, context);
    var dbsFuture = SingleChildScrollView(
      child: DataTable(
          showCheckboxColumn: false,
          columns: [DataColumn(label: Text(S.of(context).userName))],
          rows: vm.displayList
              .map((data) => DataRow(cells: [
                    DataCell(
                      Text(data),
                    )
                  ]))
              .toList()),
    );
    var refreshButton = TextButton(
        onPressed: () {
          vm.fetchMysqlUser();
        },
        child: Text(S.of(context).refresh));
    var body = ListView(
      children: <Widget>[
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [refreshButton],
          ),
        ),
        const Text(
          'Mysql User Name',
          style: TextStyle(fontSize: 22),
        ),
        dbsFuture
      ],
    );

    return body;
  }
}
