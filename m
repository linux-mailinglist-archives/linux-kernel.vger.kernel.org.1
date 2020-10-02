Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4246D280DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgJBHEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:04:44 -0400
Received: from mga06.intel.com ([134.134.136.31]:12252 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgJBHEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:04:44 -0400
IronPort-SDR: fM3WTd9FvhqCRoMnqMvpSDH07eYJGDmgXk7HZn3Zm+owpSHhBLDRwy8uAGI2QiII7gfOK3l65/
 81pCBRfGCXnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="224544895"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="224544895"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 00:04:41 -0700
IronPort-SDR: pEw3zB8qLC/nhl4AQWAFBdSBRCtHPEfcKfM677ffo2iqbEnc7DwTK9SehMzcZfVI1lR+LWZU+K
 Fz82u15NWJ0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="295275409"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga008.fm.intel.com with ESMTP; 02 Oct 2020 00:04:36 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     jdelvare@suse.com, linux@roeck-us.net, p.zabel@pengutronix.de,
        linux-hwmon@vger.kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v4 1/2] Add DT bindings schema for PVT controller
Date:   Fri,  2 Oct 2020 15:04:26 +0800
Message-Id: <b540b49ca47d75c5f716f8a4e4eed0664a1116bf.1601621983.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
References: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
References: <cover.1601621983.git.rahul.tanwar@linux.intel.com>
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

