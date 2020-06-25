Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABEC120A7A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 23:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407333AbgFYVnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 17:43:25 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49277 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406746AbgFYVnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:43:24 -0400
X-Originating-IP: 86.202.110.81
Received: from localhost (lfbn-lyo-1-15-81.w86-202.abo.wanadoo.fr [86.202.110.81])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id E86EAFF803;
        Thu, 25 Jun 2020 21:43:21 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        kamel.bouhara@bootlin.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 2/9] dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
Date:   Thu, 25 Jun 2020 23:43:05 +0200
Message-Id: <20200625214312.1382063-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625214312.1382063-1-alexandre.belloni@bootlin.com>
References: <20200625214312.1382063-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sama5d2 TC block TIMER_CLOCK1 is different from the at91sam9x5 one.
Instead of being MCK / 2, it is the TCB GCLK.

Cc: Rob Herring <robh+dt@kernel.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 42 +++++++++++++++----
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 9d680e0b9109..d226fd7d5258 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -19,6 +19,7 @@ properties:
       - enum:
           - atmel,at91rm9200-tcb
           - atmel,at91sam9x5-tcb
+          - atmel,sama5d2-tcb
       - const: simple-mfd
       - const: syscon
 
@@ -36,15 +37,6 @@ properties:
     description:
       List of clock names. Always includes t0_clk and slow clk. Also includes
       t1_clk and t2_clk if a clock per channel is available.
-    oneOf:
-      - items:
-        - const: t0_clk
-        - const: slow_clk
-      - items:
-        - const: t0_clk
-        - const: t1_clk
-        - const: t2_clk
-        - const: slow_clk
     minItems: 2
     maxItems: 4
 
@@ -75,6 +67,38 @@ patternProperties:
       - compatible
       - reg
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: atmel,sama5d2-tcb
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+        clock-names:
+          items:
+            - const: t0_clk
+            - const: gclk
+            - const: slow_clk
+    else:
+      properties:
+        clocks:
+          minItems: 2
+          maxItems: 4
+        clock-names:
+          oneOf:
+            - items:
+              - const: t0_clk
+              - const: slow_clk
+            - items:
+              - const: t0_clk
+              - const: t1_clk
+              - const: t2_clk
+              - const: slow_clk
+
 required:
   - compatible
   - reg
-- 
2.26.2

