Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1ED2CDF12
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:36:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389449AbgLCTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389423AbgLCTey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:34:54 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48CC08E85E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:33:35 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id r3so3070416wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avI939uymM6/znF8sjFbCmjEM/tTuWCPGzqcQmFJZFA=;
        b=kgMzstu5S+3cVvGiecrI5zAWY56sMF3vhSzYhWTX5SEGPd5ILz4J6Sm98rpTHrkAF7
         9qpKnbmOnyZk6Cvu+Vt3cJm4iasa/6RJ3l0biugbuv+mgxstCQKRJyFRjPqHFXnewZ7h
         ++/+NOSeQlibxp05Ol0JPRkPfI7E8DhQi1IC/d2ExJNj+p0Wnt7rkjKcvCRp2INaz5YC
         TlBRm6Tl37P7YhOc6czamTY31Z5SjA49mtBA0rR8T38CZpBwmjxPC9PB2FlU4BG0MnBQ
         KBMAHQ2b8WkT1EHvRw3KWxxzja1v4tzk9CtB1AbIifYfdW8q5e8kA3pCJCsmtodhTdDL
         lpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avI939uymM6/znF8sjFbCmjEM/tTuWCPGzqcQmFJZFA=;
        b=j226rIWcKc6ABNtjjM+9bIMfQwVGpNZoA/IySxFKq7e+JSj7QXOoaksiccdkcVXEwg
         KfUfKe9x6iRMd6WlwNtA/yIeMp/sxe4sBr4scRjP79WrSN80A8PvHlUE5+ugfsVt21pG
         ryz13lTqPu4o5gZruccL4Z2gflEQJ80H+3i4R9MOTgbSDvlIN3GAdaPvFWeN2/+SMrGb
         fN3PyuZJhRjFkNWjb0BeOjyLRI/2UcVgDpJEGDJHunZJUSW/S0hJrJ/S5q9tMkYVYtdp
         q7MEDBZbI3ybYPCBDoPefLJ7y+Tk9cpFE+GA0K7o+Hm8sLLT5r2lLplv7HpDtAf6RdHk
         VGeA==
X-Gm-Message-State: AOAM5318emtKYxuo0bPQTW6srvXy1SEcLraoyEaCH/m3iWyj+ArXssEC
        5Zg4A5kdorScm6/lggx6m0MayHZmbvZidw==
X-Google-Smtp-Source: ABdhPJx7ywzHmlt017S8wvc2puXYfBeKkVYuvx5kFKjAvsT7xQI/iFeEQ2WHTcdleQSxAhhImQPLMg==
X-Received: by 2002:a5d:5741:: with SMTP id q1mr839905wrw.160.1607024014160;
        Thu, 03 Dec 2020 11:33:34 -0800 (PST)
Received: from mai.imgcgcw.net ([2a01:e34:ed2f:f020:9cff:9584:adb2:6288])
        by smtp.gmail.com with ESMTPSA id o83sm382441wme.21.2020.12.03.11.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 11:33:33 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] dt-bindings: timer: renesas: tmu: Convert to json-schema
Date:   Thu,  3 Dec 2020 20:32:58 +0100
Message-Id: <20201203193301.2405835-10-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201203193301.2405835-1-daniel.lezcano@linaro.org>
References: <028084fa-d29b-a1d5-7eab-17f77ef69863@linaro.org>
 <20201203193301.2405835-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Convert the Renesas R-Mobile/R-Car Timer Unit (TMU) Device Tree binding
documentation to json-schema.

Document missing properties.
Update the example to match reality.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Link: https://lore.kernel.org/r/20201110162014.3290109-3-geert+renesas@glider.be
---
 .../devicetree/bindings/timer/renesas,tmu.txt | 50 ----------
 .../bindings/timer/renesas,tmu.yaml           | 99 +++++++++++++++++++
 2 files changed, 99 insertions(+), 50 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.txt
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,tmu.yaml

diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
deleted file mode 100644
index a36cd61e74fb..000000000000
--- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
+++ /dev/null
@@ -1,50 +0,0 @@
-* Renesas R-Mobile/R-Car Timer Unit (TMU)
-
-The TMU is a 32-bit timer/counter with configurable clock inputs and
-programmable compare match.
-
-Channels share hardware resources but their counter and compare match value
-are independent. The TMU hardware supports up to three channels.
-
-Required Properties:
-
-  - compatible: must contain one or more of the following:
-    - "renesas,tmu-r8a7740" for the r8a7740 TMU
-    - "renesas,tmu-r8a774a1" for the r8a774A1 TMU
-    - "renesas,tmu-r8a774b1" for the r8a774B1 TMU
-    - "renesas,tmu-r8a774c0" for the r8a774C0 TMU
-    - "renesas,tmu-r8a774e1" for the r8a774E1 TMU
-    - "renesas,tmu-r8a7778" for the r8a7778 TMU
-    - "renesas,tmu-r8a7779" for the r8a7779 TMU
-    - "renesas,tmu-r8a77970" for the r8a77970 TMU
-    - "renesas,tmu-r8a77980" for the r8a77980 TMU
-    - "renesas,tmu" for any TMU.
-      This is a fallback for the above renesas,tmu-* entries
-
-  - reg: base address and length of the registers block for the timer module.
-
-  - interrupts: interrupt-specifier for the timer, one per channel.
-
-  - clocks: a list of phandle + clock-specifier pairs, one for each entry
-    in clock-names.
-  - clock-names: must contain "fck" for the functional clock.
-
-Optional Properties:
-
-  - #renesas,channels: number of channels implemented by the timer, must be 2
-    or 3 (if not specified the value defaults to 3).
-
-
-Example: R8A7779 (R-Car H1) TMU0 node
-
-	tmu0: timer@ffd80000 {
-		compatible = "renesas,tmu-r8a7779", "renesas,tmu";
-		reg = <0xffd80000 0x30>;
-		interrupts = <0 32 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 33 IRQ_TYPE_LEVEL_HIGH>,
-			     <0 34 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
-		clock-names = "fck";
-
-		#renesas,channels = <3>;
-	};
diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.yaml b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
new file mode 100644
index 000000000000..c54188731a1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/renesas,tmu.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/renesas,tmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R-Mobile/R-Car Timer Unit (TMU)
+
+maintainers:
+  - Geert Uytterhoeven <geert+renesas@glider.be>
+  - Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
+
+description:
+  The TMU is a 32-bit timer/counter with configurable clock inputs and
+  programmable compare match.
+
+  Channels share hardware resources but their counter and compare match value
+  are independent. The TMU hardware supports up to three channels.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - renesas,tmu-r8a7740  # R-Mobile A1
+          - renesas,tmu-r8a774a1 # RZ/G2M
+          - renesas,tmu-r8a774b1 # RZ/G2N
+          - renesas,tmu-r8a774c0 # RZ/G2E
+          - renesas,tmu-r8a774e1 # RZ/G2H
+          - renesas,tmu-r8a7778  # R-Car M1A
+          - renesas,tmu-r8a7779  # R-Car H1
+          - renesas,tmu-r8a77970 # R-Car V3M
+          - renesas,tmu-r8a77980 # R-Car V3H
+      - const: renesas,tmu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 2
+    maxItems: 3
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  '#renesas,channels':
+    description:
+      Number of channels implemented by the timer.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 2, 3 ]
+    default: 3
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - power-domains
+
+if:
+  not:
+    properties:
+      compatible:
+        contains:
+          enum:
+            - renesas,tmu-r8a7740
+            - renesas,tmu-r8a7778
+            - renesas,tmu-r8a7779
+then:
+  required:
+    - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r8a7779-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/r8a7779-sysc.h>
+    tmu0: timer@ffd80000 {
+            compatible = "renesas,tmu-r8a7779", "renesas,tmu";
+            reg = <0xffd80000 0x30>;
+            interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&mstp0_clks R8A7779_CLK_TMU0>;
+            clock-names = "fck";
+            power-domains = <&sysc R8A7779_PD_ALWAYS_ON>;
+            #renesas,channels = <3>;
+    };
-- 
2.25.1

