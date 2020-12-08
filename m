Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDAD2D2ECB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgLHPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730208AbgLHPzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:47 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6D6C0613D6;
        Tue,  8 Dec 2020 07:55:01 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id c12so7175866pfo.10;
        Tue, 08 Dec 2020 07:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SippBiPvnRnapzXhq7fOVJkKRsVVBzMZERi+BPHUIs4=;
        b=ch+eqqGXD00JXvr/ff7iqUJaF80VHgnLYOiJoJnCmwT/2wTaJnx8t/aBPfAIXbaTqy
         EYiTM/jBU3NomitdB7PoZIrn4FNJzxBRDPwUYcTrvWmqrHfc+sMGrU6POoqZ4f+ZNfmw
         WNFsw5vvW7BjjAXMzmHfJSHdYkU3NqJyUVC0gW/mLCo3WIEJcAf5vbHeVUoD0pCU5T+F
         hXbWs2MGef3i6z/74dRa3mmLA8myS3QF7AM8F/wEes/1bIPyBcYtXOybkZ57WHZOEGvx
         nGD1R1+r1L8TgN9YsFw5GKatJdmz13xDA/tO1N35QCiBsou+csEnZKCqPpBhraKzIA1m
         p/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SippBiPvnRnapzXhq7fOVJkKRsVVBzMZERi+BPHUIs4=;
        b=XpihKC2l2GkgPc4YlWmK28EafiD4RGkFxs9OdJQO/PiefEtrs56aU61Q/+wsp+XKlw
         ALMrdGCUZRfIoMuDmO0dANzidkNGGFR29VwCs23xo0VE9WVwfhhRRNGYqMbW8MQfpvtL
         x1bZnqowO942czZY50bCfFosm0iBEJWS3uohPvEME+vXgNF1v6wgbFji3kk/8LjDgyyk
         P78Aq7zZKRv2QjyNHOEDi70L+0r4it+MYXT3zisJILOq60YWwyQvSczUpLeVU5Bq641C
         JeiSck/5OdaSaiLL/H4ZOMjZR2LDwag8qOEvNMUokxlpzpRBzUD6R5YnP6nYbsJifwBk
         MiWA==
X-Gm-Message-State: AOAM530hi5KmH5g2Zrdi+5bjE4By/dc3AX7xATrCkwBsstX+EAUMdd/h
        0ORGRXYKlztXs8Qhx2mw+Y4=
X-Google-Smtp-Source: ABdhPJz929CIOM6Ow03Xr+astPusY0L5CX7z4IgaGOOHbPXSzlHZ8Fr6WalYqAMyfpLlLMX/Zyqeow==
X-Received: by 2002:aa7:8298:0:b029:19c:1564:7b0c with SMTP id s24-20020aa782980000b029019c15647b0cmr20643481pfm.6.1607442900401;
        Tue, 08 Dec 2020 07:55:00 -0800 (PST)
Received: from localhost.localdomain (1-171-4-151.dynamic-ip.hinet.net. [1.171.4.151])
        by smtp.gmail.com with ESMTPSA id a17sm6700725pgw.80.2020.12.08.07.54.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:54:59 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 2/4] backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight
Date:   Tue,  8 Dec 2020 23:54:44 +0800
Message-Id: <1607442886-13046-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
References: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 backlight.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
since v3
- Move inlcude/dt-bindings/leds/rt4831-backlight.h from patch 0004 to here.
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

