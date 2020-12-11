Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFBB2D7B02
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387518AbgLKQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:34:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgLKQej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:34:39 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D07C061793;
        Fri, 11 Dec 2020 08:33:59 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id w4so7434025pgg.13;
        Fri, 11 Dec 2020 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MWZVdQb65UvffD2rsWoIjXQ5z3HiRH+Vs9QXXd5Wk9o=;
        b=KtGW3ANFi2zjk6PZad3PgB3vF5V47dX+nFsJDBCy6NP1mtP5Rxg9U8PNIDdDsi5NZ9
         9LkGx/Q3TnrjDl5lsIYwNH3NVsvd8v5k/fSLE0yVRzcP9mzM4aXSucbibxdVEZjYMuii
         4K0lRw/bfBVbt5VO31UMBs9DE/C2TFXlgfR1GC/3K0ysNmBgzUZnWH1HDzC+vA7DHhn4
         NHpdbJ+ulLS3fwQ1KhKdwZjsuTKs628kOq0ajG2Xa6tFmuXcOv5kMYwNaHe+6YdTgg1W
         UHpz46Mpgh8EJZ+/0BRWCVn/dJkt6ZqLCH4h9nmtdFCmfUlnY6MdSrcea3NZauSW2WAK
         P1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MWZVdQb65UvffD2rsWoIjXQ5z3HiRH+Vs9QXXd5Wk9o=;
        b=eS1TtJea+ypVuZWX/dB4XMrdLr/ZpZ35fUFDkI1y4vfgrqF79VNwjpjRmkmTUTQNHr
         UxgTQ1Ode5pQSp5EI88WphcAExRklElHYQkFHfFeGJ3kQ8NfqfI8LJfg2iMOKuM+CJj8
         b1wzRsb3PXofCIHM2hLSj+OcN5uDGfDtRC2uFdvPaeCqW320Iu//lGP973R1gPSRpAs3
         NMgS/c3EQUQxv6acMd1XcdbosKpZhhamRIXZgIykmvLrczxSJfJr4u/H+g/86Xc06c7/
         zLEyBj8/ssKQ/BjUwc7FI3BmSClWyXIdHoejZppHjPPBYg6qhs+R16IgeSPglnDRh/QO
         LF1Q==
X-Gm-Message-State: AOAM530mJaYK0GIyXNj1S+VIgC8MWeCeLXYxka2Wct9LWi7yB3d52gcV
        jFTR79caNEOE2NAqCorrgFE=
X-Google-Smtp-Source: ABdhPJxGnFX9uyxQOBBgK5sn/OGxyNbY+KfeNBlwo/B3p++6q5x3qMRMFUfEKoLOl3q/8Fd9DljMcw==
X-Received: by 2002:aa7:843a:0:b029:19d:b279:73c9 with SMTP id q26-20020aa7843a0000b029019db27973c9mr12513626pfn.3.1607704438491;
        Fri, 11 Dec 2020 08:33:58 -0800 (PST)
Received: from localhost.localdomain (1-171-10-206.dynamic-ip.hinet.net. [1.171.10.206])
        by smtp.gmail.com with ESMTPSA id gm18sm7987947pjb.55.2020.12.11.08.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 08:33:57 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/3] backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight
Date:   Sat, 12 Dec 2020 00:33:43 +0800
Message-Id: <1607704424-16223-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 backlight.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v3
- Move inlcude/dt-bindings/leds/rt4831-backlight.h from v3 mfd binding patch to here.
- Add dual license tag in header and backlight binding document.
- Left backlight dt-binding example only.
---
 .../leds/backlight/richtek,rt4831-backlight.yaml   | 76 ++++++++++++++++++++++
 include/dt-bindings/leds/rt4831-backlight.h        | 23 +++++++
 2 files changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
 create mode 100644 include/dt-bindings/leds/rt4831-backlight.h

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
new file mode 100644
index 00000000..f24c8d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/richtek,rt4831-backlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Richtek RT4831 Backlight
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  RT4831 is a mutifunctional device that can provide power to the LCD display
+  and LCD backlight.
+
+  For the LCD backlight, it can provide four channel WLED driving capability.
+  Each channel driving current is up to 30mA
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RT4831A/DS4831A-05.pdf
+
+properties:
+  compatible:
+    const: richtek,rt4831-backlight
+
+  default-brightness:
+    description: |
+      The default brightness that applied to the system on start-up.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 2048
+
+  max-brightness:
+    description: |
+      The max brightness for the H/W limit
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 2048
+
+  richtek,pwm-enable:
+    description: |
+      Specify the backlight dimming following by PWM duty or by SW control.
+    type: boolean
+
+  richtek,bled-ovp-sel:
+    description: |
+      Backlight OVP level selection, currently support 17V/21V/25V/29V.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    default: 1
+    minimum: 0
+    maximum: 3
+
+  richtek,channel-use:
+    description: |
+      Backlight LED channel to be used.
+      BIT 0/1/2/3 is used to indicate led channel 1/2/3/4 enable or disable.
+    $ref: /schemas/types.yaml#/definitions/uint8
+    minimum: 1
+    maximum: 15
+
+required:
+  - compatible
+  - richtek,channel-use
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/leds/rt4831-backlight.h>
+    backlight {
+      compatible = "richtek,rt4831-backlight";
+      default-brightness = <1024>;
+      max-brightness = <2048>;
+      richtek,bled-ovp-sel = /bits/ 8 <RT4831_BLOVPLVL_21V>;
+      richtek,channel-use = /bits/ 8 <RT4831_BLED_ALLCHEN>;
+    };
diff --git a/include/dt-bindings/leds/rt4831-backlight.h b/include/dt-bindings/leds/rt4831-backlight.h
new file mode 100644
index 00000000..125c635
--- /dev/null
+++ b/include/dt-bindings/leds/rt4831-backlight.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for rt4831 backlight bindings.
+ *
+ * Copyright (C) 2020, Richtek Technology Corp.
+ * Author: ChiYuan Huang <cy_huang@richtek.com>
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

