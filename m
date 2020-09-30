Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856CA27E63A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 12:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbgI3KIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 06:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3KIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 06:08:10 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01D8C061755;
        Wed, 30 Sep 2020 03:08:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o8so740386pll.4;
        Wed, 30 Sep 2020 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J79PYh+YG6CxEahOKOzwWNzxXckvEZvz+zkRIh8R3bk=;
        b=aqnRTB3P9Gc961joSkJGkqWS6p98cxn134wjmt2cjr+w+xbHA6xi/QyliX3KEujMv3
         bHQxMr05DeQFl9yyIoWZIz9SrhjtUkii1Mui5tHFoH91EVqU/ngkr8IFmj2PoZFIG3QB
         s7M1/i3F0KtDY9vr4Zn3+tMuqVZBMRzChlxowshvo8gmLlRe3Lv5aI+t3iRqfPhDeZzY
         0m6To2hJq0AXPxUewkT2ejTlpHpnClr4ZQIf/CEQzQ63mRWvkQhUaGwRSOBaumQ/sYVo
         P+LMhdOy6YCfddV7T7191L782Zw4nymcFKQjr/CAr5VSdHB3RMra6BVWgci1H97ngVsU
         zhCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J79PYh+YG6CxEahOKOzwWNzxXckvEZvz+zkRIh8R3bk=;
        b=UHP/MTuQ8nNp8shTx3/aYCStwXY++thFzb1L8cQvRkfRG2pHO+2mJT3zZifL/hBsVH
         E1M/I8yWhtGx62NbFqclL9UWY9mMCcitD65evl25X4Oh5XjiF+pF6tuVITH/LdT/S+z0
         hvvmtF+XkwBABeweXQ6vXfl0hUAt2b/6Uy95L6FNw+fRll5ZfXQmHkLSiymcIKduS6MB
         NmoCWaWIxXNHl9PolRFDrpiMu+lfJKhMzcQP6VYv8xk7A4TW29lBYqSiRsTwKVwP+ywi
         B/reAUx/GewcJPxwMLhPSzVaIzfvW5myEcMfY2O+L0dslYCidHbC91HQaWxtaXLMM9KI
         /kJA==
X-Gm-Message-State: AOAM533QfhcNdbs/9i+QfoXSp8QONYd4UxTaIKJRBx1KQijUiQ9tFgib
        Io0IhVoLKTalWQbz/n1lZVED3EHqRZ8=
X-Google-Smtp-Source: ABdhPJyRu1hQOQHXNEFOdH6oRtNCGsOsgoAe3yUUkFVzXXnn5JKOyd7LbzPNdJZEeZsF31Rc7PiJdw==
X-Received: by 2002:a17:902:8c8b:b029:d2:6356:8b43 with SMTP id t11-20020a1709028c8bb02900d263568b43mr1742662plo.34.1601460488076;
        Wed, 30 Sep 2020 03:08:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:46b:9c58:dff:2627:f8ff:93b4])
        by smtp.gmail.com with ESMTPSA id 25sm1736396pgo.34.2020.09.30.03.08.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2020 03:08:07 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] regulator: rtmv20: Update DT binding document and property name parsing
Date:   Wed, 30 Sep 2020 18:08:00 +0800
Message-Id: <1601460480-4259-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

1. Add vendor suffix to all proprietary properties.
2. Fix typo.
3. Change lsw to normal property, not pattern property.
4. Due to item 1, modify source code for property parsing.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../regulator/richtek,rtmv20-regulator.yaml        | 53 +++++++++-------------
 drivers/regulator/rtmv20-regulator.c               | 36 ++++++++-------
 2 files changed, 42 insertions(+), 47 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
index 4cb4b68..a8ccb5c 100644
--- a/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/richtek,rtmv20-regulator.yaml
@@ -26,108 +26,99 @@ properties:
 
   wakeup-source: true
 
-  interrupts-extend:
+  interrupts:
     maxItems: 1
 
   enable-gpios:
     description: A connection of the 'enable' gpio line.
     maxItems: 1
 
-  ld-pulse-delay-us:
+  richtek,ld-pulse-delay-us:
     description: |
       load current pulse delay in microsecond after strobe pin pulse high.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
     maximum: 100000
     default: 0
 
