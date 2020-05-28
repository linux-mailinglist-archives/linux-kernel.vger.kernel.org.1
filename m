Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F61E58C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 09:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgE1HiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 03:38:22 -0400
Received: from inva021.nxp.com ([92.121.34.21]:39090 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1HiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:38:19 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 270AB200A1F;
        Thu, 28 May 2020 09:38:17 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 54085200A1D;
        Thu, 28 May 2020 09:38:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 48AF8402BF;
        Thu, 28 May 2020 15:38:04 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, shc_work@mail.ru, s.trumtrar@pengutronix.de,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/9] dt-bindings: clock: Convert i.MX5 clock to json-schema
Date:   Thu, 28 May 2020 15:27:51 +0800
Message-Id: <1590650879-18288-2-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
References: <1590650879-18288-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX5 clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx5-clock.txt       | 28 ----------
 .../devicetree/bindings/clock/imx5-clock.yaml      | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx5-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.txt b/Documentation/devicetree/bindings/clock/imx5-clock.txt
deleted file mode 100644
index a24ca9e..0000000
--- a/Documentation/devicetree/bindings/clock/imx5-clock.txt
+++ /dev/null
@@ -1,28 +0,0 @@
-* Clock bindings for Freescale i.MX5
-
-Required properties:
-- compatible: Should be "fsl,<soc>-ccm" , where <soc> can be imx51 or imx53
-- reg: Address and length of the register set
-- interrupts: Should contain CCM interrupt
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx5-clock.h
-for the full list of i.MX5 clock IDs.
-
-Examples (for mx53):
-
-clks: ccm@53fd4000{
-	compatible = "fsl,imx53-ccm";
-	reg = <0x53fd4000 0x4000>;
-	interrupts = <0 71 0x04 0 72 0x04>;
-	#clock-cells = <1>;
-};
-
-can1: can@53fc8000 {
-	compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
-	reg = <0x53fc8000 0x4000>;
-	interrupts = <82>;
-	clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>, <&clks IMX5_CLK_CAN1_SERIAL_GATE>;
-	clock-names = "ipg", "per";
-};
diff --git a/Documentation/devicetree/bindings/clock/imx5-clock.yaml b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
new file mode 100644
index 0000000..e4c405c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx5-clock.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx5-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX5
+
+maintainers:
+  - Fabio Estevam <fabio.estevam@freescale.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imx5-clock.h
+  for the full list of i.MX5 clock IDs.
+
+properties:
+  compatible:
+    enum:
+      - fsl,imx53-ccm
+      - fsl,imx51-ccm
+      - fsl,imx50-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: CCM provides 2 interrupt requests, request 1 is to generate
+      interrupt for frequency or mux change, request 2 is to generate
+      interrupt for oscillator read or PLL lock.
+    items:
+      - description: CCM interrupt request 1
+      - description: CCM interrupt request 2
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - '#clock-cells'
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx5-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clock-controller@53fd4000{
+        compatible = "fsl,imx53-ccm";
+        reg = <0x53fd4000 0x4000>;
+        interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 72 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+    };
+
+    can@53fc8000 {
+        compatible = "fsl,imx53-flexcan", "fsl,p1010-flexcan";
+        reg = <0x53fc8000 0x4000>;
+        interrupts = <82>;
+        clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>, <&clks IMX5_CLK_CAN1_SERIAL_GATE>;
+        clock-names = "ipg", "per";
+    };
-- 
2.7.4

