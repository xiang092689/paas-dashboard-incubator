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

import 'package:paas_dashboard_portal_flutter/api/tls_context.dart';

class PulsarConst {
  static const String defaultHost = "localhost";
  static const int defaultBrokerPort = 8080;
  static const int defaultFunctionPort = 6650;
  static const int defaultEnableTls = TlsContext.DIS_ENABLE_TLS;
  static const int defaultFunctionEnableTls = TlsContext.DIS_ENABLE_TLS;
  static const String defaultCaFile = "";
  static const String defaultClientCertFile = "";
  static const String defaultClientKeyFile = "";
  static const String defaultClientKeyPassword = "";
  static const String defaultProducerName = "flutter-dashboard-producer";
}
