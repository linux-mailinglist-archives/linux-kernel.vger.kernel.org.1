Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C7028A50C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 04:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgJKCss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 22:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730426AbgJKCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 22:48:48 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A020FC0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 19:48:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y20so6551357pll.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 19:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F6fjmcOmJzSVz0Oy0Rq9zEBYtq/tY9BpvhD8w5xQD/A=;
        b=Ay8X1xlcQiaQIvb2Fs3y51q3hYVpv86xWv4PwucQ5ugGIOJruN/Xv59WZRq2YS9hTU
         dmCEQqu9g4Q/0Q5WtF80kyaVUL1Ig/xwhkKmFGl1u8c4SkCDO4Qi9kNoL8dIJed6L23K
         CwuEMeOHzBxKKp3Mdx/pfigyMeKrOdqiP9/iQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F6fjmcOmJzSVz0Oy0Rq9zEBYtq/tY9BpvhD8w5xQD/A=;
        b=ceWJN+ORg7CQety0XdSIe19BzRUzAKx1AgbLiGKJJEV8uCBA1kJoKDMYmqzs/3l+8c
         kO0IonoPuWnN3t2KvqYrzOKTCpkXld/nxV3RKlgDPiNk9LXmipg4vicwhNKS84eEg7C+
         I7SErdTRJZ4SLb+mx9t2a5Uy6T4oZRwzEf1GmoQ5RU5ZKaNYHgFxgQdLddZv2Sj+eaNJ
         11WNtu7SXHj4dk6s6muuhjJdOD+NcdISI7PAGfcUvTEeBy7LJyYDWbocM/s/pw94KZJ+
         OX9eBWOwHb+7CJzZCXy7s5z1Q7qVMol6U96FC64rTwAIxOnnfSvbIl/RUGzRpP0xZdCv
         CvZw==
X-Gm-Message-State: AOAM530cvmIH4ZIU0I6HL8OpmvwPtNi5f+jrCEvfhbD1Wsqj4316cyGb
        t33Rcj64EjAE3i7rzaqZ9grgQQ==
X-Google-Smtp-Source: ABdhPJxSTPgCoHjzLRWnqWgfhcS2XNc8CkN2wfKQlzuyb4o0tfQBhP2nQcrOR/t2zlOqFm8+tWhaKg==
X-Received: by 2002:a17:902:b402:b029:d2:686a:4f43 with SMTP id x2-20020a170902b402b02900d2686a4f43mr18210883plr.34.1602384525677;
        Sat, 10 Oct 2020 19:48:45 -0700 (PDT)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id z25sm14832836pgl.6.2020.10.10.19.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2020 19:48:45 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 1/5] dt-bindings: gpio: Binding for MStar MSC313 GPIO controller
Date:   Sun, 11 Oct 2020 11:48:27 +0900
Message-Id: <20201011024831.3868571-2-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201011024831.3868571-1-daniel@0x0f.com>
References: <20201011024831.3868571-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding description for the MStar/SigmaStar GPIO controller
found in the MSC313 and later ARMv7 SoCs.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/gpio/mstar,msc313-gpio.yaml      | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
new file mode 100644
index 000000000000..07ef463273d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/mstar,msc313-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MStar/SigmaStar GPIO controller
+
+maintainers:
+  - Daniel Palmer <daniel@thingy.jp>
+
+properties:
+  $nodename:
+    pattern: "^gpio@[0-9a-f]+$"
+
+  compatible:
+    const: mstar,msc313-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
+  gpio-ranges: true
+
+  gpio-ranges-group-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  interrupts: true
+
+  interrupt-names:
+    description: |
+      The interrupt name should match the pin that the interrupt
+      is connected to.
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/msc313-gpio.h>
+
+    gpio: gpio@207800 {
+      compatible = "mstar,msc313e-gpio";
+      #gpio-cells = <2>;
+      reg = <0x207800 0x200>;
+      gpio-controller;
+      gpio-ranges = <&pinctrl 0 36 22>,
+                    <&pinctrl 22 63 4>,
+                    <&pinctrl 26 68 6>;
+      interrupt-parent = <&intc_fiq>;
+      interrupt-names = MSC313_PINNAME_SPI0_CZ,
+                        MSC313_PINNAME_SPI0_CK,
+                        MSC313_PINNAME_SPI0_DI,
+                        MSC313_PINNAME_SPI0_DO;
+      interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+      status = "okay";
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 75b04ba10f21..4594b70f2e3a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2155,6 +2155,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar/*
+F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
 
-- 
2.27.0

