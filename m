Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E02EFA87
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 22:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbhAHV3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 16:29:12 -0500
Received: from mga14.intel.com ([192.55.52.115]:64126 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbhAHV3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 16:29:11 -0500
IronPort-SDR: WGkKrpgRPAU7qTpgTpRdf4R/lrg4aZ0kAnB6/ktRQ5SNLqQIM+AK2BBDCq9Z0Qi+bhlWXCJPuX
 1LmVuh1WP0fQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9858"; a="176881540"
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="176881540"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:04 -0800
IronPort-SDR: 3Dt/GtIn0EfuK+57fnvQME0Kw9MfNXQKFC7TJorN0GtTWleEJ2bfjiLdC3kS2et1tYIPzaf90c
 201w5AhLSSWQ==
X-IronPort-AV: E=Sophos;i="5.79,332,1602572400"; 
   d="scan'208";a="399105835"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2021 13:26:04 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id C4BB2636A;
        Fri,  8 Jan 2021 13:26:03 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kxzGl-0009bw-M4; Fri, 08 Jan 2021 13:26:03 -0800
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        leonard.crestez@nxp.com, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, peng.fan@nxp.com, robh+dt@kernel.org,
        shawnguo@kernel.org, jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Paul Murphy <paul.j.murphy@intel.com>,
        devicetree@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v2 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC driver
Date:   Fri,  8 Jan 2021 13:25:32 -0800
Message-Id: <20210108212600.36850-7-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108212600.36850-1-mgross@linux.intel.com>
References: <20210108212600.36850-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Murphy <paul.j.murphy@intel.com>

Add DT bindings documentation for the Keem Bay VPU IPC driver.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Paul Murphy <paul.j.murphy@intel.com>
Co-developed-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
---
 .../soc/intel/intel,keembay-vpu-ipc.yaml      | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml

diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
new file mode 100644
index 000000000000..cd1c4abe8bc9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (c) Intel Corporation. All rights reserved.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/intel/intel,keembay-vpu-ipc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel Keem Bay VPU IPC
+
+maintainers:
+  - Paul Murphy <paul.j.murphy@intel.com>
+
+description:
+  The VPU IPC driver facilitates loading of firmware, control, and communication
+  with the VPU over the IPC FIFO in the Intel Keem Bay SoC.
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+        - const: intel,keembay-vpu-ipc
+
+  reg:
+    items:
+      - description: NCE WDT registers
+      - description: NCE TIM_GEN_CONFIG registers
+      - description: MSS WDT registers
+      - description: MSS TIM_GEN_CONFIG registers
+
+  reg-names:
+    items:
+      - const: nce_wdt
+      - const: nce_tim_cfg
+      - const: mss_wdt
+      - const: mss_tim_cfg
+
+  memory-region:
+    items:
+      - description: reference to the VPU reserved memory region
+      - description: reference to the X509 reserved memory region
+      - description: reference to the MSS IPC area
+
+  clocks:
+    items:
+      - description: cpu clock
+      - description: pll 0 out 0 rate
+      - description: pll 0 out 1 rate
+      - description: pll 0 out 2 rate
+      - description: pll 0 out 3 rate
+      - description: pll 1 out 0 rate
+      - description: pll 1 out 1 rate
+      - description: pll 1 out 2 rate
+      - description: pll 1 out 3 rate
+      - description: pll 2 out 0 rate
+      - description: pll 2 out 1 rate
+      - description: pll 2 out 2 rate
+      - description: pll 2 out 3 rate
+
+  clock-names:
+    items:
+      - const: cpu_clock
+      - const: pll_0_out_0
+      - const: pll_0_out_1
+      - const: pll_0_out_2
+      - const: pll_0_out_3
+      - const: pll_1_out_0
+      - const: pll_1_out_1
+      - const: pll_1_out_2
+      - const: pll_1_out_3
+      - const: pll_2_out_0
+      - const: pll_2_out_1
+      - const: pll_2_out_2
+      - const: pll_2_out_3
+
+  interrupts:
+    items:
+      - description: number of NCE sub-system WDT timeout IRQ
+      - description: number of MSS sub-system WDT timeout IRQ
+
+  interrupt-names:
+    items:
+      - const: nce_wdt
+      - const: mss_wdt
+
+  intel,keembay-vpu-ipc-nce-wdt-redirect:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      Number to which we will request that the NCE sub-system
+      re-directs it's WDT timeout IRQ
+
+  intel,keembay-vpu-ipc-mss-wdt-redirect:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      Number to which we will request that the MSS sub-system
+      re-directs it's WDT timeout IRQ
+
+  intel,keembay-vpu-ipc-imr:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description:
+      IMR (isolated memory region) number which we will request
+      the runtime service uses to protect the VPU memory region
+      before authentication
+
+  intel,keembay-vpu-ipc-id:
+    $ref: "/schemas/types.yaml#/definitions/uint32"
+    description: The VPU ID to be passed to the VPU firmware.
+
+additionalProperties: False
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    vpu-ipc@3f00209c {
+        compatible = "intel,keembay-vpu-ipc";
+        reg = <0x3f00209c 0x10>,
+              <0x3f003008 0x4>,
+              <0x2082009c 0x10>,
+              <0x20821008 0x4>;
+        reg-names = "nce_wdt",
+                    "nce_tim_cfg",
+                    "mss_wdt",
+                    "mss_tim_cfg";
+        memory-region = <&vpu_reserved>,
+                        <&vpu_x509_reserved>,
+                        <&mss_ipc_reserved>;
+        clocks = <&scmi_clk 0>,
+                 <&scmi_clk 0>,
+                 <&scmi_clk 1>,
+                 <&scmi_clk 2>,
+                 <&scmi_clk 3>,
+                 <&scmi_clk 4>,
+                 <&scmi_clk 5>,
+                 <&scmi_clk 6>,
+                 <&scmi_clk 7>,
+                 <&scmi_clk 8>,
+                 <&scmi_clk 9>,
+                 <&scmi_clk 10>,
+                 <&scmi_clk 11>;
+        clock-names = "cpu_clock",
+                      "pll_0_out_0", "pll_0_out_1",
+                      "pll_0_out_2", "pll_0_out_3",
+                      "pll_1_out_0", "pll_1_out_1",
+                      "pll_1_out_2", "pll_1_out_3",
+                      "pll_2_out_0", "pll_2_out_1",
+                      "pll_2_out_2", "pll_2_out_3";
+        interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "nce_wdt", "mss_wdt";
+        intel,keembay-vpu-ipc-nce-wdt-redirect = <63>;
+        intel,keembay-vpu-ipc-mss-wdt-redirect = <47>;
+        intel,keembay-vpu-ipc-imr = <9>;
+        intel,keembay-vpu-ipc-id = <0>;
+    };
-- 
2.17.1

