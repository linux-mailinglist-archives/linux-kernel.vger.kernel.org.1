Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470F52B7AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 11:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgKRKCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 05:02:05 -0500
Received: from mout02.posteo.de ([185.67.36.66]:39795 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725613AbgKRKCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:02:04 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 0CD402400FF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 11:02:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1605693722; bh=Gc5hwPy/W3om8srKNMHNXGCu4OZrigUVEsxq9YP1Vow=;
        h=Date:From:To:Cc:Subject:From;
        b=hpv1VGjPGfIKN8RcjIEQtpwp972uoSQagnQx2A+WsuS1eta/B5M5NkMu1XESAheIA
         jC9dVIWST4tHRMKflekaOPqoc8updDRUS8qEXNsli8WS+4kjG+0EKs869xtEyByKp+
         cZ7YobEugvcL1gp58rQCnVokjIO2VpAI6+J5bKeicPLzqKNhRDH0hNbTUPheT0jPia
         lPl00SbTNHelgXGT9B0Px2tRLPlVfr2Y+11ZujQJHjDPb1x26aZNV/pqHlfhahBGOA
         tgbkcJkiDNjkOXPIXqy/IvtRxl4VpOtgubZFelNqKFXb8UeQhT7dwwlFyCgjZwmeOQ
         KaLILJYaVP84g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CbddN3hB8z9rxH;
        Wed, 18 Nov 2020 11:02:00 +0100 (CET)
Date:   Wed, 18 Nov 2020 11:01:59 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH 1/2] dt-bindings: hwlock: sunxi: add sunxi_hwspinlock
 documentation
Message-ID: <57185bb30aa1932976e2276d4d287db7cf0304a0.1605693132.git.wilken.gottwalt@posteo.net>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605693132.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use/enable the sunxi_hwspinlock driver.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
 .../bindings/hwlock/sunxi-hwspinlock.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
new file mode 100644
index 000000000000..773eaa6b33ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/sunxi-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SUNXI hardware spinlock for Allwinner based SoCs
+
+maintainers:
+  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun8i-hwspinlock
+      - allwinner,sun50i-hwspinlock
+
+    reg:          # 0x01C18000 (H2+, H3, H5), 0x03004000 (H6), length 0x400 (max 256 * 32bit)
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
+      reg = <0x01c18000 0x400>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      clock-names = "ahb";
+      resets = <&ccu RST_BUS_SPINLOCK>;
+      reset-names = "ahb";
+    };
+
+    /* H6 based OrangePi 3 */
+    hwspinlock: hwspinlock@3004000 {
+      compatible = "allwinner,sun50i-hwspinlock";
+      reg = <0x03004000 0x400>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      clock-names = "ahb";
+      resets = <&ccu RST_BUS_SPINLOCK>;
+      reset-names = "ahb";
+    };
-- 
2.29.2

