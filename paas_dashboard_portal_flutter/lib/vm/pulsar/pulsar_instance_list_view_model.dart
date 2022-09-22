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
import 'package:paas_dashboard_portal_flutter/api/pulsar/pulsar_instance_api.dart';
import 'package:paas_dashboard_portal_flutter/vm/pulsar/pulsar_instance_view_model.dart';

class PulsarInstanceListViewModel extends ChangeNotifier {
  List<PulsarInstanceViewModel> instances = <PulsarInstanceViewModel>[];

  Future<void> fetchPulsarInstances() async {
    final results = await PulsarInstanceApi.pulsarInstances();
    instances = results.map((e) => PulsarInstanceViewModel(e)).toList();
    notifyListeners();
  }

  Future<void> createPulsar(
      String name,
      String host,
      int port,
      String functionHost,
      int functionPort,
      bool enableTls,
      bool functionEnableTls,
      String caFile,
      String clientCertFile,
      String clientKeyFile,
      String clientKeyPassword) async {
    PulsarInstanceApi.savePulsar(name, host, port, functionHost, functionPort, enableTls, functionEnableTls, caFile,
        clientCertFile, clientKeyFile, clientKeyPassword);
    fetchPulsarInstances();
  }

  Future<void> updatePulsar(
      String id,
      String name,
      String host,
      int port,
      String functionHost,
      int functionPort,
      bool enableTls,
      bool functionEnableTls,
      String caFile,
      String clientCertFile,
      String clientKeyFile,
      String clientKeyPassword) async {
    PulsarInstanceApi.updatePulsar(id, name, host, port, functionHost, functionPort, enableTls, functionEnableTls,
        caFile, clientCertFile, clientKeyFile, clientKeyPassword);
    fetchPulsarInstances();
  }

  Future<void> deletePulsar(String id) async {
    PulsarInstanceApi.deletePulsar(id);
    fetchPulsarInstances();
  }
}
