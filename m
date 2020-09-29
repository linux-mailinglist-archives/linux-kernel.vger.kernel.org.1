Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFB127C04C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgI2I7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:59:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:45261 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgI2I7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:59:50 -0400
IronPort-SDR: IZEbAUlJ+UWeExcAt1NiESanrcsUnwL23WRFzCdauOGKwwZN+goc+hM+X11CYUr9U7UWcFkjfo
 d07IsXESaPtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="226293937"
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="226293937"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2020 01:59:49 -0700
IronPort-SDR: nHtlA8hLGlhHoj+bHl61FL1nPI68UHr/d2JCjS3Cu+G/5C2xWv3amQrE9WrqZASSoov9bZEhKl
 x6MzzKUDqwwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,317,1596524400"; 
   d="scan'208";a="294187885"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 29 Sep 2020 01:59:46 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v3 1/2] Add DT bindings schema for PVT controller
Date:   Tue, 29 Sep 2020 16:59:37 +0800
Message-Id: <b540b49ca47d75c5f716f8a4e4eed0664a1116bf.1601369789.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1601369789.git.rahul.tanwar@linux.intel.com>
References: <cover.1601369789.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1601369789.git.rahul.tanwar@linux.intel.com>
References: <cover.1601369789.git.rahul.tanwar@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PVT controller (MR75203) is used to configure & control
Moortec embedded analog IP which contains temprature sensor(TS),
voltage monitor(VM) & process detector(PD) modules.

Add DT bindings schema for PVT controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
new file mode 100644
index 000000000000..6f3e3c01f717
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/moortec,mr75203.yaml
@@ -0,0 +1,71 @@
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
+  intel,vm-map:
+    description:
+      PVT controller has 5 VM (voltage monitor) sensors.
+      vm-map defines CPU core to VM instance mapping. A
+      value of 0xff means that VM sensor is unused.
+    $ref: /schemas/types.yaml#definitions/uint8-array
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
+  - intel,vm-map
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
+        reg = <0xe0680000 0x80>,
+              <0xe0680080 0x180>,
+              <0xe0680200 0x200>,
+              <0xe0680400 0xc00>;
+        reg-names = "common", "ts", "pd", "vm";
+        intel,vm-map = [03 01 04 ff ff];
+        clocks = <&osc0>;
+        resets = <&rcu0 0x40 7>;
+        #thermal-sensor-cells = <1>;
+    };
-- 
2.11.0

