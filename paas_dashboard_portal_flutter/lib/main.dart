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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:paas_dashboard_portal_flutter/generated/l10n.dart';
import 'package:paas_dashboard_portal_flutter/route/page_route_const.dart';
import 'package:paas_dashboard_portal_flutter/route/route_gen.dart';
import 'package:paas_dashboard_portal_flutter/ui/bk/bk_page.dart';
import 'package:paas_dashboard_portal_flutter/ui/general/author_screen.dart';
import 'package:paas_dashboard_portal_flutter/ui/general/settings_screen.dart';
import 'package:paas_dashboard_portal_flutter/ui/home/home_page.dart';
import 'package:paas_dashboard_portal_flutter/ui/kubernetes/k8s_page.dart';
import 'package:paas_dashboard_portal_flutter/ui/mongo/mongo_page.dart';
import 'package:paas_dashboard_portal_flutter/ui/mysql/mysql_page.dart';
import 'package:paas_dashboard_portal_flutter/ui/pulsar/pulsar_page.dart';
import 'package:paas_dashboard_portal_flutter/ui/redis/redis_page.dart';
import 'package:paas_dashboard_portal_flutter/vm/bk/bk_instance_list_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/general/settings_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/kubernetes/k8s_instance_list_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mongo/mongo_database_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mongo/mongo_instance_list_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mongo/mongo_instance_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mongo/mongo_table_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_instance_list_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_instance_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_sql_query_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_table_column_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_table_data_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_table_index_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/mysql/mysql_table_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_instance_list_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_instance_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_namespace_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_partitioned_topic_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_sink_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_source_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_tenant_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_topic_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/redis/redis_instance_list_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/redis/redis_instance_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Paas Dashboard',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: PageRouteConst.Root,
      routes: {
        PageRouteConst.Root: (context) => HomePage(),
        PageRouteConst.Author: (context) => AuthorScreen(),
        PageRouteConst.Bookkeeper: (context) => ChangeNotifierProvider(
              create: (context) => BkInstanceListViewModel(),
              child: BkPage(),
            ),
        PageRouteConst.Kubernetes: (context) => ChangeNotifierProvider(
              create: (context) => K8sInstanceListViewModel(),
              child: K8sPage(),
            ),
        PageRouteConst.Mongo: (context) => ChangeNotifierProvider(
              create: (context) => MongoInstanceListViewModel(),
              child: MongoPage(),
            ),
        PageRouteConst.Mysql: (context) => ChangeNotifierProvider(
              create: (context) => MysqlInstanceListViewModel(),
              child: MysqlPage(),
            ),
        PageRouteConst.Pulsar: (context) => ChangeNotifierProvider(
              create: (context) => PulsarInstanceListViewModel(),
              child: PulsarPage(),
            ),
        PageRouteConst.Redis: (context) => ChangeNotifierProvider(
              create: (context) => RedisInstanceListViewModel(),
              child: RedisPage(),
            ),
        PageRouteConst.Settings: (context) => ChangeNotifierProvider(
              create: (context) => SettingsViewModel(),
              child: SettingsScreen(),
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == PageRouteConst.MongoInstance) {
          final args = settings.arguments as MongoInstanceViewModel;
          return RouteGen.mongoInstance(args);
        }
        if (settings.name == PageRouteConst.MongoDatabase) {
          final args = settings.arguments as MongoDatabaseViewModel;
          return RouteGen.mongoDatabase(args);
        }
        if (settings.name == PageRouteConst.MongoTable) {
          final args = settings.arguments as MongoTableViewModel;
          return RouteGen.mongoTableData(args);
        }
        if (settings.name == PageRouteConst.MysqlInstance) {
          final args = settings.arguments as MysqlInstanceViewModel;
          return RouteGen.mysqlInstance(args);
        }
        if (settings.name == PageRouteConst.MysqlDatabase) {
          final args = settings.arguments as MysqlTablesViewModel;
          return RouteGen.mysqlTables(args);
        }
        if (settings.name == PageRouteConst.MysqlSql) {
          final args = settings.arguments as MysqlSqlQueryViewModel;
          return RouteGen.mysqlSql(args);
        }
        if (settings.name == PageRouteConst.MysqlTable) {
          final args = settings.arguments as MysqlTableDataViewModel;
          return RouteGen.mysqlTableData(args);
        }
        if (settings.name == PageRouteConst.MysqlTableColumn) {
          final args = settings.arguments as MysqlTableColumnViewModel;
          return RouteGen.mysqlTableColumn(args);
        }
        if (settings.name == PageRouteConst.MysqlTableIndex) {
          final args = settings.arguments as MysqlTableIndexViewModel;
          return RouteGen.mysqlTableIndex(args);
        }
        if (settings.name == PageRouteConst.PulsarInstance) {
          final args = settings.arguments as PulsarInstanceViewModel;
          return RouteGen.pulsarInstance(args);
        }
        if (settings.name == PageRouteConst.PulsarTenant) {
          final args = settings.arguments as PulsarTenantViewModel;
          return RouteGen.pulsarTenant(args);
        }
        if (settings.name == PageRouteConst.PulsarNamespace) {
          final args = settings.arguments as PulsarNamespaceViewModel;
          return RouteGen.pulsarNamespace(args);
        }
        if (settings.name == PageRouteConst.PulsarPartitionedTopic) {
          final args = settings.arguments as PulsarPartitionedTopicViewModel;
          return RouteGen.pulsarPartitionedTopic(args);
        }
        if (settings.name == PageRouteConst.PulsarTopic) {
          final args = settings.arguments as PulsarTopicViewModel;
          return RouteGen.pulsarTopic(args);
        }
        if (settings.name == PageRouteConst.PulsarSource) {
          final args = settings.arguments as PulsarSourceViewModel;
          return RouteGen.pulsarSource(args);
        }
        if (settings.name == PageRouteConst.PulsarSink) {
          final args = settings.arguments as PulsarSinkViewModel;
          return RouteGen.pulsarSink(args);
        }
        if (settings.name == PageRouteConst.RedisInstance) {
          final args = settings.arguments as RedisInstanceViewModel;
          return RouteGen.redisInstance(args);
        }
        throw UnimplementedError();
      },
    );
  }
}
