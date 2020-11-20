Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C68F2BB0BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgKTQlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 11:41:19 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:37355 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729397AbgKTQlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:41:18 -0500
Received: from localhost (lfbn-lyo-1-1010-39.w86-194.abo.wanadoo.fr [86.194.86.39])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 253B4200003;
        Fri, 20 Nov 2020 16:41:14 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        <Steen.Hegelund@microchip.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: [PATCH v4 1/6] dt-bindings: interrupt-controller: convert icpu intr bindings to json-schema
Date:   Fri, 20 Nov 2020 17:41:03 +0100
Message-Id: <20201120164108.2096359-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201120164108.2096359-1-gregory.clement@bootlin.com>
References: <20201120164108.2096359-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert device tree bindings for Microsemi Ocelot SoC ICPU Interrupt
Controller to YAML format

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 .../mscc,ocelot-icpu-intr.txt                 | 21 -------
 .../mscc,ocelot-icpu-intr.yaml                | 60 +++++++++++++++++++
 2 files changed, 60 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
deleted file mode 100644
index f5baeccb689f..000000000000
--- a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-Microsemi Ocelot SoC ICPU Interrupt Controller
-
-Required properties:
-
-- compatible : should be "mscc,ocelot-icpu-intr"
-- reg : Specifies base physical address and size of the registers.
-- interrupt-controller : Identifies the node as an interrupt controller
-- #interrupt-cells : Specifies the number of cells needed to encode an
-  interrupt source. The value shall be 1.
-- interrupts : Specifies the CPU interrupt the controller is connected to.
-
-Example:
-
-		intc: interrupt-controller@70000070 {
-			compatible = "mscc,ocelot-icpu-intr";
-			reg = <0x70000070 0x70>;
-			#interrupt-cells = <1>;
-			interrupt-controller;
-			interrupt-parent = <&cpuintc>;
-			interrupts = <2>;
-		};
diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
new file mode 100644
index 000000000000..f34b319c7874
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/interrupt-controller/mscc,ocelot-icpu-intr.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Microsemi Ocelot SoC ICPU Interrupt Controller
+
+maintainers:
+  - Alexandre Belloni <alexandre.belloni@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  the Microsemi Ocelot interrupt controller that is part of the
+  ICPU. It is connected directly to the MIPS core interrupt
+  controller.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mscc,ocelot-icpu-intr
+
+  '#interrupt-cells':
+    const: 1
+
+  '#address-cells':
+    const: 0
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - '#address-cells'
+  - interrupt-controller
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    intc: interrupt-controller@70000070 {
+        compatible = "mscc,ocelot-icpu-intr";
+        reg = <0x70000070 0x70>;
+        #interrupt-cells = <1>;
+	#address-cells = <0>;
+        interrupt-controller;
+        interrupt-parent = <&cpuintc>;
+        interrupts = <2>;
+    };
+...
-- 
2.29.2

