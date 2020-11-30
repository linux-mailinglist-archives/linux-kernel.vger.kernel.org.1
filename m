Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90C692C9229
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbgK3XJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:09:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:13823 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731013AbgK3XIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:08:53 -0500
IronPort-SDR: e05UUz0ZFv4sFHXecKu5NMT4MyjmQESSKDKtjbeO86YxicqXJg7nto//y+GAurJ2EfVaNBxSfw
 KeqBRDHDAIGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="172826355"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="172826355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:11 -0800
IronPort-SDR: 84lxGbBS8BBKzmCbiw6dvFFjgARoVzFo1JOZRIuld0T+zV3Yva9zoIa7rP/yqp2xIfP16YvdLn
 RLFcqeoThxMA==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="538781108"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id D873D6363;
        Mon, 30 Nov 2020 15:07:09 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGD-000C4t-Nf; Mon, 30 Nov 2020 15:07:09 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com, Paul Murphy <paul.j.murphy@intel.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: [PATCH 04/22] dt-bindings: Add bindings for Keem Bay VPU IPC driver
Date:   Mon, 30 Nov 2020 15:06:49 -0800
Message-Id: <20201130230707.46351-5-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
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
 .../soc/intel/intel,keembay-vpu-ipc.yaml      | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml

diff --git a/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
new file mode 100644
index 000000000000..60d4a028563c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,keembay-vpu-ipc.yaml
@@ -0,0 +1,151 @@
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
+  clocks-names:
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

