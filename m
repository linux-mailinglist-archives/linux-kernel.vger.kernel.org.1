Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C402EFA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730023AbhAHVax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:30:53 -0500
Received: from mga07.intel.com ([134.134.136.100]:22454 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729753AbhAHVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:30:49 -0500
IronPort-SDR: vrj+pZ0OGOLjWHWPWdnwuF+0oulM/BThxcYAiMlK7/a6nqYkF/v1KT+C/YzZD7tf2Mp0Ul6dwG
 SFZpcWSs951g==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="241732886"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="241732886"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:05 -0800
IronPort-SDR: 2iI4/8zQ/n1r2QfsVmmvhKhK0MBmRpJ3OvLSuuSnfkgPFCDApaRyoVxsjtbgXYiua3uME2NAYm
 uo7VqpMLkm0g==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="362470727"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:05 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id CF860636A;
        Fri,  8 Jan 2021 13:26:05 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGn-0009cw-Na; Fri, 08 Jan 2021 13:26:05 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "C, Udhayakumar" <udhayakumar.c@intel.com>, C@linux.intel.com
Subject: [PATCH v2 26/34] dt-bindings: misc: intel_tsens: Add tsens thermal bindings documentation
Date:   Fri,  8 Jan 2021 13:25:52 -0800
Message-Id: <20210108212600.36850-27-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
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

