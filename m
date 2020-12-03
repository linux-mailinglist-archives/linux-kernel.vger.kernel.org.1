Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACFB2CDACF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731250AbgLCQHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgLCQHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:07:32 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D94C061A53;
        Thu,  3 Dec 2020 08:06:46 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w6so1591384pfu.1;
        Thu, 03 Dec 2020 08:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UE642If1a4zIekYpvyIiLVRXQYPzDscy3Y6yH2gA0sM=;
        b=Xb/zTMHX46/XwB2D15m9admr6/tYWE12DDqSpsLR5rsTXO4TPwfO8eKLILOSk3WZCn
         kcZrN0tTwzrAtaubkQjASS44N8Z0/ilnqWfqyFNkSv8gRsY5e7desZgGaV5/SpQPKgRM
         JWNkw7FGoDTWMbGhH25eaPFNBGiJ+qw2BVociBnwAQfnp8e4QJ1uLHDMrGMJcwHCpXHo
         8lrjZ7Gk9cqgme8+VJ41F+QrKD9RUa0Iqtpxfg2swzfaSIeiYP8+cJbrTzUTDDjPCDvk
         l6JjM6RwxBTzWdwmCjVq6QuweEG4BeLB31saggiLbCVTn0eGMhke2nQO4LzxYUVb9aYV
         8JAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UE642If1a4zIekYpvyIiLVRXQYPzDscy3Y6yH2gA0sM=;
        b=TG0hd6ezdMtsgrfhGACDsG1kWFQdUmsVl3/NIufhXA/QMd/A06QkqlRs4XQB5QHlRn
         dsW382XzqHYcwFuG4KJQYGiNyybNxCVWYmEp/SMvPrtRwzsLYQRpWUMjbwaM/ZW7WV3P
         AIkn30psNAqQYiRV3of3l72ceYkouJPjTz0HV1DoCxU7vz/mi5pelj01gkxb1MCeckmW
         SpuGxZJn0iyXmvkqTKqsUiqDri9g2bdgiApMWF8wL2TOxwVAtRwbzdTrrd73Nk9akps4
         eaPgFd7N8NXtxUNkHLqDTLE2/qnKwERV87eoHtgQH7ZeH/t3dvH9xYnIapLxgUWYMk9U
         FLnQ==
X-Gm-Message-State: AOAM531W+J8cd032Q8kQq/ZxgfC+AEUvER5+9PRAJbbsCJGDLPiN9TDe
        VHiEtqUDCZthUKGpuGCAH7M=
X-Google-Smtp-Source: ABdhPJx8p8cgzJQjOlw/dPHx3m2Cz9bpkOnXcuNcSGUV+R4UyZeYxC0bI+sZBnMixnIhoKg6l1Rocg==
X-Received: by 2002:a62:7b84:0:b029:19c:7146:4bbb with SMTP id w126-20020a627b840000b029019c71464bbbmr3921680pfc.52.1607011605786;
        Thu, 03 Dec 2020 08:06:45 -0800 (PST)
Received: from localhost.localdomain (1-171-1-217.dynamic-ip.hinet.net. [1.171.1.217])
        by smtp.gmail.com with ESMTPSA id h6sm92503pgc.15.2020.12.03.08.06.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 08:06:45 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     lee.jones@linaro.org, robh+dt@kernel.org
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/4] backlight: rt4831: Adds DT binding document for Richtek RT4831 backlight
Date:   Fri,  4 Dec 2020 00:06:33 +0800
Message-Id: <1607011595-13603-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
References: <1607011595-13603-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Adds DT binding document for Richtek RT4831 backlight.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../leds/backlight/richtek,rt4831-backlight.yaml   | 86 ++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
new file mode 100644
index 00000000..df1439a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: GPL-2.0
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
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt4831@11 {
+        compatible = "richtek,rt4831";
+        reg = <0x11>;
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

