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

import 'package:paas_dashboard_portal_flutter/api/pulsar/pulsar_sink_api.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_namespace.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_tenant.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_instance_dto.dart';
import 'package:paas_dashboard_portal_flutter/vm/base_load_list_page_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_sink_view_model.dart';

class PulsarSinkListViewModel extends BaseLoadListPageViewModel<PulsarSinkViewModel> {
  final PulsarInstanceDto pulsarInstancePo;
  final TenantResp tenantResp;
  final NamespaceResp namespaceResp;

  PulsarSinkListViewModel(this.pulsarInstancePo, this.tenantResp, this.namespaceResp);

  PulsarSinkListViewModel deepCopy() {
    return PulsarSinkListViewModel(pulsarInstancePo.deepCopy(), tenantResp.deepCopy(), namespaceResp.deepCopy());
  }

  int get id {
    return pulsarInstancePo.id;
  }

  String get name {
    return pulsarInstancePo.name;
  }

  String get host {
    return pulsarInstancePo.host;
  }

  int get port {
    return pulsarInstancePo.port;
  }

  String get functionHost {
    return pulsarInstancePo.functionHost;
  }

  int get functionPort {
    return pulsarInstancePo.functionPort;
  }

  String get tenant {
    return tenantResp.tenant;
  }

  String get namespace {
    return namespaceResp.namespace;
  }

  Future<void> createSink(String sinkName, String subName, String inputTopic, String sinkType, String config) async {
    try {
      await PulsarSinkApi.createSink(id, functionHost, functionPort, pulsarInstancePo.createFunctionTlsContext(),
          tenant, namespace, sinkName, subName, inputTopic, sinkType, config);
      await fetchSinks();
    } on Exception catch (e) {
      opException = e;
      notifyListeners();
    }
  }

  Future<void> fetchSinks() async {
    try {
      final results = await PulsarSinkApi.getSinkList(
          id, functionHost, functionPort, pulsarInstancePo.createFunctionTlsContext(), tenant, namespace);
      fullList = results.map((e) => PulsarSinkViewModel(pulsarInstancePo, tenantResp, namespaceResp, e)).toList();
      displayList = fullList;
      loadSuccess();
    } on Exception catch (e) {
      loadException = e;
      loading = false;
    }
    notifyListeners();
  }

  Future<void> filter(String str) async {
    if (str == "") {
      displayList = fullList;
      notifyListeners();
      return;
    }
    if (!loading && loadException == null) {
      displayList = fullList.where((element) => element.sinkName.contains(str)).toList();
    }
    notifyListeners();
  }

  Future<void> deleteSink(String name) async {
    try {
      await PulsarSinkApi.deleteSink(
          id, functionHost, functionPort, pulsarInstancePo.createFunctionTlsContext(), tenant, namespace, name);
      await fetchSinks();
    } on Exception catch (e) {
      opException = e;
      notifyListeners();
    }
  }
}
