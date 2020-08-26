Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6CC525374F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 20:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHZSiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 14:38:21 -0400
Received: from foss.arm.com ([217.140.110.172]:50098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbgHZSiQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:38:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA7D71045;
        Wed, 26 Aug 2020 11:38:15 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0E4D3F71F;
        Wed, 26 Aug 2020 11:38:13 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chanho Min <chanho.min@lge.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Wei Xu <xuwei5@hisilicon.com>
Subject: [PATCH 1/6] dt-bindings: timers: sp-804: Convert to json-schema
Date:   Wed, 26 Aug 2020 19:37:59 +0100
Message-Id: <20200826183805.19369-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826183805.19369-1-andre.przywara@arm.com>
References: <20200826183805.19369-1-andre.przywara@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the DT binding documentation for the ARM SP-804 timer IP
over to json-schema.
Most properties are just carried over, the clocks property requirement
(either one or three clocks) is now formalised and enforced.
As the former binding didn't specify clock-names, and there is no
common name used by the existing DTs, I refrained from adding them.
The requirement for the APB clock is enforced by the primecell binding
already.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/timer/arm,sp804.txt   | 29 -------
 .../devicetree/bindings/timer/arm,sp804.yaml  | 82 +++++++++++++++++++
 2 files changed, 82 insertions(+), 29 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.txt
 create mode 100644 Documentation/devicetree/bindings/timer/arm,sp804.yaml

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
deleted file mode 100644
index 5cd8eee74af1..000000000000
--- a/Documentation/devicetree/bindings/timer/arm,sp804.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-ARM sp804 Dual Timers
----------------------------------------
-
-Required properties:
-- compatible: Should be "arm,sp804" & "arm,primecell"
-- interrupts: Should contain the list of Dual Timer interrupts. This is the
-	interrupt for timer 1 and timer 2. In the case of a single entry, it is
-	the combined interrupt or if "arm,sp804-has-irq" is present that
-	specifies which timer interrupt is connected.
-- reg: Should contain location and length for dual timer register.
-- clocks: clocks driving the dual timer hardware. This list should be 1 or 3
-	clocks.	With 3 clocks, the order is timer0 clock, timer1 clock,
-	apb_pclk. A single clock can also be specified if the same clock is
-	used for all clock inputs.
-
-Optional properties:
-- arm,sp804-has-irq = <#>: In the case of only 1 timer irq line connected, this
-	specifies if the irq connection is for timer 1 or timer 2. A value of 1
-	or 2 should be used.
-
-Example:
-
-	timer0: timer@fc800000 {
-		compatible = "arm,sp804", "arm,primecell";
-		reg = <0xfc800000 0x1000>;
-		interrupts = <0 0 4>, <0 1 4>;
-		clocks = <&timclk1 &timclk2 &pclk>;
-		clock-names = "timer1", "timer2", "apb_pclk";
-	};
diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.yaml b/Documentation/devicetree/bindings/timer/arm,sp804.yaml
new file mode 100644
index 000000000000..77d35bc41176
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/arm,sp804.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ARM sp804 Dual Timers
+
+maintainers:
+  - Haojian Zhuang <haojian.zhuang@linaro.org>
+
+description: |+
+  The Arm SP804 IP implements two independent timers, configurable for
+  16 or 32 bit operation and capable of running in one-shot, periodic, or
+  free-running mode. The input clock is shared, but can be gated and prescaled
+  independently for each timer.
+
+# Need a custom select here or 'arm,primecell' will match on lots of nodes
+select:
+  properties:
+    compatible:
+      contains:
+        const: arm,sp804
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - const: arm,sp804
+      - const: arm,primecell
+
+  interrupts:
+    description: |
+      If two interrupts are listed, those are the interrupts for timer
+      1 and 2, respectively. If there is only a single interrupt, it is
+      either a combined interrupt or the sole interrupt of one timer, as
+      specified by the "arm,sp804-has-irq" property.
+    minItems: 1
+    maxItems: 2
+
+  reg:
+    description: The physical base address of the SP804 IP.
+    maxItems: 1
+
+  clocks:
+    description: |
+      Clocks driving the dual timer hardware. This list should
+      be 1 or 3 clocks. With 3 clocks, the order is timer0 clock, timer1
+      clock, apb_pclk. A single clock can also be specified if the same
+      clock is used for all clock inputs.
+    oneOf:
+      - items:
+        - description: clock for timer 1
+        - description: clock for timer 2
+        - description: bus clock
+      - items:
+        - description: unified clock for both timers and the bus
+
+  arm,sp804-has-irq:
+    description: If only one interrupt line is connected to the interrupt
+      controller, this property specifies which timer is connected to this
+      line.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 2
+
+required:
+  - compatible
+  - interrupts
+  - reg
+  - clocks
+
+examples:
+  - |
+    timer0: timer@fc800000 {
+        compatible = "arm,sp804", "arm,primecell";
+        reg = <0xfc800000 0x1000>;
+        interrupts = <0 0 4>, <0 1 4>;
+        clocks = <&timclk1>, <&timclk2>, <&pclk>;
+        clock-names = "timer1", "timer2", "apb_pclk";
+    };
-- 
2.17.1

