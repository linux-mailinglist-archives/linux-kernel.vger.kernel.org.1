Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B302D158A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgLGQGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:06:03 -0500
Received: from mout01.posteo.de ([185.67.36.65]:45466 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgLGQGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:06:03 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 0EB2316006A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 17:05:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607357106; bh=sXuDpgTqvpIrNsYJc8GEAZuwSgbofvKWpuhl1p1Jaes=;
        h=Date:From:To:Cc:Subject:From;
        b=StW5RTD+SkVzmwMwMCNWfWHuD3srSyBTDUEgDQPSO/90eo0cHWGWvDyRCDLeoYlJy
         XK01qRBXorz7AZUOz8nPAgfvD+lQ0qzd6omFiofrRG7Of23VWOJuSc6jpkoW6aDwgO
         93NVAh9vK+u+uDBX7tPk+lU4KdKdEbees5KM8aSYlVf0v+gGlcDzcM4nOba/Aosz4x
         UUFJiCST8oAUHjCuF7lJxC6tewzLQl5tY2ekzx3zfBu6xqCda956tY6pcpTYfeYiVX
         XEEbp4vuh4vXoreZMWdT/ufWzRwmWelcFSunsXj/alzynTMLEPNeKe2ffxHMsXULZO
         5V598BewoArnw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CqSnX58RMz9rxX;
        Mon,  7 Dec 2020 17:05:04 +0100 (CET)
Date:   Mon, 7 Dec 2020 17:05:03 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v3 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
 documentation
Message-ID: <ac2c2b279be52876d66c91826a1ccebd08fe4810.1607353274.git.wilken.gottwalt@posteo.net>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607353274.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
compatible SoCs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 .../bindings/hwlock/sun8i-hwspinlock.yaml     | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
new file mode 100644
index 000000000000..2954ee0b36a7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/sun8i-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SUN8I hardware spinlock driver for Allwinner sun8i compatible SoCs
+
+maintainers:
+  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun8i-hwspinlock
+
+    reg:          # 0x01C18000 (H2+, H3, H5), 0x03004000 (H6), length 0x1000
+      maxItems: 1
+
+    clocks:       # phandle to the reference clock
+      maxItems: 1
+
+    clock-names:  # name of the bus ("ahb")
+      maxItems: 1
+
+    resets:       # phandle to the reset control
+      maxItems: 1
+
+    reset-names:  # name of the bus ("ahb")
+      maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+
+additionalProperties: false
+
+examples:
+
+  - |
+    /* H2+ based OrangePi Zero */
+    hwspinlock: hwspinlock@1C18000 {
+      compatible = "allwinner,sun8i-hwspinlock";
+      reg = <0x01c18000 0x1000>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      clock-names = "ahb";
+      resets = <&ccu RST_BUS_SPINLOCK>;
+      reset-names = "ahb";
+    };
+
+    /* H6 based OrangePi 3 */
+    hwspinlock: hwspinlock@3004000 {
+      compatible = "allwinner,sun8i-hwspinlock";
+      reg = <0x03004000 0x1000>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      clock-names = "ahb";
+      resets = <&ccu RST_BUS_SPINLOCK>;
+      reset-names = "ahb";
+    };
-- 
2.29.2

