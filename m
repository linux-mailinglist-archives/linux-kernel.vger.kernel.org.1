Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0E2D2ECA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgLHPzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgLHPzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:55:46 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA34C061794;
        Tue,  8 Dec 2020 07:55:06 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id w4so12498470pgg.13;
        Tue, 08 Dec 2020 07:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v4mKs5tFyRcSvuMMjNgZiEEAHEkdSYJjuCntwnlpFXk=;
        b=ejPfFD8ipXJBShbHw4spY9uezm7jdpfDf3fEEhYRrS90wCx1STmlMH5q+ckv6Xd1h7
         kwOt6Ik2YFoyqkVQFFa/E8bklf9XVob1wRpwcOOVS7ZkUkgQPQcKnRLq9zzFbYZ0j9BS
         JRqnwEtGv8jSyy719lj/LEagEwGqc8cvdB25zKbo38dfqyl2qV4GC8iQv4M72vIb3WZJ
         vpm2zFt080PNjJUIIdvwhKcFrh254JUJzozlfTo+moQXbBdXFGPSRo9P5xYFfS6RSr3y
         warXfWvl276NvwWlpvmIBZpTyObvrCSGnsqgGHAvgErK2uNSn0JLNiyLes3cdPfOqMLx
         /B4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v4mKs5tFyRcSvuMMjNgZiEEAHEkdSYJjuCntwnlpFXk=;
        b=ruPxgbn20rDMdvB4Vnu6nTnyxNfyorylpLHhF6ki327IlvaIuR0sXE+QbtyPyanUc6
         HPTwAExA69syGdgvpNgZ4gCrYWExnVRb4VjXvhjv8mUnbaecvoYfmfUzp2UmzM2+j8z7
         WIFq4cYFtxQMHXCErDB9OoUKQWHVtuco2dU+tm20G5stNraPjqcwC/wBDnrR7bvJS7yn
         tBenFZ9HnYAT8Hmz0K4fyzMftCijzulUO8FEXZUoAmXqyhg6RfNVaoMPCYpEqTWzJ8RW
         DCKslAExZtc6nbY+E7ZkDMC5ucgk97jU/pAjDX7yiwhlqIlTIjt4m9sb0BSxiC3cxdMb
         sELw==
X-Gm-Message-State: AOAM530gXzughfMYZ5zHV5xsVJIjtsAEGwAsUdaNah9JFh/t1+q5/sFw
        Ff8lyBT5kZenPrz7ctCUd6c=
X-Google-Smtp-Source: ABdhPJyJzvS5Z7MyKEuSLYEhire5zQP+BWhdeDklf1FUI7jlZqX1mJkX87EAZItP5nBU0W0B7SYNmQ==
X-Received: by 2002:a17:90a:510e:: with SMTP id t14mr4908437pjh.159.1607442905547;
        Tue, 08 Dec 2020 07:55:05 -0800 (PST)
Received: from localhost.localdomain (1-171-4-151.dynamic-ip.hinet.net. [1.171.4.151])
        by smtp.gmail.com with ESMTPSA id a17sm6700725pgw.80.2020.12.08.07.55.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 07:55:04 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 4/4] mfd: rt4831: Adds DT binding document for Richtek RT4831 MFD core
Date:   Tue,  8 Dec 2020 23:54:46 +0800
Message-Id: <1607442886-13046-4-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
References: <1607442886-13046-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 MFD core.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
This patch depends on
 "backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight".
 "regulator: rt4831: Adds DT binding document for Richtek RT4831 DSV regulator".

since v3
- Move include/dt-bindings/leds/rt4831-backlight.h to patch 0002.
- Add dual license tag in mfd binding document.

since v2
- Add regulator-allow-bypass flag in DSVLCM.
---
 .../devicetree/bindings/mfd/richtek,rt4831.yaml    | 90 ++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml

diff --git a/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
new file mode 100644
index 00000000..4762eb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/richtek,rt4831.yaml
@@ -0,0 +1,90 @@
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
-- 
2.7.4

