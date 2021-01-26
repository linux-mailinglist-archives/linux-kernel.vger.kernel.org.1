Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5D4304DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388424AbhAZXWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:22:10 -0500
Received: from mga18.intel.com ([134.134.136.126]:50986 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388725AbhAZFpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:45:38 -0500
IronPort-SDR: YqOU9ImdXfuPDhGMcHsTRsLT8Y42Ivsve8P1PIC6kZGzQTk2LptQyIhk6xJwADFQEnMy/VPlzt
 VceGwupJ6/uQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="167524679"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="167524679"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
IronPort-SDR: uWW+XIPxG2NpsNyOyjUXz0SfV9+0BmQvJJuF1WN81j9Qy/VxFVSHuky9V1bMriFqiCcrZbf65P
 hYU033Jv2ZSA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="387693717"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:41 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 7DBC2637A;
        Mon, 25 Jan 2021 21:40:41 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 6EC973609A3; Mon, 25 Jan 2021 21:40:41 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v3 26/34] dt-bindings: misc: intel_tsens: Add tsens thermal bindings documentation
Date:   Mon, 25 Jan 2021 21:40:28 -0800
Message-Id: <20210126054036.61587-27-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "C, Udhayakumar" <udhayakumar.c@intel.com>

Add device tree bindings for local host thermal sensors
Intel Edge.AI Computer Vision platforms.

The tsens module enables reading of on chip sensors present
in the Intel Bay series SoC. In the tsens module various junction
temperature and SoC temperature are reported using thermal subsystem
and i2c subsystem.

Temperature data reported using thermal subsystem will be used for
various cooling agents such as DVFS, fan control and shutdown the
system in case of critical temperature.

Temperature data reported using i2c subsytem will be used by
platform manageability software running in remote host.

Acked-by: mark gross <mgross@linux.intel.com>
Signed-off-by: C, Udhayakumar <udhayakumar.c@intel.com>
---
 .../bindings/misc/intel,intel-tsens.yaml      | 122 ++++++++++++++++++
 1 file changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml

diff --git a/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml b/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
new file mode 100644
index 000000000000..abac41995643
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/intel,intel-tsens.yaml
@@ -0,0 +1,122 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/misc/intel,intel_tsens.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Temperature sensors in Bay series
+
+maintainers:
+  - Udhayakumar C <udhayakumar.c@intel.com>
+
+description: |
+  The tsens driver enables reading of onchip sensors present
+  in the Intel Bay SoC.
+  Each subnode of the tsens represents sensors available
+  on the soc.
+
+select: false
+
+properties:
+  compatible:
+    items:
+      - const: intel,intel-tsens
+
+  plat_name:
+    contains:
+      enum:
+        - intel,keembay_thermal
+
+  reg:
+    minItems: 1
+    maxItems: 2
+
+  clocks:
+    items:
+      - description: thermal sensor clock
+
+  clk-rate:
+    minItems: 1
+    maxItems: 1
+    additionalItems: false
+    items:
+      - description: thermal sensor clock freq
+
+  sensor_name:
+    type: object
+    description:
+      Details to configure sensor trip points and its types.
+
+    properties:
+      passive_delay:
+        minItems: 1
+        maxItems: 1
+        description: number of milliseconds to wait between polls when
+                     performing passive cooling
+
+      polling_delay:
+        minItems: 1
+        maxItems: 1
+        description: number of milliseconds to wait between polls when checking
+                     whether trip points have been crossed (0 for interrupt
+                     driven systems)
+
+      trip_temp:
+        minItems: 1
+        description: temperature for trip points
+
+      trip_type:
+        minItems: 1
+        description: trip type list for trip points
+
+    required:
+      - passive_delay
+      - polling_delay
+      - trip_temp
+      - trip_type
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    tsens: tsens@20260000 {
+        compatible = "intel,intel-tsens";
+        status = "disabled";
+        #address-cells = <2>;
+        #size-cells = <2>;
+        plat_name = "intel,keembay_thermal";
+        reg = <0x0 0x20260000 0x0 0x100>;
+        clocks = <&scmi_clk>;
+        clk-rate = <1250000>;
+
+        mss {
+                passive_delay = <1000>;
+                polling_delay = <2000>;
+                trip_temp = <40000 80000 1000000>;
+                trip_type = "passive", "passive", "critical";
+        };
+
+        css {
+                passive_delay = <1000>;
+                polling_delay = <2000>;
+                trip_temp = <40000 80000 1000000>;
+                trip_type = "passive", "passive", "critical";
+        };
+
+        nce {
+                passive_delay = <1000>;
+                polling_delay = <2000>;
+                trip_temp = <40000 80000 1000000>;
+                trip_type = "passive", "passive", "critical";
+        };
+
+        soc {
+                passive_delay = <1000>;
+                polling_delay = <2000>;
+                trip_temp = <40000 80000 1000000>;
+                trip_type = "passive", "passive", "critical";
+        };
+     };
-- 
2.17.1

