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
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_topic_consumer_view_model.dart';
import 'package:provider/provider.dart';

class PulsarTopicConsumerWidget extends StatefulWidget {
  PulsarTopicConsumerWidget();

  @override
  State<StatefulWidget> createState() {
    return new PulsarTopicConsumerWidgetState();
  }
}

class PulsarTopicConsumerWidgetState extends State<PulsarTopicConsumerWidget> {
  @override
  void initState() {
    super.initState();
    final vm = Provider.of<PulsarTopicConsumerViewModel>(context, listen: false);
    vm.fetchConsumers();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<PulsarTopicConsumerViewModel>(context);
    if (vm.loading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        SpinnerUtil.create();
      });
    }
    ExceptionUtil.processLoadException(vm, context);
    ExceptionUtil.processOpException(vm, context);
    var consumerFuture = SingleChildScrollView(
      child: DataTable(
          showCheckboxColumn: false,
          columns: [
            DataColumn(label: Text('SubscriptionName')),
            DataColumn(label: Text('ConsumerName')),
            DataColumn(label: Text('MsgRateOut')),
            DataColumn(label: Text('MsgThroughputOut')),
            DataColumn(label: Text('AvailablePermits')),
            DataColumn(label: Text('UnackedMessages')),
            DataColumn(label: Text('LastConsumedTimestamp')),
            DataColumn(label: Text('ClientVersion')),
            DataColumn(label: Text('Address')),
          ],
          rows: vm.displayList
              .map((data) => DataRow(cells: [
                    DataCell(
                      Text(data.subscriptionName),
                    ),
                    DataCell(
                      Text(data.consumerName),
                    ),
                    DataCell(
                      Text(data.rateOut.toString()),
                    ),
                    DataCell(
                      Text(data.throughputOut.toString()),
                    ),
                    DataCell(
                      Text(data.availablePermits.toString()),
                    ),
                    DataCell(
                      Text(data.unackedMessages.toString()),
                    ),
                    DataCell(
                      Text(data.lastConsumedTimestamp.toString()),
                    ),
                    DataCell(
                      Text(data.clientVersion.toString()),
                    ),
                    DataCell(
                      Text(data.address.toString()),
                    ),
                  ]))
              .toList()),
    );
    var refreshButton = TextButton(
        onPressed: () {
          vm.fetchConsumers();
        },
        child: Text(S.of(context).refresh));
    var body = ListView(
      children: <Widget>[
        Container(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            children: [refreshButton],
          ),
        ),
        Text(
          S.of(context).consumerList,
          style: TextStyle(fontSize: 22),
        ),
        consumerFuture,
      ],
    );
    return body;
  }
}
