Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C126304DD5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388302AbhAZXVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:21:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:35936 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbhAZFm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:42:56 -0500
IronPort-SDR: 752K8DAOUdqO1kX6fkS0nvPK84kubdqNOBdz2MV+gdPLQGlfqqwe4ryJBKKj4PkkW9L0aXCQ8n
 s0B7Nk+9RbKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="159028891"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="159028891"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:42 -0800
IronPort-SDR: Y9tkK5+B0CL7QYue7slilr0b5XXZWR99ojjw0BPz0tkutaNsd+7sPmIb0/gmimHiINiuMSZzU8
 VADccHM8t7gA==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="353335762"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 21:40:42 -0800
Received: from mtg-dev.jf.intel.com (mtg-dev.jf.intel.com [10.54.74.10])
        by smtp.ostc.intel.com (Postfix) with ESMTP id 77390636E;
        Mon, 25 Jan 2021 21:40:40 -0800 (PST)
Received: by mtg-dev.jf.intel.com (Postfix, from userid 1000)
        id 6AB733630A2; Mon, 25 Jan 2021 21:40:40 -0800 (PST)
From:   mgross@linux.intel.com
To:     markgross@kernel.org, mgross@linux.intel.com, arnd@arndb.de,
        bp@suse.de, damien.lemoal@wdc.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, corbet@lwn.net,
        palmerdabbelt@google.com, paul.walmsley@sifive.com,
        peng.fan@nxp.com, robh+dt@kernel.org, shawnguo@kernel.org,
        jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        Paul Murphy <paul.j.murphy@intel.com>,
        devicetree@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH v3 06/34] dt-bindings: Add bindings for Keem Bay VPU IPC driver
Date:   Mon, 25 Jan 2021 21:40:08 -0800
Message-Id: <20210126054036.61587-7-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210126054036.61587-1-mgross@linux.intel.com>
References: <20210126054036.61587-1-mgross@linux.intel.com>
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

