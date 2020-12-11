Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC92D71BA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391288AbgLKI00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:26:26 -0500
Received: from mout02.posteo.de ([185.67.36.66]:54291 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436895AbgLKIYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:24:49 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id D0BD12400FF
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 09:23:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607675030; bh=ELHJ+HjagMGq3J68GvyToGsJJtKkqWCZWW3r3lJihx0=;
        h=Date:From:To:Cc:Subject:From;
        b=acmTgQbPu5APoqoxe653lB026rpKbNjYpE2fMiQi3l/jnDRNNW7R69J/kWpI8Qgdr
         sHYIE8kX9ja1RpzsaXXlK1106omPfJ1fYTa5DTb6bAb0slA3Wy9ucO/VocajwGivoV
         2zRheOBT1CZoiDdSwmMdD/6CQMAR7o4ivFrvw6Uveii4/BftXV3wr96ri5KTmS8Btx
         rXECxwi92Z1R0arlMPJsv9HutyxzQrkH3ac2d3f7yVbv/IrVjXzJhzg53zxA8YkN2O
         tnkaTfSmmcUKj6MaGCfI6/QDCwpbNE/E4KJkjIHYG5XuC2b5lXG9F+0j8u8jkYSIN5
         RslYB41KnSUgg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CskMT5zJ3z9rxc;
        Fri, 11 Dec 2020 09:23:49 +0100 (CET)
Date:   Fri, 11 Dec 2020 09:23:48 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v4 1/2] dt-bindings: hwlock: add sun8i_hwspinlock
Message-ID: <8b0c0b80bfc2dbb9010bac00fe0c90493ad8db09.1607674518.git.wilken.gottwalt@posteo.net>
References: <cover.1607674518.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607674518.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use the sun8i_hwspinlock driver for sun8i
compatible SoCs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v4:
  - changed binding to sun8i-a33-hwpinlock
  - added changes suggested by Maxime Ripard

Changes in v3:
  - changed symbols from sunxi to sun8i

Changes in v2:
  - fixed memory ranges
---
 .../bindings/hwlock/sun8i-hwspinlock.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
new file mode 100644
index 000000000000..76963d8abd5f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/sun8i-hwspinlock.yaml
@@ -0,0 +1,56 @@
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
+description:
+  The hardware unit provides sempahores between the ARM cores and the embedded
+  OpenRisc core on the SoC.
+
+properties:
+  compatible:
+    const: allwinner,sun8i-a33-hwspinlock
+
+    reg:
+      maxItems: 1
+
+    clocks:
+      maxItems: 1
+
+    clock-names:
+      items:
+        - const: ahb
+
+    resets:
+      maxItems: 1
+
+    reset-names:
+      items:
+        - const: ahb
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
+  - |
+    hwspinlock@1c18000 {
+      compatible = "allwinner,sun8i-a33-hwspinlock";
+      reg = <0x01c18000 0x1000>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      clock-names = "ahb";
+      resets = <&ccu RST_BUS_SPINLOCK>;
+      reset-names = "ahb";
+    };
-- 
2.29.2

