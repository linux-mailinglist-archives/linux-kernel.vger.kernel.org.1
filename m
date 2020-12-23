Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 106852E1BF3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 12:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgLWLfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 06:35:37 -0500
Received: from mout02.posteo.de ([185.67.36.66]:44011 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbgLWLfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 06:35:37 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 492792400FB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 12:34:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1608723280; bh=vPEZFjnAwEL31lLaOjrnVmImH4lB2/Ft8e/cvHRPkgU=;
        h=Date:From:To:Cc:Subject:From;
        b=EDKn08M6zofvcEXXWL3b/rnb6tyb+UuZn40EKnouf8qIEKM5Bxsizi840xuQkw8Vr
         pRtEWDIs3zxjpyiFrKxm0RB50Jh5RpRZaQ+k0YfwGcSnIon6Ln0J3xmB1ciVjnXoj2
         ZjircccJVQi/rTcRhFGUhZsFdQctwVXqjC5LV0d07jtqXTqgvINr5Vab+jMW40ZPZR
         6UdBxgWwhUwYlUiWyainN4vmWj1cdEgG4eTNYxVYMBJSHy49i2Wc94hliaM308PfKn
         qVp5U8XnJ0CEN/xejtJcba+QpiGNhgQVXlY66knM/PxnBDcOMXyZx9Ka/4JOgMUbJQ
         V/ZLhIu8dvQ6Q==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4D1B263Kr1z6tm9;
        Wed, 23 Dec 2020 12:34:38 +0100 (CET)
Date:   Wed, 23 Dec 2020 12:34:37 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: [PATCH v5 1/2] dt-bindings: hwlock: add sun6i_hwspinlock
Message-ID: <ef9657337a9a033bcbac2bc14805398b907835d6.1608721968.git.wilken.gottwalt@posteo.net>
References: <cover.1608721968.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1608721968.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds documentation on how to use the sun6i_hwspinlock driver for sun6i
compatible SoCs.

Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
---
Changes in v5:
  - changed binding to earliest known supported SoC sun6i-a31
  - dropped unnecessary entries

Changes in v4:
  - changed binding to sun8i-a33-hwpinlock
  - added changes suggested by Maxime Ripard

Changes in v3:
  - changed symbols from sunxi to sun8i

Changes in v2:
  - fixed memory ranges
---
 .../bindings/hwlock/sun6i-a31-hwspinlock.yaml | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
new file mode 100644
index 000000000000..481c5c995ad7
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/sun6i-a31-hwspinlock.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/sun6i-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SUN6I hardware spinlock driver for Allwinner sun6i compatible SoCs
+
+maintainers:
+  - Wilken Gottwalt <wilken.gottwalt@posteo.net>
+
+description:
+  The hardware unit provides semaphores between the ARM cores and the embedded
+  companion core on the SoC.
+
+properties:
+  compatible:
+    const: allwinner,sun6i-a31-hwspinlock
+
+    reg:
+      maxItems: 1
+
+    clocks:
+      maxItems: 1
+
+    resets:
+      maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    hwspinlock@1c18000 {
+      compatible = "allwinner,sun6i-a31-hwspinlock";
+      reg = <0x01c18000 0x1000>;
+      clocks = <&ccu CLK_BUS_SPINLOCK>;
+      resets = <&ccu RST_BUS_SPINLOCK>;
+    };
-- 
2.29.2

