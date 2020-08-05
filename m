Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F76F23C3BE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 04:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHECzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 22:55:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:34356 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgHECzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:55:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 77ED01A1499;
        Wed,  5 Aug 2020 04:55:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4033A1A1490;
        Wed,  5 Aug 2020 04:55:15 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id BDA17402CF;
        Wed,  5 Aug 2020 04:55:09 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/2] dt-bindings: fsl: Convert i.MX7ULP PM to json-schema
Date:   Wed,  5 Aug 2020 10:50:40 +0800
Message-Id: <1596595841-27563-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX7ULP PM binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../bindings/arm/freescale/fsl,imx7ulp-pm.txt      | 23 -------------
 .../bindings/arm/freescale/fsl,imx7ulp-pm.yaml     | 40 ++++++++++++++++++++++
 2 files changed, 40 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
deleted file mode 100644
index 75195be..0000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-Freescale i.MX7ULP Power Management Components
-----------------------------------------------
-
-The Multi-System Mode Controller (MSMC) is responsible for sequencing
-the MCU into and out of all stop and run power modes. Specifically, it
-monitors events to trigger transitions between power modes while
-controlling the power, clocks, and memories of the MCU to achieve the
-power consumption and functionality of that mode.
-
-The WFI or WFE instruction is used to invoke a Sleep, Deep Sleep or
-Standby modes for either Cortex family. Run, Wait, and Stop are the
-common terms used for the primary operating modes of Kinetis
-microcontrollers.
-
-Required properties:
-- compatible:	Should be "fsl,imx7ulp-smc1".
-- reg:		Specifies base physical address and size of the register sets.
-
-Example:
-smc1: smc1@40410000 {
-	compatible = "fsl,imx7ulp-smc1";
-	reg = <0x40410000 0x1000>;
-};
diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
new file mode 100644
index 0000000..1b00294
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,imx7ulp-pm.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,imx7ulp-pm.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX7ULP Power Management Components
+
+maintainers:
+  - A.s. Dong <aisheng.dong@nxp.com>
+
+description: |
+  The Multi-System Mode Controller (MSMC) is responsible for sequencing
+  the MCU into and out of all stop and run power modes. Specifically, it
+  monitors events to trigger transitions between power modes while
+  controlling the power, clocks, and memories of the MCU to achieve the
+  power consumption and functionality of that mode.
+
+  The WFI or WFE instruction is used to invoke a Sleep, Deep Sleep or
+  Standby modes for either Cortex family. Run, Wait, and Stop are the
+  common terms used for the primary operating modes of Kinetis
+  microcontrollers.
+
+properties:
+  compatible:
+    const: fsl,imx7ulp-smc1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    smc1@40410000 {
+        compatible = "fsl,imx7ulp-smc1";
+        reg = <0x40410000 0x1000>;
+    };
-- 
2.7.4

