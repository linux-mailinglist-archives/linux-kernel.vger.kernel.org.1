Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D0F1BED48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 03:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgD3BA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 21:00:56 -0400
Received: from inva021.nxp.com ([92.121.34.21]:37828 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbgD3BAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 21:00:55 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4409C2005E8;
        Thu, 30 Apr 2020 03:00:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 29AA42005A3;
        Thu, 30 Apr 2020 03:00:48 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3382E402E2;
        Thu, 30 Apr 2020 09:00:42 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V4 1/5] dt-bindings: clock: Convert i.MX6Q clock to json-schema
Date:   Thu, 30 Apr 2020 08:51:57 +0800
Message-Id: <1588207921-20604-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX6Q clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V3:
	- update license to be with (GPL-2.0-only OR BSD-2-Clause);
	- remove unnecessary minItem for interrupts;
	- remove label in example.
---
 .../devicetree/bindings/clock/imx6q-clock.txt      | 41 --------------
 .../devicetree/bindings/clock/imx6q-clock.yaml     | 66 ++++++++++++++++++++++
 2 files changed, 66 insertions(+), 41 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
deleted file mode 100644
index 13d36d4..0000000
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ /dev/null
@@ -1,41 +0,0 @@
-* Clock bindings for Freescale i.MX6 Quad
-
-Required properties:
-- compatible: Should be "fsl,imx6q-ccm"
-- reg: Address and length of the register set
-- interrupts: Should contain CCM interrupt
-- #clock-cells: Should be <1>
-
-Optional properties:
-- fsl,pmic-stby-poweroff: Configure CCM to assert PMIC_STBY_REQ signal
-  on power off.
-  Use this property if the SoC should be powered off by external power
-  management IC (PMIC) triggered via PMIC_STBY_REQ signal.
-  Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
-  be using "syscon-poweroff" driver instead.
-- clocks: list of clock specifiers, must contain an entry for each entry
-          in clock-names
-- clock-names: valid names are "osc", "ckil", "ckih1", "anaclk1" and "anaclk2"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6qdl-clock.h
-for the full list of i.MX6 Quad and DualLite clock IDs.
-
-Examples:
-
-#include <dt-bindings/clock/imx6qdl-clock.h>
-
-clks: ccm@20c4000 {
-	compatible = "fsl,imx6q-ccm";
-	reg = <0x020c4000 0x4000>;
-	interrupts = <0 87 0x04 0 88 0x04>;
-	#clock-cells = <1>;
-};
-
-uart1: serial@2020000 {
-	compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
-	reg = <0x02020000 0x4000>;
-	interrupts = <0 26 0x04>;
-	clocks = <&clks IMX6QDL_CLK_UART_IPG>, <&clks IMX6QDL_CLK_UART_SERIAL>;
-	clock-names = "ipg", "per";
-};
diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
new file mode 100644
index 0000000..0dc96ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx6q-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX6 Quad
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx6q-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  '#clock-cells':
+    const: 1
+
+  clocks:
+    items:
+      - description: 24m osc
+      - description: 32k osc
+      - description: ckih1 clock input
+      - description: anaclk1 clock input
+      - description: anaclk2 clock input
+
+  clock-names:
+    items:
+      - const: osc
+      - const: ckil
+      - const: ckih1
+      - const: anaclk1
+      - const: anaclk2
+
+  fsl,pmic-stby-poweroff:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: |
+      Use this property if the SoC should be powered off by external power
+      management IC (PMIC) triggered via PMIC_STBY_REQ signal.
+      Boards that are designed to initiate poweroff on PMIC_ON_REQ signal should
+      be using "syscon-poweroff" driver instead.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+
+examples:
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@20c4000 {
+        compatible = "fsl,imx6q-ccm";
+        reg = <0x020c4000 0x4000>;
+        interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+    };
-- 
2.7.4

