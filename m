Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601792B096E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 17:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgKLQEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 11:04:33 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:53633 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728218AbgKLQEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 11:04:30 -0500
X-Originating-IP: 91.175.115.186
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id BE0266001C;
        Thu, 12 Nov 2020 16:04:27 +0000 (UTC)
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
Subject: [PATCH v2 1/5] dt-bindings: interrupt-controller: convert icpu intr bindings to json-schema
Date:   Thu, 12 Nov 2020 17:04:20 +0100
Message-Id: <20201112160424.1383051-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201112160424.1383051-1-gregory.clement@bootlin.com>
References: <20201112160424.1383051-1-gregory.clement@bootlin.com>
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
 .../mscc,ocelot-icpu-intr.yaml                | 59 +++++++++++++++++++
 2 files changed, 59 insertions(+), 21 deletions(-)
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
index 000000000000..afd00f9c9d74
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml
@@ -0,0 +1,59 @@
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
+        interrupt-controller;
+        interrupt-parent = <&cpuintc>;
+        interrupts = <2>;
+    };
+...
\ No newline at end of file
-- 
2.28.0

