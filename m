Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C6E2D7B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732642AbgLKQev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbgLKQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:34:41 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D37BC061794;
        Fri, 11 Dec 2020 08:34:01 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id r4so4835281pls.11;
        Fri, 11 Dec 2020 08:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6ooUHIBWtAm3UIq07HSxYs4FQkH1MMECJPgWu1xGQ8=;
        b=eXheUVTgbGUGETs9OXCgV6XxrcCtnY+eEa2Giq+CK720JdGxLctzEE11Vr9xKXHWO0
         qO8x3Ek3wgC7LQdPTZhTS7EXgVjVXyfSpGjUTsrn3cCo5tD9KcEHlBzE67U45lE49wrn
         TiK01Fa2aOyCBwW4e/T6RPh2DW1P7qZJByUI0+c5zYrmmcbEFK9gSiXSrk60F8+htRZ5
         65ikaBlANwvVCpNI0kfzF7cZ9q5fvAuP5gvaxRmbvEb9RAgdeIqbnMZi+17+oJA8Z3Ds
         +vkNJ1OGK/ra4nbIhEIjUCCqk77Czz+6yMKaQb/22oWD2K+d5qqFxuQ8IaYGe6X45qcM
         l+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6ooUHIBWtAm3UIq07HSxYs4FQkH1MMECJPgWu1xGQ8=;
        b=ODCrm7UbuYtt6ZiFC68VxR65hvsw8bM0uQJlfNIpY5kTtT7YPHlMBVtMqcq+yC9e/4
         AtEsXPXKBgpuvHyXFVG24wQGEYKhrJby2QmbParQk4I+q3RSjkJ50M+yKxg2DSIFd2Qu
         cKnzS86bgZSGgLAZcxJkxJzKeAaF8/aRM41mYtQCm2f6Eojb+IFxn6IWvoFpnLO2Dw5k
         XSw5EBtjtVXuCd5/rDOf4zdAW5bpplmIe6dbd7IJfikza8vR3x8t52p6eViASrBHQl7I
         6Zm8hnEJdc17q3QEkep97q+RuQlhbgU1DoStFKtZzL3iIW3WhAeKOp3BoL8SOM2HJcJE
         kD+A==
X-Gm-Message-State: AOAM531gsm4Wi3lzszOgQITQoeHcI1JEbhdh1DCh+NZJhg6TtPrpDXbY
        b+FSnQg3iQyrnuevZQH9GDg=
X-Google-Smtp-Source: ABdhPJzdbBpsvkbYttF4oxUb6DX657RdZ7NwqJyhGKT6vhVK5oGp1Y7fO25EMVVIHnM2qujfn8+lGA==
X-Received: by 2002:a17:902:fe02:b029:db:c7fd:3c2c with SMTP id g2-20020a170902fe02b02900dbc7fd3c2cmr11740513plj.31.1607704440790;
        Fri, 11 Dec 2020 08:34:00 -0800 (PST)
Received: from localhost.localdomain (1-171-10-206.dynamic-ip.hinet.net. [1.171.10.206])
        by smtp.gmail.com with ESMTPSA id gm18sm7987947pjb.55.2020.12.11.08.33.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 08:34:00 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] mfd: rt4831: Adds DT binding document for Richtek RT4831 MFD core
Date:   Sat, 12 Dec 2020 00:33:44 +0800
Message-Id: <1607704424-16223-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
References: <1607704424-16223-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 MFD core.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
This patch depends on
 "backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight".

since v4
- remove v3 regulator binding patch, directly merge it into mfd binding.

since v3
- Move include/dt-bindings/leds/rt4831-backlight.h to patch 0002.
- Add dual license tag in mfd binding document.

since v2
- Add regulator-allow-bypass flag in DSVLCM.
---
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 108 +++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
new file mode 100644
index 00000000..9de7c4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
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
+  DSVLCM is a boost regulator in IC internal as DSVP and DSVN input power.
+  Its voltage should be configured above 0.15V to 0.2V gap larger than the
+  voltage needed for DSVP and DSVN. Too much voltage gap could improve the
+  voltage drop from the heavy loading scenario. But it also make the power
+  efficiency worse. It's a trade-off.
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
+    type: object
+
+    patternProperties:
+      "^DSV(LCM|P|N)$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+
+    required:
+      - DSVLCM
+      - DSVP
+      - DSVN
+
+    additionalProperties: false
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
-- 
2.7.4

