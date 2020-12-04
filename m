Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2252CF0D1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 16:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbgLDPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 10:35:33 -0500
Received: from mout01.posteo.de ([185.67.36.65]:39911 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgLDPfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:35:32 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id D2C4A16006A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:34:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1607096074; bh=L8jNDfJQzcI5dsEKtpEFobp7DLQnVXOH5AW8Z9dclhI=;
        h=Date:From:To:Cc:Subject:From;
        b=FAQd7z3Oh3N+0ZEY2hIOI1uiiRRCO2gtpkX8IIF4vYxz3gUgDUIJjmnZs5pSGTo0/
         wsP0/mJFHI++wFeQ2gEtoSUG1XOVQHiZwA846dZ9yBoHhipj1tw5+duXQYQDCInN2M
         kqJ4T1rE7Kwl+wboXdldsbdSYp+2QyDroIIgyLJQNb4RKUPf99GeUHBh+fByNHYip1
         xaD2duRiP8g8/x3mCrV11/ddaExc5qPXSSH8ATbHEyZ6NJvkKMJVwlJ5cpd1N9V9w5
         GSjl3yHFmiQBoO8Riov67GQ8J+KKsJSodiR6be+uFhu5FI5rrvp3tnQG70RHiKe49c
         MtahpRd2jNZEg==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CncFh2jyFz6tmB;
        Fri,  4 Dec 2020 16:34:32 +0100 (CET)
Date:   Fri, 4 Dec 2020 16:34:30 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v2 1/2] dt-bindings: hwlock: sunxi: add sunxi_hwspinlock
 documentation
Message-ID: <78bf08d660535373ada837d3fff0e61183251def.1607094989.git.wilken.gottwalt@posteo.net>
References: <cover.1607094989.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1607094989.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use the sunxi_hwspinlock driver for the
sun8i and sun50i based SoCs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v2:
  - fixed memory ranges
---
 .../bindings/hwlock/sunxi-hwspinlock.yaml     | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
new file mode 100644
index 000000000000..32d7e897ead6
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/sunxi-hwspinlock.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/sunxi-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SUNXI hardware spinlock for Allwinner sun8i and sun50i based SoCs
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
+      compatible = "allwinner,sun50i-hwspinlock";
+      reg = <0x03004000 0x1000>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      clock-names = "ahb";
+      resets = <&ccu RST_BUS_SPINLOCK>;
+      reset-names = "ahb";
+    };
-- 
2.29.2

