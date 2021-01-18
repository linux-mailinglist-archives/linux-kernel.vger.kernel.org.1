Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5EB2F9993
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:56:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbhARFzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:55:01 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:38347 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732296AbhARFvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:51:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 24EA2137A;
        Mon, 18 Jan 2021 00:50:43 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=CaMcsfujlipTp
        oTOms4DDzue5HB3L8f3O43jGnIlzwA=; b=KdT1SYPSYslKuslrTwoOG7mB+o50M
        NvbnGHRxfOkyHjBC5gnEiYVnksYoY2N8arN0uoOChMUfV81DHjsqdFv+UM9HBFUp
        sgCyw5eXAvUU8+6oZbtzbYHwwp60hq9uJwciEcmnamyESyuzoUDF0CWOym+leHc7
        tpUvdHfs8VLreybr5et3YOe5SW2/WPFQknSObUPx+gkMuBgQCNmus4VnEysgSil7
        /hG43ZEV4lWcATAUXM2Zv5SiajEoOPy7BYfnikrEhfnsrhXzIaNFbLpaKui4zJlS
        L1ma8IGN7qMkzWe4X0NKATJLCDIu5b2rHjV8BIKPL43FRgYKaNBNL25Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=CaMcsfujlipTpoTOms4DDzue5HB3L8f3O43jGnIlzwA=; b=bVqKuqjc
        CrHZ3Dq0rxhBz4lGlC9wYq76S5Q73ed/6sNwVfCmvPnPyKRa6Si7YwPLpoev39EO
        ejDM+4NPxpzs9YrDoUtwqz9N1r9pW/BmFpuieG/WkyNLQz/VA77Z0pgrQkBhh2fs
        te4dl7bC+lnj6RXAypOKKQVrXCQO0r68ISn4SlAj/CbKy6WpduMAZHIpf6GRtDIm
        dnJBA/6TosNILCMm28RhsS/eE9AixmdyLTLyXBcKF7pRpM5HhveZg6P5FuPdjmFI
        nETzeoVC0cK0y2UhGyidAdTZmq9A9jxsKUdcucsIloZMiQ9Cz029k3f5IJKsv8or
        v1Njh9jYY3KXtA==
X-ME-Sender: <xms:siEFYHwniq1BW-Zlzq63gTKXc9cs6uxgn6G7PI5hJswhLlT2LmdeTA>
    <xme:siEFYPRTkjnzlHbwF4vWWZ1lqff68pjqgWkyh_5-0OMgwwxnflV0uQk-zopFOvPfW
    GVX9FPka0DR594EYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepleeuleegtedtgffgueffveekhfdutdetiefgvefhtdfftdejgfetgeel
    geegvddunecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucfkphepjedtrd
    dufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:siEFYBVPC-_vin7JccV4x3NTxFuFI0bdqa3sXyUwTo91AT9Op8G9aQ>
    <xmx:siEFYBj2HFN9ICB6qWZzBeYRpW-2nAJInVn4F30V0o6vmu2becZyFA>
    <xmx:siEFYJAc0lKwjCwtX-_vkOgKzTtZ1gP7gQJOVqWy99x77Z1lfv7tsA>
    <xmx:siEFYNvMO_Tga9Z9pXPlUHl_z9IxcrYfk9giOcugxuFdKfvg2eBO5LF_Qx4>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B34924005C;
        Mon, 18 Jan 2021 00:50:41 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
Date:   Sun, 17 Jan 2021 23:50:31 -0600
Message-Id: <20210118055040.21910-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC in the A31 and newer sun8i/sun50i SoCs has additional
functionality compared to the sun7i/sun9i NMI controller. Among other
things, it multiplexes access to up to 128 interrupts corresponding to
(and in parallel to) the first 128 GIC SPIs. This means the NMI is no
longer the lowest-numbered hwirq at this irqchip, since it is SPI 32 or
96 (depending on SoC). hwirq 0 now corresponds to SPI 0, usually UART0.

To allow access to all multiplexed IRQs, the R_INTC requires a new
binding where the interrupt number matches the GIC interrupt number.
Otherwise, interrupts with hwirq numbers below the NMI would not be
representable in the device tree.

For simplicity, copy the three-cell GIC binding; this disambiguates
interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
binding (SPI 0) by the number of cells.

Because the H6 R_INTC has a different mapping from multiplexed IRQs to
top-level register bits, it is no longer compatible with the A31 R_INTC.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../allwinner,sun6i-a31-r-intc.yaml           | 66 +++++++++++++++++++
 .../allwinner,sun7i-a20-sc-nmi.yaml           | 10 ---
 2 files changed, 66 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
new file mode 100644
index 000000000000..50e607e607c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner A31 NMI/Wakeup Interrupt Controller Device Tree Bindings
+
+maintainers:
+  - Chen-Yu Tsai <wens@csie.org>
+  - Maxime Ripard <mripard@kernel.org>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+properties:
+  "#interrupt-cells":
+    const: 3
+    description:
+      The first cell is GIC_SPI (0), the second cell is the IRQ number, and
+      the third cell is the trigger type as defined in interrupt.txt in this
+      directory.
+
+  compatible:
+    oneOf:
+      - const: allwinner,sun6i-a31-r-intc
+      - items:
+          - enum:
+              - allwinner,sun8i-a83t-r-intc
+              - allwinner,sun50i-a64-r-intc
+          - const: allwinner,sun6i-a31-r-intc
+      - const: allwinner,sun50i-h6-r-intc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description:
+      The GIC interrupt labeled as "External NMI".
+
+  interrupt-controller: true
+
+required:
+  - "#interrupt-cells"
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-controller
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    r_intc: interrupt-controller@1f00c00 {
+            compatible = "allwinner,sun50i-a64-r-intc",
+                         "allwinner,sun6i-a31-r-intc";
+            interrupt-controller;
+            #interrupt-cells = <3>;
+            reg = <0x01f00c00 0x400>;
+            interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
index 4fd1e2780026..7fc9ad5ef38c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -22,26 +22,16 @@ properties:
 
   compatible:
     oneOf:
-      - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun6i-a31-sc-nmi
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
-      - items:
-          - const: allwinner,sun8i-a83t-r-intc
-          - const: allwinner,sun6i-a31-r-intc
       - items:
           - const: allwinner,sun8i-v3s-nmi
           - const: allwinner,sun9i-a80-nmi
       - const: allwinner,sun9i-a80-nmi
-      - items:
-          - const: allwinner,sun50i-a64-r-intc
-          - const: allwinner,sun6i-a31-r-intc
       - items:
           - const: allwinner,sun50i-a100-nmi
           - const: allwinner,sun9i-a80-nmi
-      - items:
-          - const: allwinner,sun50i-h6-r-intc
-          - const: allwinner,sun6i-a31-r-intc
 
   reg:
     maxItems: 1
-- 
2.26.2

