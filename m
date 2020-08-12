Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9364242D39
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgHLQaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 12:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:30:07 -0400
Received: from localhost.localdomain (unknown [194.230.155.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 795AD20829;
        Wed, 12 Aug 2020 16:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597249807;
        bh=5VABsIIOTga9jxbpTZ9xoI/0EbnuZPCPq7dvahWwSbw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=NGwsw6qgrFncoA3JUoHci5WNkSQFa83YxK1ZIs/n5ayPTkBq9ZeDxz1ysyK73qEvQ
         PGS7KXmrF386lxMgSLzxZvftek4ZplsMApoke+PDrDur5Gyv/k7dYl/1jZz5qabDT+
         oJelA5TB8Nk+hB5xFPNOfQU3TE/efKe5fCFEB+8Y=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 02/11] dt-bindings: extcon: ptn5150: Use generic "interrupts" property
Date:   Wed, 12 Aug 2020 18:29:49 +0200
Message-Id: <20200812162958.6180-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812162958.6180-1-krzk@kernel.org>
References: <20200812162958.6180-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interrupts do not have to be always GPIO based so instead of expecting
"int-gpios" property and converting the GPIO to an interrupt, just
accept any interrupt via generic "interrupts" property.

Mark the old "int-gpios" as deprecated.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml    | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
index f6316f12028b..1ddc97db3e61 100644
--- a/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
+++ b/Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -19,8 +19,13 @@ properties:
     const: nxp,ptn5150
 
   int-gpios:
+    deprecated: true
     description:
       GPIO pin (input) connected to the PTN5150's INTB pin.
+      Use "interrupts" instead.
+
+  interrupts:
+    maxItems: 1
 
   reg:
     maxItems: 1
@@ -31,7 +36,7 @@ properties:
 
 required:
   - compatible
-  - int-gpios
+  - interrupts
   - reg
   - vbus-gpios
 
@@ -40,6 +45,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -47,7 +53,8 @@ examples:
         ptn5150@1d {
             compatible = "nxp,ptn5150";
             reg = <0x1d>;
-            int-gpios = <&msmgpio 78 GPIO_ACTIVE_HIGH>;
+            interrupt-parent = <&msmgpio>;
+            interrupts = <78 IRQ_TYPE_LEVEL_HIGH>;
             vbus-gpios = <&msmgpio 148 GPIO_ACTIVE_HIGH>;
         };
     };
-- 
2.17.1

