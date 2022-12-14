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
import 'package:paas_dashboard_portal_flutter/api/k8s/kubernetes_instance_api.dart';
import 'package:paas_dashboard_portal_flutter/module/ssh/ssh_step.dart';
import 'package:paas_dashboard_portal_flutter/vm/kubernetes/k8s_instance_view_model.dart';

class K8sInstanceListViewModel extends ChangeNotifier {
  List<K8sInstanceViewModel> instances = <K8sInstanceViewModel>[];

  Future<void> fetchKubernetesInstances() async {
    final results = await K8sInstanceApi.kubernetesInstances();
    instances = results.map((e) => K8sInstanceViewModel(e)).toList();
    notifyListeners();
  }

  Future<void> createKubernetesSsh(String name, SshStep sshStep) async {
    K8sInstanceApi.saveKubernetesSsh(name, [sshStep]);
    fetchKubernetesInstances();
  }

  Future<void> deleteKubernetes(int id) async {
    K8sInstanceApi.deleteKubernetes(id);
    fetchKubernetesInstances();
  }
}
