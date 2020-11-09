Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40FC2AB80E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729822AbgKIMSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbgKIMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:18:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96453C0613D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:18:29 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id g11so4640533pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 04:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWmlfMfRUXU44J3q+Sc5kmE5CqBvigtZaPIOQbZQHF8=;
        b=Xttw3JWftH5F6nYAMRHB94r+/xuVVekPxG5xY57CpspsotoypVnZ/McuG8ak6VZNEN
         drAUyJod/SbePFKvfNZKqyAOMs5WkVdvRMREtJR5iYm+NxBE8e8C6U43M9AqMvhbXXTx
         C3cMYPayqBg9ZCvhWjI3WpdC6n3rxLm7rAGHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWmlfMfRUXU44J3q+Sc5kmE5CqBvigtZaPIOQbZQHF8=;
        b=DtO6S4UfVCRNtWbVCL0EEo/wEM36GvseGTJwblfccX0Q8LbfatR9benRWBBGGZ6hvb
         0rNz0CUSSN9EqSGzs99zOReajm5GtwGgI8284dLQXYVoa5ObTdmS7iXtB4w/uo9Wrc6M
         lVUaTp6dMi6kN37hKVR+trXB6F1Ud6/+RiMCthYQXIRAT/eBKG4Xcsy9q2TdOl6MJ5op
         pmz+gmgFGKrB6GzKt+KawUWDeVYAgfKFtH1I4VseQ/I6RdtplLtGHdkfNp7ZKNYsnjZ8
         ZOyzNQNHJyrrqEJWgZhU/sRCos8R5kBZJX1SLXRnPNhTc4bUvY5V+zNVlHLW5267EDbz
         ol6Q==
X-Gm-Message-State: AOAM533tNOcrDKJ3MrXgJThW94hZRoBq7hEB6/DEIX18ShtC+Oc4cWkv
        0R3V1w+3cFVISMjad5bUMB9K3g==
X-Google-Smtp-Source: ABdhPJzTrCkoWqzth3LbUrGmAO6H7Cm1AYYsxKHAD1WHKBpHCwpPP1N6RkIDe+FfRnohjogyE36OfA==
X-Received: by 2002:a17:902:9347:b029:d5:d554:9922 with SMTP id g7-20020a1709029347b02900d5d5549922mr11990623plp.56.1604924309106;
        Mon, 09 Nov 2020 04:18:29 -0800 (PST)
Received: from shiro.work (p1268123-ipngn200803sizuokaden.shizuoka.ocn.ne.jp. [118.13.124.123])
        by smtp.googlemail.com with ESMTPSA id i123sm11425204pfc.13.2020.11.09.04.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 04:18:28 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org, linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        maz@kernel.org, w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v3 2/5] dt-bindings: gpio: Binding for MStar MSC313 GPIO controller
Date:   Mon,  9 Nov 2020 21:17:28 +0900
Message-Id: <20201109121731.1537580-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109121731.1537580-1-daniel@0x0f.com>
References: <20201109121731.1537580-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding description for the MStar/SigmaStar GPIO controller
found in the MSC313 and later ARMv7 SoCs.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 .../bindings/gpio/mstar,msc313-gpio.yaml      | 62 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml

diff --git a/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
new file mode 100644
index 000000000000..8c7cfe3a51b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
@@ -0,0 +1,62 @@
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
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+  - interrupt-controller
+  - "#interrupt-cells"
+
+additionalProperties: false
+
+examples:
+  - |
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
+      #interrupt-cells = <2>;
+      interrupt-controller;
+      interrupt-parent = <&intc_fiq>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index db9c008a0395..87ca71f55de3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2131,6 +2131,7 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://linux-chenxing.org/
 F:	Documentation/devicetree/bindings/arm/mstar/*
+F:	Documentation/devicetree/bindings/gpio/mstar,msc313-gpio.yaml
 F:	arch/arm/boot/dts/mstar-*
 F:	arch/arm/mach-mstar/
 F:	include/dt-bindings/gpio/msc313-gpio.h
-- 
2.29.2

