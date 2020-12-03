Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA602CDAD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436750AbgLCQHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730709AbgLCQHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:07:38 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85371C061A55;
        Thu,  3 Dec 2020 08:06:51 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id e5so1347837pjt.0;
        Thu, 03 Dec 2020 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bNsIzWavgXRSs6v26PiBrp0qwluByJmuApRMLbqgomw=;
        b=QcpbihviHQbQFNZweIJMQhAdX/L6ebjyuL5oYQigX0pWwnNfY4NZz2ibGR/mKz+3Xv
         UDBCK8tY2o7GW6SNZDkfbKW8iL12DBuUTyzU1lliqN3CIO7zBwJp6LPHs7UU/wvHGLn+
         x6Qk2uNadhwB8ipm1drrZijneiI2PtVvL84WrXtmmQFghVPwbnebf4M0RK64m+C3MkCJ
         VaXrWNdlGMhnIPavMKKlQBLqQ4hzLxwHHpCstTZIUXGSRK2dHAHhYwLc2ipxX3RiTcaL
         ugU8DFuye5FlZEJrjvCp0Ek4I/3TvKsUjgGrCcSx3Xrs2lKq95MMmG1cK5aUo+TkmeM6
         vb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bNsIzWavgXRSs6v26PiBrp0qwluByJmuApRMLbqgomw=;
        b=fdv0H7icb9r2B66HW1gupCesk22lZsf5Ws0N2LkRVnlHWRoQ8XNR+0NEWXwrfliO/6
         d4EHwTxFIUG3B5U+lN5mZyJUK7J/cBDXO9XuW/ja9rBiHFhRQPq3Lri9Bkte38T3NNHk
         +wMttcLUqYBIzFL3ndZsnSyPv/k1H2MnskQJjSZ8RuZKTxWozbAuCqqJIZWrIDl22fMc
         Mlj8PcMB8X1vpGkqpcg2dsuUcUuoyh12d5xrX5O4Dm79INiGNAAyq5RAdppbm3XYKYCa
         csAWkUmF78/Ke+12EYvNO71SOx/d+UYdy9DkRxPKB/W6va8k83mXYvnSXp3OgHtOhMef
         ZMoQ==
X-Gm-Message-State: AOAM530iMLvrt3CrHw09xDnU+MpV+6XNOrjp6QMDgtwx6KHyVeN1JkvB
        8svIaWuWQW2WGPiIku/+ZYjIWzMWI0Novw==
X-Google-Smtp-Source: ABdhPJxMw2MKzEFEDu5sc4TvOl8SpD0o04uDwu13/80SkU8soYOLunwP+jjWRs49uszKSp58bOIPkw==
X-Received: by 2002:a17:90a:5d0d:: with SMTP id s13mr3697503pji.230.1607011610990;
        Thu, 03 Dec 2020 08:06:50 -0800 (PST)
Received: from localhost.localdomain (1-171-1-217.dynamic-ip.hinet.net. [1.171.1.217])
        by smtp.gmail.com with ESMTPSA id h6sm92503pgc.15.2020.12.03.08.06.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:06:50 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 4/4] mfd: rt4831: Adds DT binding document for Richtek RT4831 MFD core
Date:   Fri,  4 Dec 2020 00:06:35 +0800
Message-Id: <1607011595-13603-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 MFD core.

This patch depends on

"backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight".
"regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator".

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
Changes since v2
- Add "patch depends on" in commit description.
- Adds regulator-allow-bypass flag in DSVLCM.
---
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++++++++++
 include/dt-bindings/leds/rt4831-backlight.h        | 23 ++++++
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
 create mode 100644 include/dt-bindings/leds/rt4831-backlight.h

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
new file mode 100644
index 00000000..c6ca953
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
@@ -0,0 +1,90 @@
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
+  RT4831 is a multifunctional device that can provide power to the LCD display
+  and LCD backlight.
+
+  For Display Bias Voltage DSVP and DSVN, the output range is about 4V to 6.5V.
+  It's sufficient to meet the current LCD power requirement.
+
+  For the LCD backlight, it can provide four channel WLED driving capability.
+  Each channel driving current is up to 30mA
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
+            regulator-allow-bypass;
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