-  ld-pulse-width-us:
+  richtek,ld-pulse-width-us:
     description: |
       Load current pulse width in microsecond after strobe pin pulse high.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
     maximum: 10000
     default: 1200
 
-  fsin1-delay-us:
+  richtek,fsin1-delay-us:
     description: |
       Fsin1 pulse high delay in microsecond after vsync signal pulse high.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
     maximum: 100000
     default: 23000
 
-  fsin1-width-us:
+  richtek,fsin1-width-us:
     description: |
       Fsin1 pulse high width in microsecond after vsync signal pulse high.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 40
     maximum: 10000
     default: 160
 
-  fsin2-delay-us:
+  richtek,fsin2-delay-us:
     description: |
       Fsin2 pulse high delay in microsecond after vsync signal pulse high.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
     maximum: 100000
     default: 23000
 
-  fsin2-width-us:
+  richtek,fsin2-width-us:
     description: |
       Fsin2 pulse high width in microsecond after vsync signal pulse high.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 40
     maximum: 10000
     default: 160
 
-  es-pulse-width-us:
+  richtek,es-pulse-width-us:
     description: Eye safety function pulse width limit in microsecond.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
     maximum: 10000
     default: 1200
 
-  es-ld-current-microamp:
+  richtek,es-ld-current-microamp:
     description: Eye safety function load current limit in microamp.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 0
     maximum: 6000000
     default: 3000000
 
-  lbp-level-microvolt:
+  richtek,lbp-level-microvolt:
     description: Low battery protection level in microvolt.
-    $ref: "/schemas/types.yaml#/definitions/uint32"
     minimum: 2400000
     maximum: 3700000
     default: 2700000
 
-  lbp-enable:
+  richtek,lbp-enable:
     description: Low battery protection function enable control.
     type: boolean
 
-  strobe-polarity-high:
+  richtek,strobe-polarity-high:
     description: Strobe pin active polarity control.
     type: boolean
 
-  vsync-polarity-high:
+  richtek,vsync-polarity-high:
     description: Vsync pin active polarity control.
     type: boolean
 
-  fsin-enable:
+  richtek,fsin-enable:
     description: Fsin function enable control.
     type: boolean
 
-  fsin-output:
+  richtek,fsin-output:
     description: Fsin function output control.
     type: boolean
 
-  es-enable:
+  richtek,es-enable:
     description: Eye safety function enable control.
     type: boolean
 
-patternProperties:
-  "lsw":
+  lsw:
+    description: load switch current regulator description.
     type: object
     $ref: "regulator.yaml#"
 
@@ -135,7 +126,7 @@ required:
   - compatible
   - reg
   - wakeup-source
-  - interrupts-extend
+  - interrupts
   - enable-gpios
   - lsw
 
@@ -152,11 +143,11 @@ examples:
         compatible = "richtek,rtmv20";
         reg = <0x34>;
         wakeup-source;
-        interrupts-extend = <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;
+        interrupts-extended = <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;
         enable-gpios = <&gpio26 3 0>;
 
