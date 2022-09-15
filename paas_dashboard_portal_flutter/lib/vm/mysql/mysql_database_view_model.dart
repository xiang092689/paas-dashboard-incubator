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

import 'package:paas_dashboard_portal_flutter/api/mysql/mysql_databases_api.dart';
import 'package:paas_dashboard_portal_flutter/module/mysql/mysql_database.dart';
import 'package:paas_dashboard_portal_flutter/persistent/po/mysql_instance_po.dart';
import 'package:paas_dashboard_portal_flutter/vm/base_load_list_page_view_model.dart';

class MysqlDatabaseViewModel extends BaseLoadListPageViewModel<DatabaseResp> {
  List<DatabaseResp> instance = <DatabaseResp>[];

  final MysqlInstancePo mysqlInstancePo;

  MysqlDatabaseViewModel(this.mysqlInstancePo);

  int get id {
    return mysqlInstancePo.id;
  }

  String get name {
    return mysqlInstancePo.name;
  }

  String get host {
    return mysqlInstancePo.host;
  }

  String get username {
    return mysqlInstancePo.username;
  }

  String get password {
    return mysqlInstancePo.password;
  }

  int get port {
    return mysqlInstancePo.port;
  }

  Future<void> fetchMysqlDatabase() async {
    try {
      fullList = await MysqlDatabaseApi.getDatabaseList(host, port, username, password);
      displayList = fullList;
      loadSuccess();
    } on Exception catch (e) {
      loadException = e;
      loading = false;
    }
    notifyListeners();
  }

  Future<void> filter(String str) async {
    notifyListeners();
  }
}
