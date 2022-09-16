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
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_source.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_tenant.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_instance_po.dart';
import 'package:paas_dashboard_portal_flutter/vm/base_load_view_model.dart';

class PulsarSourceBasicViewModel extends BaseLoadViewModel {
  final PulsarInstanceDto pulsarInstancePo;
  final TenantResp tenantResp;
  final NamespaceResp namespaceResp;
  final SourceResp sourceResp;
  String topicName = "";
  Map configs = {};
  String archive = "";

  PulsarSourceBasicViewModel(this.pulsarInstancePo, this.tenantResp, this.namespaceResp, this.sourceResp);

  PulsarSourceBasicViewModel deepCopy() {
    return PulsarSourceBasicViewModel(
        pulsarInstancePo.deepCopy(), tenantResp.deepCopy(), namespaceResp.deepCopy(), sourceResp.deepCopy());
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

  String get tenant {
    return tenantResp.tenant;
  }

  String get namespace {
    return namespaceResp.namespace;
  }

  String get sourceName {
    return sourceResp.sourceName;
  }

  Future<void> fetch() async {
    try {
      final SourceConfigResp sourceConfigResp = await PulsarSourceApi.getSource(
          id, host, port, pulsarInstancePo.createFunctionTlsContext(), tenant, namespace, sourceName);
      topicName = sourceConfigResp.topicName;
      configs = sourceConfigResp.configs;
      archive = sourceConfigResp.archive;
      loadSuccess();
    } on Exception catch (e) {
      loadException = e;
      loading = false;
    }
    notifyListeners();
  }
}