-        strobe-polarity-high;
-        vsync-polarity-high;
+        richtek,strobe-polarity-high;
+        richtek,vsync-polarity-high;
 
         lsw {
                 regulator-name = "rtmv20,lsw";
diff --git a/drivers/regulator/rtmv20-regulator.c b/drivers/regulator/rtmv20-regulator.c
index 1075b10..05fd8e7c 100644
--- a/drivers/regulator/rtmv20-regulator.c
+++ b/drivers/regulator/rtmv20-regulator.c
@@ -166,28 +166,32 @@ static int rtmv20_properties_init(struct rtmv20_priv *priv)
 		u32 addr;
 		u32 mask;
 	} props[] = {
-		{ "ld-pulse-delay-us", 0, 0, 100000, 100, RTMV20_REG_PULSEDELAY,
+		{ "richtek,ld-pulse-delay-us", 0, 0, 100000, 100, RTMV20_REG_PULSEDELAY,
 			RTMV20_DELAY_MASK },
-		{ "ld-pulse-width-us", 1200, 0, 10000, 1, RTMV20_REG_PULSEWIDTH,
+		{ "richtek,ld-pulse-width-us", 1200, 0, 10000, 1, RTMV20_REG_PULSEWIDTH,
 			RTMV20_WIDTH_MASK },
-		{ "fsin1-delay-us", 23000, 0, 100000, 100, RTMV20_REG_FSIN1CTRL1,
+		{ "richtek,fsin1-delay-us", 23000, 0, 100000, 100, RTMV20_REG_FSIN1CTRL1,
 			RTMV20_DELAY_MASK },
-		{ "fsin1-width-us", 160, 40, 10000, 40, RTMV20_REG_FSIN1CTRL3, RTMV20_WIDTH2_MASK },
-		{ "fsin2-delay-us", 23000, 0, 100000, 100, RTMV20_REG_FSIN2CTRL1,
+		{ "richtek,fsin1-width-us", 160, 40, 10000, 40, RTMV20_REG_FSIN1CTRL3,
+			RTMV20_WIDTH2_MASK },
+		{ "richtek,fsin2-delay-us", 23000, 0, 100000, 100, RTMV20_REG_FSIN2CTRL1,
 			RTMV20_DELAY_MASK },
-		{ "fsin2-width-us", 160, 40, 10000, 40, RTMV20_REG_FSIN2CTRL3, RTMV20_WIDTH2_MASK },
-		{ "es-pulse-width-us", 1200, 0, 10000, 1, RTMV20_REG_ESPULSEWIDTH,
+		{ "richtek,fsin2-width-us", 160, 40, 10000, 40, RTMV20_REG_FSIN2CTRL3,
+			RTMV20_WIDTH2_MASK },
+		{ "richtek,es-pulse-width-us", 1200, 0, 10000, 1, RTMV20_REG_ESPULSEWIDTH,
 			RTMV20_WIDTH_MASK },
-		{ "es-ld-current-microamp", 3000000, 0, 6000000, 30000, RTMV20_REG_ESLDCTRL1,
-			RTMV20_LDCURR_MASK },
-		{ "lbp-level-microvolt", 2700000, 2400000, 3700000, 100000, RTMV20_REG_LBP,
+		{ "richtek,es-ld-current-microamp", 3000000, 0, 6000000, 30000,
+			RTMV20_REG_ESLDCTRL1, RTMV20_LDCURR_MASK },
+		{ "richtek,lbp-level-microvolt", 2700000, 2400000, 3700000, 100000, RTMV20_REG_LBP,
 			RTMV20_LBPLVL_MASK },
-		{ "lbp-enable", 0, 0, 1, 1, RTMV20_REG_LBP, RTMV20_LBPEN_MASK },
-		{ "strobe-polarity-high", 1, 0, 1, 1, RTMV20_REG_LDCTRL2, RTMV20_STROBEPOL_MASK },
-		{ "vsync-polarity-high", 1, 0, 1, 1, RTMV20_REG_LDCTRL2, RTMV20_VSYNPOL_MASK },
-		{ "fsin-enable", 0, 0, 1, 1, RTMV20_REG_ENCTRL, RTMV20_FSINEN_MASK },
-		{ "fsin-output", 0, 0, 1, 1, RTMV20_REG_ENCTRL, RTMV20_FSINOUT_MASK },
-		{ "es-enable", 0, 0, 1, 1, RTMV20_REG_ENCTRL, RTMV20_ESEN_MASK },
+		{ "richtek,lbp-enable", 0, 0, 1, 1, RTMV20_REG_LBP, RTMV20_LBPEN_MASK },
+		{ "richtek,strobe-polarity-high", 1, 0, 1, 1, RTMV20_REG_LDCTRL2,
+			RTMV20_STROBEPOL_MASK },
+		{ "richtek,vsync-polarity-high", 1, 0, 1, 1, RTMV20_REG_LDCTRL2,
+			RTMV20_VSYNPOL_MASK },
+		{ "richtek,fsin-enable", 0, 0, 1, 1, RTMV20_REG_ENCTRL, RTMV20_FSINEN_MASK },
+		{ "richtek,fsin-output", 0, 0, 1, 1, RTMV20_REG_ENCTRL, RTMV20_FSINOUT_MASK },
+		{ "richtek,es-enable", 0, 0, 1, 1, RTMV20_REG_ENCTRL, RTMV20_ESEN_MASK },
 	};
 	int i, ret;
 
-- 
2.7.4

