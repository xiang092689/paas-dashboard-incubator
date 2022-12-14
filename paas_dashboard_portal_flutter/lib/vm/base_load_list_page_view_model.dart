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

typedef Converter = DataRow Function(dynamic item);

abstract class BaseLoadListPageViewModel<T> extends DataTableSource {
  bool loading = true;

  Exception? loadException;

  Exception? opException;

  List<T> displayList = <T>[];

  List<T> fullList = <T>[];

  Converter? converter;

  void setDataConverter(Converter converter) {
    this.converter = converter;
  }

  /// call loadSuccess to set loading to false and clear the exceptions
  void loadSuccess() {
    loading = false;
    loadException = null;
  }

  @override
  DataRow? getRow(int index) {
    if (converter == null) {
      return null;
    }
    var item = displayList[index];
    return converter!(item);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => displayList.length;

  @override
  int get selectedRowCount => 0;
}
