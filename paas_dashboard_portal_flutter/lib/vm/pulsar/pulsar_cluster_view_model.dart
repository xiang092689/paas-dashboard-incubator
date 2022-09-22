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

import 'package:paas_dashboard_portal_flutter/api/pulsar/pulsar_cluster_api.dart';
import 'package:paas_dashboard_portal_flutter/api/tls_context.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_cluster.dart';
import 'package:paas_dashboard_portal_flutter/module/pulsar/pulsar_instance_dto.dart';
import 'package:paas_dashboard_portal_flutter/vm/base_load_list_page_view_model.dart';

class PulsarClusterViewModel extends BaseLoadListPageViewModel<ClusterResp> {
  List<ClusterResp> instances = <ClusterResp>[];

  final PulsarInstanceDto pulsarInstancePo;

  PulsarClusterViewModel(this.pulsarInstancePo);

  String get id {
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

  Future<void> fetchPulsarCluster() async {
    try {
      TlsContext tlsContext = TlsContext(pulsarInstancePo.enableTls, pulsarInstancePo.caFile,
          pulsarInstancePo.clientCertFile, pulsarInstancePo.clientKeyFile, pulsarInstancePo.clientKeyPassword);
      fullList = await PulsarClusterApi.cluster(id, host, port, tlsContext);
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
