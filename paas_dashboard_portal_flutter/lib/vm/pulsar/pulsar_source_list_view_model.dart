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

import 'package:paas_dashboard_portal_flutter/api/pulsar/pulsar_source_api.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_namespace.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_tenant.dart';
import 'package:paas_dashboard_portal_flutter/persistent/po/pulsar_instance_po.dart';
import 'package:paas_dashboard_portal_flutter/vm/base_load_list_page_view_model.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_source_view_model.dart';

class PulsarSourceListViewModel extends BaseLoadListPageViewModel<PulsarSourceViewModel> {
  final PulsarInstancePo pulsarInstancePo;
  final TenantResp tenantResp;
  final NamespaceResp namespaceResp;

  PulsarSourceListViewModel(this.pulsarInstancePo, this.tenantResp, this.namespaceResp);

  PulsarSourceListViewModel deepCopy() {
    return new PulsarSourceListViewModel(pulsarInstancePo.deepCopy(), tenantResp.deepCopy(), namespaceResp.deepCopy());
  }

  int get id {
    return this.pulsarInstancePo.id;
  }

  String get name {
    return this.pulsarInstancePo.name;
  }

  String get host {
    return this.pulsarInstancePo.host;
  }

  int get port {
    return this.pulsarInstancePo.port;
  }

  String get functionHost {
    return this.pulsarInstancePo.functionHost;
  }

  int get functionPort {
    return this.pulsarInstancePo.functionPort;
  }

  String get tenant {
    return this.tenantResp.tenant;
  }

  String get namespace {
    return this.namespaceResp.namespace;
  }

  Future<void> createSource(String sourceName, String outputTopic, String sourceType, String config) async {
    try {
      await PulsarSourceApi.createSource(id, functionHost, functionPort, pulsarInstancePo.createFunctionTlsContext(),
          tenant, namespace, sourceName, outputTopic, sourceType, config);
      await fetchSources();
    } on Exception catch (e) {
      opException = e;
      notifyListeners();
    }
  }

  Future<void> fetchSources() async {
    try {
      final results = await PulsarSourceApi.getSourceList(
          id, functionHost, functionPort, pulsarInstancePo.createFunctionTlsContext(), tenant, namespace);
      this.fullList =
          results.map((e) => PulsarSourceViewModel(pulsarInstancePo, tenantResp, namespaceResp, e)).toList();
      this.displayList = this.fullList;
      loadSuccess();
    } on Exception catch (e) {
      loadException = e;
      loading = false;
    }
    notifyListeners();
  }

  Future<void> filter(String str) async {
    if (str == "") {
      this.displayList = this.fullList;
      notifyListeners();
      return;
    }
    if (!loading && loadException == null) {
      this.displayList = this.fullList.where((element) => element.sourceName.contains(str)).toList();
    }
    notifyListeners();
  }

  Future<void> deleteSource(String topic) async {
    try {
      await PulsarSourceApi.deleteSource(
          id, functionHost, functionPort, pulsarInstancePo.createFunctionTlsContext(), tenant, namespace, topic);
      await fetchSources();
    } on Exception catch (e) {
      opException = e;
      notifyListeners();
    }
  }
}
