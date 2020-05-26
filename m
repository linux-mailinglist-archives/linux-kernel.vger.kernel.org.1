Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3DE91DC99F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 11:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbgEUJOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 05:14:05 -0400
Received: from v6.sk ([167.172.42.174]:34782 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbgEUJOE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:14:04 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 684AE612FF;
        Thu, 21 May 2020 09:14:02 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 1/9] dt-bindings: mmc: Convert sdhci-pxa to json-schema
Date:   Thu, 21 May 2020 11:13:48 +0200
Message-Id: <20200521091356.2211020-2-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200521091356.2211020-1-lkundrak@v3.sk>
References: <20200521091356.2211020-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the sdhci-pxa binding to DT schema format using json-schema.

At the same time, fix a couple of issues with the examples discovered by
the validation tool -- a semicolon instead of a comma and wrong node names.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- move reg-names items: from the conditional to main properties:, only
  specify maxItems and minItems in conditional branches
- Specify minItems and maxItems in properties/reg instad of on
  conditional branchs
- Add default GPL-2.0-only license tag
- Fill in maintainers from MAINTAINERS file

 .../devicetree/bindings/mmc/sdhci-pxa.txt     |  50 ---------
 .../devicetree/bindings/mmc/sdhci-pxa.yaml    | 103 ++++++++++++++++++
 2 files changed, 103 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
deleted file mode 100644
index 3d1b449d6097..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Marvell sdhci-pxa v2/v3 controller
-
-This file documents differences between the core properties in mmc.txt
-and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
-
-Required properties:
-- compatible: Should be "mrvl,pxav2-mmc", "mrvl,pxav3-mmc" or
-  "marvell,armada-380-sdhci".
-- reg:
-  * for "mrvl,pxav2-mmc" and "mrvl,pxav3-mmc", one register area for
-    the SDHCI registers.
-
-  * for "marvell,armada-380-sdhci", three register areas. The first
-    one for the SDHCI registers themselves, the second one for the
-    AXI/Mbus bridge registers of the SDHCI unit, the third one for the
-    SDIO3 Configuration register
-- reg names: should be "sdhci", "mbus", "conf-sdio3". only mandatory
-  for "marvell,armada-380-sdhci"
-- clocks: Array of clocks required for SDHCI; requires at least one for
-    I/O clock.
-- clock-names: Array of names corresponding to clocks property; shall be
-    "io" for I/O clock and "core" for optional core clock.
-
-Optional properties:
-- mrvl,clk-delay-cycles: Specify a number of cycles to delay for tuning.
-
-Example:
-
-sdhci@d4280800 {
-	compatible = "mrvl,pxav3-mmc";
-	reg = <0xd4280800 0x800>;
-	bus-width = <8>;
-	interrupts = <27>;
-	clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
-	clock-names = "io", "core";
-	non-removable;
-	mrvl,clk-delay-cycles = <31>;
-};
-
-sdhci@d8000 {
-	compatible = "marvell,armada-380-sdhci";
-	reg-names = "sdhci", "mbus", "conf-sdio3";
-	reg = <0xd8000 0x1000>,
-		<0xdc000 0x100>;
-		<0x18454 0x4>;
-	interrupts = <0 25 0x4>;
-	clocks = <&gateclk 17>;
-	clock-names = "io";
-	mrvl,clk-delay-cycles = <0x1F>;
-};
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
new file mode 100644
index 000000000000..27ea069aa5fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sdhci-pxa.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell PXA SDHCI v2/v3 bindings
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+  - Rob Herring <robh+dt@kernel.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: marvell,armada-380-sdhci
+    then:
+      properties:
+        regs:
+          minItems: 3
+        reg-names:
+          minItems: 3
+      required:
+        - reg-names
+    else:
+      properties:
+        regs:
+          maxItems: 1
+        reg-names:
+          maxItems: 1
+
+properties:
+  compatible:
+    enum:
+      - mrvl,pxav2-mmc
+      - mrvl,pxav3-mmc
+      - marvell,armada-380-sdhci
+
+  reg:
+    minItems: 1
+    maxItems: 3
+
+  reg-names:
+    items:
+      - const: sdhci
+      - const: mbus
+      - const: conf-sdio3
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: io
+      - const: core
+
+  mrvl,clk-delay-cycles:
+    description: Specify a number of cycles to delay for tuning.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/berlin2.h>
+    mmc@d4280800 {
+        compatible = "mrvl,pxav3-mmc";
+        reg = <0xd4280800 0x800>;
+        bus-width = <8>;
+        interrupts = <27>;
+        clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
+        clock-names = "io", "core";
+        non-removable;
+        mrvl,clk-delay-cycles = <31>;
+    };
+  - |
+    mmc@d8000 {
+        compatible = "marvell,armada-380-sdhci";
+        reg-names = "sdhci", "mbus", "conf-sdio3";
+        reg = <0xd8000 0x1000>,
+              <0xdc000 0x100>,
+              <0x18454 0x4>;
+        interrupts = <0 25 0x4>;
+        clocks = <&gateclk 17>;
+        clock-names = "io";
+        mrvl,clk-delay-cycles = <0x1F>;
+    };
+
+...
-- 
2.26.2

