Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E039A2F281F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390167AbhALGAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:00:53 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56203 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726915AbhALGAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:00:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C3108580556;
        Tue, 12 Jan 2021 00:59:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=DVPo2YCdslWyJ
        ekyWqXOR0cevZq+VQKwxC23KdYWmf4=; b=KF+ahaJL49/nQLsXMmUvygQCh7pAt
        dK2MOMtnZA+iOC22/tNnwmTyMN0fa4MThiEVKXCw4X6PnfxSyWU+/aKDC0/QS8Wk
        PYMR4+yOQYj0a+CGpsX52vUcmLshPF4Enk/0zdgwH5tF7V+gDxdLAkQ4WqjM6zMI
        3z7B6+/gsE5MwceZLDMcPFwtwghgAEeeq9Dz0CzvXD8BCqJlR6Ec/gWjtSChXlmW
        ebCKc/hTHqDQw/YRxENgvRavHeceYiefBFWaL+YPwkSB0QqJl26YurVovcr4USXh
        CL9VjkgHa2ajGSLUnvklqNiPOB8w1sZTY9sok3TaRlhfRrBk2OwhYaB5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=DVPo2YCdslWyJekyWqXOR0cevZq+VQKwxC23KdYWmf4=; b=SzhkGXpY
        G4R7JVRVVFGhF7427PLMvM9XFfhWQEavF/9yiDGeTngUdXajvyKYMsRIuwmGxezY
        7GriKIdJYkXm8e7ZSpLyY+BBWVgsTQRv8UNCYNoEKKst9bgLJHkA3y9Tb+DlrRKB
        NzK0bpIIO1WmleZOp/AW7N8gYYLDhyoiigRV+rRc1/F2b87kKG+qc+zYr7YSs88i
        DBtfKyUdlTHCmkBauIN0Ygs8d+O4uq7VtFTGFB74WhHEJsHCvoTMrxsNKrPnyWtb
        iCCgFo1IET8mtUrR8m9u2SBnqebOezPzfYtAneYQ3BQlexXJyw2mvsu8p7SGCpkz
        vMyN80sdQG0TeQ==
X-ME-Sender: <xms:2Dr9X1fMBMnb9wU_1QrElEJClw5-jGLO-t8kldkn7Qhq1N9YwEvFxw>
    <xme:2Dr9XzNHywAiC3DuxbmR8eSSAhIhIRuSGGSXIlJe8B8xIVUOFTKhRWxh7lcOHFxh5
    5k6XElAkZs2I8hlaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeelueelgeettdfggfeuffevkefhuddtteeigfevhfdtffdtjefgteeg
    leeggedvudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:2Dr9X-h66cyosRvcblNKKirUxnl5pTEADsDrUA5GXcng7iJwJUzbtA>
    <xmx:2Dr9X-8wmcZ8pyFiWxCO86Dl03U2Lt24JTVDyPY-rNwyZ0Q3qmK0Dw>
    <xmx:2Dr9XxtUyMsThmbvalvM3NDI-M4dfQ3iaeaovA5aDPE_koyRNYwBSA>
    <xmx:2Dr9X3DtDMO290E6vGGQ-laszrTdV1xAr6FsMu7Ds1iATUy_Py3y_A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E22CB24005C;
        Tue, 12 Jan 2021 00:59:51 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
Date:   Mon, 11 Jan 2021 23:59:41 -0600
Message-Id: <20210112055950.21209-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
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

