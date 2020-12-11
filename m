Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938D2D7874
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437052AbgLKPAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436831AbgLKPAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33AC061285
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 06:58:50 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:58:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gzVB9p41YubVbdgGhH+NUQptTLwlLi4l/hMRpFAY74=;
        b=1c71b+DIXrIt0ehG9R+o8omBPyqBfg/mjVztxXGZPvdqPC1dUlBBfCRAlJUcP+n1h73Tre
        l+IilkMBBE1lZFCwlYgVxEotsuf1WE8d8FKVTtWYvPWzBwX+9wmkWAjrvGiQDyyj0/FPFD
        ahULhi0bL5SBXcE4Bo9454MMYvQCn/JgioNkR3bwW3p4cMJU1xn6C9NRxrpM5Xjp9VhTFX
        AWXr9WHljWwQR9P9rnR/YOzRmtA7qe/CTkh6kUNc+jsifWl77M/R1b6OFWncvMM4j85kSQ
        Gq08G+r9XM8gvLEKuLf5thFo9Zjf88UqpQP5Ilu/4peCMpDYAi1ggQeUT6jnew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607698725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+gzVB9p41YubVbdgGhH+NUQptTLwlLi4l/hMRpFAY74=;
        b=DZ/K05AXp3xJDqm4uL0zIqnQgAN4X2OQB4sLF+p/rUlPU2bDn/KZpHb2z1e6M7f5PO50s6
        N2OTZMLeltcXAgCw==
From:   "irqchip-bot for Gregory CLEMENT" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-kernel@vger.kernel.org
Subject: [irqchip: irq/irqchip-next] dt-bindings: interrupt-controller:
 convert icpu intr bindings to json-schema
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        tglx@linutronix.de
In-Reply-To: <20201125103206.136498-2-gregory.clement@bootlin.com>
References: <20201125103206.136498-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Message-ID: <160769872527.3364.11011368959734662293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/irqchip-next branch of irqchip:

Commit-ID:     47d5e0b0e1c151c06885a78a108001ead96adc75
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms/47d5e0b0e1c151c06885a78a108001ead96adc75
Author:        Gregory CLEMENT <gregory.clement@bootlin.com>
AuthorDate:    Wed, 25 Nov 2020 11:32:01 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 11 Dec 2020 14:47:49 

dt-bindings: interrupt-controller: convert icpu intr bindings to json-schema

Convert device tree bindings for Microsemi Ocelot SoC ICPU Interrupt
Controller to YAML format

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20201125103206.136498-2-gregory.clement@bootlin.com
---
 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt  | 21 ---------------------
 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+), 21 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt b/Documentation/devicetree/bindings/interrupt-controller/mscc,ocelot-icpu-intr.txt
deleted file mode 100644
index f5baecc..0000000
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
index 0000000..be82920
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
+        #address-cells = <0>;
+        interrupt-controller;
+        interrupt-parent = <&cpuintc>;
+        interrupts = <2>;
+    };
+...
