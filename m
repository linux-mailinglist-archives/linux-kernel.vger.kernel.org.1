Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89292A2366
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbgKBDNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbgKBDNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:13:34 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74827C0617A6;
        Sun,  1 Nov 2020 19:13:33 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id r10so9555554pgb.10;
        Sun, 01 Nov 2020 19:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HCdXlX48a8RvmdjHj/hlqMoEQOf95jWIp2S8h1+Enm4=;
        b=pG6myEN7HobMU6QX0JehxmqLDwQzDyh9qseEX7wynfKMF1iim9xl+ab2wIMZU6miJU
         gIFYvbmItyGZBpn7U8kRhoDoHyLdJTY4TwmJrD+CDW5oSFNwPqJTZeDpA+76fbcCBtle
         ILZ5EDfP+Rs8ehl+Lub8IVgDWU9w2G5D8Z0YvC186HS9ck241gb3kZF1hucWQEDnuzT+
         wUlHSNINRkbQzXA2h80oV8hUyXQSNXlUloCKaCGfKal+gKiJS+mnwwiWPYASCu9gw67n
         fon+/iObRB4Ud0sH/enbGkvwFGvVTlqQrdqVF2HcJEDofsL2qFRG5mgN4Jbi9YZiLhfx
         hULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HCdXlX48a8RvmdjHj/hlqMoEQOf95jWIp2S8h1+Enm4=;
        b=NZO4orKe/X3qgo5aJJW97UNGB1pFHNhHLubOf7kbuuJiHZETClQLN4KcJMZWt06Yv6
         yAGgNqG+yQUFoq7XSmAOV1P6hriQGSVnGZl9PrgySRh09sSVZHvFR/fiGTFmC2JVQoTZ
         1ddvIc+9csE/sN3QwSc5eL2d8vrITWa6Yftyy4vUIvjLoqiCTsHyJ/PckXqERZupuXhd
         5xo+Qj6cpsXiwAUyna8V1CQY+LnpBLpQ8yWqM84q9n9k2Qs8VrqW3Dq8kBkyAPlz6pPJ
         e9kqIdQtmey8mYbDyb//ihJyAO/OF2NQmypd0xQrYiUrcOvyNSnZvqzU0/OAiY5heLi1
         Vgdw==
X-Gm-Message-State: AOAM533P1W2REsIE1QLwJ2kykb/pMAAlyfeMVSZVloQEZWqQMYML7gzS
        qRQAe9JOQb6qfFbqD4dQ+wM=
X-Google-Smtp-Source: ABdhPJwqnHoHdtkDsHiamjO3frM4FpErtxZdhAgZvszTFJcluKh4f1X0fiHQOC/Snwwzwns/4S/XaA==
X-Received: by 2002:aa7:989a:0:b029:18a:8d62:e024 with SMTP id r26-20020aa7989a0000b029018a8d62e024mr10920208pfl.71.1604286812982;
        Sun, 01 Nov 2020 19:13:32 -0800 (PST)
Received: from localhost.localdomain ([2402:7500:57c:483e:4828:fb14:ce19:d9d0])
        by smtp.gmail.com with ESMTPSA id y137sm12368408pfc.77.2020.11.01.19.13.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2020 19:13:32 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] mfd: rt4505: Adds DT binding document for Richtek RT4831 MFD core
Date:   Mon,  2 Nov 2020 11:13:23 +0800
Message-Id: <1604286803-20698-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
References: <1604286803-20698-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 MFD core.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 89 ++++++++++++++++++++++
 include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
 2 files changed, 112 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
 create mode 100644 include/dt-bindings/leds/rt4831-backlight.h

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
new file mode 100644
index 00000000..c602d50
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/richtek,rt4831.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4831 DSV and Backlight Integrated IC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4831 is a mutifunctional device that can provide display panel power for
+  positive/negative voltage and also display panel wled driving.
+
+  For the display voltage output, the range is about 4V to 6.5V. It is sufficient
+  to meet the current display panel design.
+
+  For the panel backlight, it can provide four channels driving capability
+  Each driving current is up to 30mA
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
+
+properties:
+  compatible:
+    const: richtek,rt4831
+
+  reg:
+    description: I2C device address.
+    maxItems: 1
+
+  enable-gpios:
+    description: |
+      GPIO to enable/disable the chip. It is optional.
+      Some usage directly tied this pin to follow VIO 1.8V power on sequence.
+    maxItems: 1
+
+  regulators:
+    $ref: ../regulator/richtek,rt4831-regulator.yaml
+
+  backlight:
+    $ref: ../leds/backlight/richtek,rt4831-backlight.yaml
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/rt4831-backlight.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt4831@11 {
+        compatible = "richtek,rt4831";
+        reg = <0x11>;
+
+        regulators {
+          DSVLCM {
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <7150000>;
+          };
+          DSVP {
+            regulator-name = "rt4831-dsvp";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6500000>;
+            regulator-boot-on;
+          };
+          DSVN {
+            regulator-name = "rt4831-dsvn";
+            regulator-min-microvolt = <4000000>;
+            regulator-max-microvolt = <6500000>;
+            regulator-boot-on;
+          };
+        };
+
+        backlight {
+          compatible = "richtek,rt4831-backlight";
+          default-brightness = <1024>;
+          max-brightness = <2048>;
+          richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
+          richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
+        };
+      };
+    };
diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
new file mode 100644
index 00000000..7084906
--- /dev/null
+++ b/include/dt-bindings/leds/rt4831-backlight.h
@@ -0,0 +1,23 @@
+/*
+ * This header provides constants for rt4831 backlight bindings.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef _DT_BINDINGS_RT4831_BACKLIGHT_H
+#define _DT_BINDINGS_RT4831_BACKLIGHT_H
+
+#define RT4831_BLOVPLVL_17V	0
+#define RT4831_BLOVPLVL_21V	1
+#define RT4831_BLOVPLVL_25V	2
+#define RT4831_BLOVPLVL_29V	3
+
+#define RT4831_BLED_CH1EN	(1 << 0)
+#define RT4831_BLED_CH2EN	(1 << 1)
+#define RT4831_BLED_CH3EN	(1 << 2)
+#define RT4831_BLED_CH4EN	(1 << 3)
+#define RT4831_BLED_ALLCHEN	((1 << 4) - 1)
+
+#endif /* _DT_BINDINGS_RT4831_BACKLIGHT_H */
-- 
2.7.4

