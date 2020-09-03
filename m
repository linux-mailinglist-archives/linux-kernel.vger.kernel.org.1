Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF225C927
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 21:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgICTNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 15:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgICTN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:13:28 -0400
Received: from localhost.localdomain (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3415B208CA;
        Thu,  3 Sep 2020 19:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599160408;
        bh=kz/Uqq2oMfLmGSiuriAAU+P69b2k+xxFqKh/1NQEKh8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Zt6iYc8LImn017WG47ATpl6LGIMnqKGsZiPyQfhq44ZgU6uYncL7xVkm7IyliFOMh
         9UBi928x31zO7QzHetsxpaCelTn+/HNa0n0E2jbfSoN3/YdcCEbIvhqSN3BkAwDZ9G
         1s8o1mB4j1gsbj+5rSp7pwctlXb0E+ExdE1uWsUA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: timer: exynos4210-mct: Add missing clocks
Date:   Thu,  3 Sep 2020 21:13:11 +0200
Message-Id: <20200903191311.12293-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903191311.12293-1-krzk@kernel.org>
References: <20200903191311.12293-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Exynos Multi Core Timer driver requires two clocks.  This was never
documented in the binding.  Add it to fix dtschema warnings like:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: timer@101c0000:
    'clock-names', 'clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Add properties instead of using unevaluated
---
 .../timer/samsung,exynos4210-mct.yaml         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 37bd01a62c52..f11cbc7ccc14 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -23,6 +23,15 @@ properties:
       - samsung,exynos4210-mct
       - samsung,exynos4412-mct
 
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - pattern: "^(fin_pll|mct)$"
+      - pattern: "^(fin_pll|mct)$"
+
   reg:
     maxItems: 1
 
@@ -49,6 +58,8 @@ properties:
 
 required:
   - compatible
+  - clock-names
+  - clocks
   - interrupts
   - reg
 
@@ -59,11 +70,15 @@ examples:
     // In this example, the IP contains two local timers, using separate
     // interrupts, so two local timer interrupts have been specified,
     // in addition to four global timer interrupts.
+    #include <dt-bindings/clock/exynos4.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@10050000 {
         compatible = "samsung,exynos4210-mct";
         reg = <0x10050000 0x800>;
+        clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+        clock-names = "fin_pll", "mct";
+
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>,
@@ -75,11 +90,15 @@ examples:
   - |
     // In this example, the timer interrupts are connected to two separate
     // interrupt controllers. Hence, an interrupts-extended is needed.
+    #include <dt-bindings/clock/exynos4.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@101c0000 {
         compatible = "samsung,exynos4210-mct";
         reg = <0x101C0000 0x800>;
+        clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+        clock-names = "fin_pll", "mct";
+
         interrupts-extended = <&gic GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
                               <&gic GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
                               <&combiner 12 6>,
@@ -92,11 +111,14 @@ examples:
     // In this example, the IP contains four local timers, but using
     // a per-processor interrupt to handle them. Only one first local
     // interrupt is specified.
+    #include <dt-bindings/clock/exynos4.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@10050000 {
         compatible = "samsung,exynos4412-mct";
         reg = <0x10050000 0x800>;
+        clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+        clock-names = "fin_pll", "mct";
 
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
@@ -109,11 +131,14 @@ examples:
     // In this example, the IP contains four local timers, but using
     // a per-processor interrupt to handle them. All the local timer
     // interrupts are specified.
+    #include <dt-bindings/clock/exynos4.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     timer@10050000 {
         compatible = "samsung,exynos4412-mct";
         reg = <0x10050000 0x800>;
+        clocks = <&clock CLK_FIN_PLL>, <&clock CLK_MCT>;
+        clock-names = "fin_pll", "mct";
 
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
                      <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.17.1

