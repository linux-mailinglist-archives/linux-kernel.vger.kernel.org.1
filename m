Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640D82DC942
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 23:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLPWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 17:51:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730242AbgLPWv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 17:51:58 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A74C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:51:18 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o19so26929912lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Dec 2020 14:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddKTn9Xl8/wZrJAUuoOV/T+vWHELgde5+/AZ3jvIKM8=;
        b=v7fuy9AXUD9bM/gJSy7sVcn5R6iY+GXNm5Qeplq9xWYNyCJlqllGAaPpCyTSRed4gT
         aI9+pAPU0ET+GRY3RNqSIGGwFDdi/+0DPMaHyiANwHBrLLY7Zuur6fiSuHyj2W97nK7Q
         cglIiVAOxyNl3us/xxf6Z1OixDcyKrgFR9V/OP2FJUhNCs5rrgK6yLwizX1IYMj9a2xK
         jfE4+o/D0Z1DxylIIB91E1AOfhsAF7aeBycOyzdXeFXkfv7h1NOlVNgHMggFsWHDXvhO
         6qfI2nVMdQzca3d7wiE7mAbLJCeyK+jg/cGcHVtOX0cB9nGnwk9onAzZl8kgK0aRh3o/
         +Gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ddKTn9Xl8/wZrJAUuoOV/T+vWHELgde5+/AZ3jvIKM8=;
        b=CpvE/8q1JbvJA77GTOb417vjOJ3vzdm9fgwsXb0o9i7C4/ZRMtXl4dNlsD2UbmIaPG
         /Oo68nvaEq93NL9gEQwfLGtHolRWw4dzMAuPD17cS909a6deY97nEQRt05qm1SEiB62P
         6AsIzU/iW/XTFinb1CfMjdaIZMuqbAqwSt2RB5bBuiO8D334zjA+zm+hUesAOvlhaFTR
         K/WjzOV/tO5QyivQEeK4Ptuj+LQcFLyI9k6YbFa7shH5MEOV4eBc63VgN/2MCgZetpzQ
         TyxQ6fnR0nkqn1HN1rnXq1lkQ2Y9rIr1tx3RI/gScn8ukfN7B7eG9y0oXuA6bRFYXwRE
         1KCw==
X-Gm-Message-State: AOAM530jUVCaEc82gnrh20bWnJO1w9AjprwhP0U+mpm68dpOWbat5/rT
        NrnOngsMxKkC3ji1kwWO/1KReA==
X-Google-Smtp-Source: ABdhPJx27jni1KGRQhFMz72fraRiUgfdPbegBhHHlXVHzvJhXUFmhLPvdhEoyREDRk5vldOvvd0WXA==
X-Received: by 2002:ac2:4108:: with SMTP id b8mr9652742lfi.544.1608159076440;
        Wed, 16 Dec 2020 14:51:16 -0800 (PST)
Received: from gilgamesh.semihalf.com (193-106-246-138.noc.fibertech.net.pl. [193.106.246.138])
        by smtp.gmail.com with ESMTPSA id v21sm438160ljk.73.2020.12.16.14.51.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Dec 2020 14:51:15 -0800 (PST)
From:   Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
To:     ssantosh@kernel.org, robh+dt@kernel.org, s-anna@ti.com
Cc:     grzegorz.jaszczyk@linaro.org, santosh.shilimkar@oracle.com,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, praneeth@ti.com,
        tony@atomide.com
Subject: [PATCH] dt-bindings: soc: ti: Update TI PRUSS bindings about schemas to include
Date:   Wed, 16 Dec 2020 23:50:27 +0100
Message-Id: <20201216225027.2681-1-grzegorz.jaszczyk@linaro.org>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now after ti,pruss-intc.yaml and ti,pru-rproc.yaml are merged, include
them in proper property and extend the examples section.

At the occasion extend the allowed property list about dma-ranges.

Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
---
 .../devicetree/bindings/soc/ti/ti,pruss.yaml  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
index 037c51b2f972..dbc62821c60b 100644
--- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
+++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
@@ -81,6 +81,9 @@ properties:
   ranges:
     maxItems: 1
 
+  dma-ranges:
+    maxItems: 1
+
   power-domains:
     description: |
       This property is as per sci-pm-domain.txt.
@@ -278,6 +281,9 @@ patternProperties:
       that is common to all the PRU cores. This should be represented as an
       interrupt-controller node.
 
+    allOf:
+      - $ref: /schemas/interrupt-controller/ti,pruss-intc.yaml#
+
     type: object
 
   mdio@[a-f0-9]+$:
@@ -299,6 +305,9 @@ patternProperties:
       present on K3 SoCs have additional auxiliary PRU cores with slightly
       different IP integration.
 
+    allOf:
+      - $ref: /schemas/remoteproc/ti,pru-rproc.yaml#
+
     type: object
 
 required:
@@ -371,6 +380,36 @@ examples:
             reg = <0x32000 0x58>;
         };
 
+        pruss_intc: interrupt-controller@20000 {
+            compatible = "ti,pruss-intc";
+            reg = <0x20000 0x2000>;
+            interrupt-controller;
+            #interrupt-cells = <3>;
+            interrupts = <20 21 22 23 24 25 26 27>;
+            interrupt-names = "host_intr0", "host_intr1",
+                              "host_intr2", "host_intr3",
+                              "host_intr4", "host_intr5",
+                              "host_intr6", "host_intr7";
+        };
+
+        pru0: pru@34000 {
+            compatible = "ti,am3356-pru";
+            reg = <0x34000 0x2000>,
+                  <0x22000 0x400>,
+                  <0x22400 0x100>;
+            reg-names = "iram", "control", "debug";
+            firmware-name = "am335x-pru0-fw";
+        };
+
+        pru1: pru@38000 {
+            compatible = "ti,am3356-pru";
+            reg = <0x38000 0x2000>,
+                  <0x24000 0x400>,
+                  <0x24400 0x100>;
+            reg-names = "iram", "control", "debug";
+            firmware-name = "am335x-pru1-fw";
+        };
+
         pruss_mdio: mdio@32400 {
             compatible = "ti,davinci_mdio";
             reg = <0x32400 0x90>;
@@ -425,6 +464,43 @@ examples:
             reg = <0x32000 0x58>;
         };
 
+        pruss1_intc: interrupt-controller@20000 {
+            compatible = "ti,pruss-intc";
+            reg = <0x20000 0x2000>;
+            interrupt-controller;
+            #interrupt-cells = <3>;
+            interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "host_intr0", "host_intr1",
+                              "host_intr2", "host_intr3",
+                              "host_intr4",
+                              "host_intr6", "host_intr7";
+            ti,irqs-reserved = /bits/ 8 <0x20>; /* BIT(5) */
+        };
+
+        pru1_0: pru@34000 {
+            compatible = "ti,am4376-pru";
+            reg = <0x34000 0x3000>,
+                  <0x22000 0x400>,
+                  <0x22400 0x100>;
+            reg-names = "iram", "control", "debug";
+            firmware-name = "am437x-pru1_0-fw";
+        };
+
+        pru1_1: pru@38000 {
+            compatible = "ti,am4376-pru";
+            reg = <0x38000 0x3000>,
+                  <0x24000 0x400>,
+                  <0x24400 0x100>;
+            reg-names = "iram", "control", "debug";
+            firmware-name = "am437x-pru1_1-fw";
+        };
+
         pruss1_mdio: mdio@32400 {
             compatible = "ti,davinci_mdio";
             reg = <0x32400 0x90>;
-- 
2.29.0

