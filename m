Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82CD427AB08
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgI1Jod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 05:44:33 -0400
Received: from mga18.intel.com ([134.134.136.126]:54873 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgI1Joc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 05:44:32 -0400
IronPort-SDR: G5RQyBo3cHUpk9UQf6tAWJ0+ZK9XrkbWYSzXS8OpWc1ItOZr/Z0y5ZoLFunQas27cQJONaXkAE
 c1J41KN6X6YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149740305"
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="149740305"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 02:44:30 -0700
IronPort-SDR: 0ARYG3UE0JMEzlYfCZZgNG3izp33WoZR29KyGQ64QuDV9v3QeYvTHeYcdy6PZ0nZRd/LSrye5M
 xZ9OBKrjNzDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,313,1596524400"; 
   d="scan'208";a="293822820"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 28 Sep 2020 02:44:27 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 1/2] Add DT bindings schema for PVT controller
Date:   Mon, 28 Sep 2020 17:44:18 +0800
Message-Id: <f3f977389f74f416a70b7f5276243cf722ba6fee.1601285307.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
References: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
References: <cover.1601285307.git.rahul.tanwar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PVT controller (MR75203) is used to configure & control
Moortec embedded analog IP which contains temprature sensor(TS),
voltage monitor(VM) & process detector(PD) modules.

Add DT bindings schema for PVT controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
new file mode 100644
index 000000000000..858888461bfe
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/moortec,mr75203.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Moortec Semiconductor MR75203 PVT Controller bindings
+
+maintainers:
+  - Rahul Tanwar <rtanwar@maxlinear.com>
+
+properties:
+  compatible:
+    const: moortec,mr75203
+
+  reg:
+    items:
+      - description: PVT common registers
+      - description: PVT temprature sensor registers
+      - description: PVT process detector registers
+      - description: PVT voltage monitor registers
+
+  reg-names:
+    items:
+      - const: common
+      - const: ts
+      - const: pd
+      - const: vm
+
+  vm-map:
+    description:
+      PVT controller has 5 VM (voltage monitor) sensors.
+      vm-map defines CPU core to VM instance mapping. A
+      value of 0xff means that VM sensor is unused.
+    maxItems: 5
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - vm-map
+  - clocks
+  - resets
+  - "#thermal-sensor-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    pvt: pvt@e0680000 {
+        compatible = "moortec,mr75203";
+        reg = <0xe0680000 0x80
+               0xe0680080 0x180
+               0xe0680200 0x200
+               0xe0680400 0xc00>;
+        reg-names = "common", "ts", "pd", "vm";
+        vm-map = [03 01 04 ff ff];
+        clocks = <&osc0>;
+        resets = <&rcu0 0x40 7>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.11.0

