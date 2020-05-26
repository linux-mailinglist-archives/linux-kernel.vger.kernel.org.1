Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612601AB6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 06:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404664AbgDPEfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Apr 2020 00:35:02 -0400
Received: from inva020.nxp.com ([92.121.34.13]:53510 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390974AbgDPEea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 00:34:30 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 137021A0B9D;
        Thu, 16 Apr 2020 06:34:28 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF7721A0B91;
        Thu, 16 Apr 2020 06:34:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 37A0A402C4;
        Thu, 16 Apr 2020 12:34:14 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 3/5] dt-bindings: clock: Convert i.MX6SL clock to json-schema
Date:   Thu, 16 Apr 2020 12:26:09 +0800
Message-Id: <1587011171-24532-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587011171-24532-1-git-send-email-Anson.Huang@nxp.com>
References: <1587011171-24532-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the i.MX6SL clock binding to DT schema format using json-schema.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 .../devicetree/bindings/clock/imx6sl-clock.txt     | 10 -----
 .../devicetree/bindings/clock/imx6sl-clock.yaml    | 45 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 10 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/imx6sl-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imx6sl-clock.txt b/Documentation/devicetree/bindings/clock/imx6sl-clock.txt
deleted file mode 100644
index 15e40bd..0000000
--- a/Documentation/devicetree/bindings/clock/imx6sl-clock.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-* Clock bindings for Freescale i.MX6 SoloLite
-
-Required properties:
-- compatible: Should be "fsl,imx6sl-ccm"
-- reg: Address and length of the register set
-- #clock-cells: Should be <1>
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.  See include/dt-bindings/clock/imx6sl-clock.h
-for the full list of i.MX6 SoloLite clock IDs.
diff --git a/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
new file mode 100644
index 0000000..6e571bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6sl-clock.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imx6sl-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MX6 SoloLite
+
+maintainers:
+  - Anson Huang <Anson.Huang@nxp.com>
+
+properties:
+  compatible:
+    const: fsl,imx6sl-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    maxItems: 2
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
+  # Clock Control Module node:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    clks: clock-controller@20c4000 {
+        compatible = "fsl,imx6sl-ccm";
+        reg = <0x020c4000 0x4000>;
+        interrupts = <0 87 IRQ_TYPE_LEVEL_HIGH>,
+                     <0 88 IRQ_TYPE_LEVEL_HIGH>;
+        #clock-cells = <1>;
+    };
+
+...
-- 
2.7.4

