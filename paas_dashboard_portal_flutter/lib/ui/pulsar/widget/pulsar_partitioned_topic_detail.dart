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
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_topic.dart';
import 'package:paas_dashboard_portal_flutter/route/page_route_const.dart';
import 'package:paas_dashboard_portal_flutter/ui/util/exception_util.dart';
import 'package:paas_dashboard_portal_flutter/ui/util/spinner_util.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_partitioned_topic_detail_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_topic_view_model.dart';
import 'package:provider/provider.dart';

class PulsarPartitionedTopicDetailWidget extends StatefulWidget {
  const PulsarPartitionedTopicDetailWidget();

  @override
  State<StatefulWidget> createState() {
    return PulsarPartitionedTopicDetailWidgetState();
  }
}

class PulsarPartitionedTopicDetailWidgetState extends State<PulsarPartitionedTopicDetailWidget> {
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<PulsarPartitionedTopicDetailViewModel>(context, listen: false);
    vm.fetchPartitions();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PulsarPartitionedTopicDetailViewModel>(context);
    if (vm.loading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SpinnerUtil.create();
      });
    }
    ExceptionUtil.processLoadException(vm, context);
    ExceptionUtil.processOpException(vm, context);
    var partitionsFuture = SingleChildScrollView(
      child: DataTable(
          showCheckboxColumn: false,
          columns: const [
            DataColumn(label: Text('TopicName')),
            DataColumn(label: Text('BacklogSize')),
          ],
          rows: vm.displayList
              .map((itemRow) => DataRow(
                      onSelectChanged: (bool? selected) {
                        var split = itemRow.topicName.split("/");
                        var topicResp = TopicResp(split[split.length - 1]);
                        Navigator.pushNamed(context, PageRouteConst.PulsarTopic,
                            arguments:
                                PulsarTopicViewModel(vm.pulsarInstancePo, vm.tenantResp, vm.namespaceResp, topicResp));
                      },
                      cells: [
                        DataCell(
                          SelectableText(itemRow.topicName),
                        ),
                        DataCell(
                          Text(itemRow.backlogSize.toString()),
                        ),
                      ]))
              .toList()),
    );
    var refreshButton = TextButton(
        onPressed: () {
          vm.fetchPartitions();
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
        Text(
          S.of(context).consumerList,
          style: const TextStyle(fontSize: 22),
        ),
        partitionsFuture,
      ],
    );
    return body;
  }
}
