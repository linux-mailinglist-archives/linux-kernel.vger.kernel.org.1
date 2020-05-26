Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FF31A91A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 05:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389801AbgDODli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 23:41:38 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36960 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733221AbgDODlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 23:41:35 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 441CA2006E5;
        Wed, 15 Apr 2020 05:41:32 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id DCE29200715;
        Wed, 15 Apr 2020 05:41:27 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8277B402D8;
        Wed, 15 Apr 2020 11:41:22 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 1/3] dt-bindings: nvmem: Convert i.MX OCOTP to json-schema
Date:   Wed, 15 Apr 2020 11:33:20 +0800
Message-Id: <1586921602-1877-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX OCOTP binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/nvmem/imx-ocotp.txt        |  50 ----------
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       | 103 +++++++++++++++++++++
 2 files changed, 103 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt b/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
deleted file mode 100644
index 6e346d5..0000000
--- a/Documentation/devicetree/bindings/nvmem/imx-ocotp.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
-
-This binding represents the on-chip eFuse OTP controller found on
-i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
-i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
-
-Required properties:
-- compatible: should be one of
-	"fsl,imx6q-ocotp" (i.MX6Q/D/DL/S),
-	"fsl,imx6sl-ocotp" (i.MX6SL), or
-	"fsl,imx6sx-ocotp" (i.MX6SX),
-	"fsl,imx6ul-ocotp" (i.MX6UL),
-	"fsl,imx6ull-ocotp" (i.MX6ULL/ULZ),
-	"fsl,imx7d-ocotp" (i.MX7D/S),
-	"fsl,imx6sll-ocotp" (i.MX6SLL),
-	"fsl,imx7ulp-ocotp" (i.MX7ULP),
-	"fsl,imx8mq-ocotp" (i.MX8MQ),
-	"fsl,imx8mm-ocotp" (i.MX8MM),
-	"fsl,imx8mn-ocotp" (i.MX8MN),
-	"fsl,imx8mp-ocotp" (i.MX8MP),
-	followed by "syscon".
-- #address-cells : Should be 1
-- #size-cells : Should be 1
-- reg: Should contain the register base and length.
-- clocks: Should contain a phandle pointing to the gated peripheral clock.
-
-Optional properties:
-- read-only: disable write access
-
-Optional Child nodes:
-
-- Data cells of ocotp:
-  Detailed bindings are described in bindings/nvmem/nvmem.txt
-
-Example:
-	ocotp: ocotp@21bc000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "fsl,imx6sx-ocotp", "syscon";
-		reg = <0x021bc000 0x4000>;
-		clocks = <&clks IMX6SX_CLK_OCOTP>;
-
-		tempmon_calib: calib@38 {
-			reg = <0x38 4>;
-		};
-
-		tempmon_temp_grade: temp-grade@20 {
-			reg = <0x20 4>;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
new file mode 100644
index 0000000..70aa637
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/imx-ocotp.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/imx-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX6 On-Chip OTP Controller (OCOTP) device tree bindings
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+description: |
+  This binding represents the on-chip eFuse OTP controller found on
+  i.MX6Q/D, i.MX6DL/S, i.MX6SL, i.MX6SX, i.MX6UL, i.MX6ULL/ULZ, i.MX6SLL,
+  i.MX7D/S, i.MX7ULP, i.MX8MQ, i.MX8MM, i.MX8MN and i.MX8MP SoCs.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    anyOf:
+      - items:
+        - enum:
+          - fsl,imx6q-ocotp
+          - fsl,imx6sl-ocotp
+          - fsl,imx6sx-ocotp
+          - fsl,imx6ul-ocotp
+          - fsl,imx6ull-ocotp
+          - fsl,imx7d-ocotp
+          - fsl,imx6sll-ocotp
+          - fsl,imx7ulp-ocotp
+          - fsl,imx8mq-ocotp
+          - fsl,imx8mm-ocotp
+          - fsl,imx8mn-ocotp
+          - fsl,imx8mp-ocotp
+
+        - const: syscon
+
+      - contains:
+          const: syscon
+        additionalItems: true
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  clocks:
+    description: |
+      OCOTP's clock source.
+    maxItems: 1
+
+required:
+  - "#address-cells"
+  - "#size-cells"
+  - compatible
+  - reg
+
+patternProperties:
+  "^.*@[0-9a-f]+$":
+    type: object
+
+    properties:
+      reg:
+        maxItems: 1
+        description:
+          Offset and size in bytes within the storage device.
+
+    required:
+      - reg
+
+    additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx6sx-clock.h>
+
+    ocotp: efuse@21bc000 {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        compatible = "fsl,imx6sx-ocotp", "syscon";
+        reg = <0x021bc000 0x4000>;
+        clocks = <&clks IMX6SX_CLK_OCOTP>;
+
+        cpu_speed_grade: speed-grade@10 {
+            reg = <0x10 4>;
+        };
+
+        tempmon_calib: calib@38 {
+            reg = <0x38 4>;
+        };
+
+        tempmon_temp_grade: temp-grade@20 {
+            reg = <0x20 4>;
+        };
+    };
+
+...
-- 
2.7.4

