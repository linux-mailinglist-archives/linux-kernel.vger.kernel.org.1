Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99DE72E8BA9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbhACKcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:11 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:35237 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbhACKcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:10 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3E1A95803BC;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Xhy6XK2W2yjtu
        pgG0yoTOpphFN3j79/GvvTT2Ki2qs4=; b=ZxuExiMuKyMl11ucqijdyg1JDTX9i
        xTf+Xqw737/KZwhmEOBza/kWYSk6Feev5RGCz9ndAX398nABjAImpaNHzMRrWUrE
        3whS/RwPu1bw3Qw5S2Bi4+nOW7FQwekM379EkIxREb6zEVLS2aZMrjFo5OansV1J
        4eXH4aitY4mBe/ArEowytovebELo+ipuOJ1152lQC/xSwAIrMjj9oEwau/s/v9Cv
        HKy6OK3ZrFItQuuarLmW0ZqGPKJ7IDMqMGrommN4yNmPRQf73wfeXepki7a2Oms6
        X8M6MjAenVe4nduKO4czu6Vqw6EEBlIvYt3ivTUsotah6ITf7P90Ye8Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Xhy6XK2W2yjtupgG0yoTOpphFN3j79/GvvTT2Ki2qs4=; b=kjbwVmAG
        eEhPzD++igxa2qM2C5nmLlQe04gciTAyPoqLWk3T8PST1/IQ0S/SiQgeI8XIj8pS
        7APH0M6TJVDhTyWWFmK7qWmJK6MIDgHov9j8GKrygb/L/KEg099giiQl/rfqnkIN
        oeomG/ATSMwUMP4PO7M53Svwi3X9Qc+8YaLwMmM3/UzZGsBR5eEIdnGzdCichVYX
        8LoWGfPaZQraIHJj2USS8yogx/c3nNoj6S2/TtllCzXASWfCtNoQQ05sPQcK2mva
        R9CUq7/I9IPk7Zi6eaBu2I8aQbBbdsMCEmI0aGA1OurlxBxmQWJlyMAZPjpJieMS
        oCMmzB6ls+teeQ==
X-ME-Sender: <xms:55zxX-cpyDs4BplVu9ySwMaCkDACPJ_99bkHIibXzCd8WyoxgG4UBQ>
    <xme:55zxX4N9yYQZqNUPUYhbjVT6q-mEj_fWccfX1Zye-_0vP6ELJnFAet4cE8EIJmQQA
    RCnLr_aCPe9tFCMYQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeelueelgeettdfggfeuffevkefhuddtteeigfevhfdtffdtjefgteeg
    leeggedvudenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecukfhppeejtd
    drudefhedrudegkedrudehudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:55zxX_h6stakaLzg6NlBgjiscKdK6KQinJOZ-kV6z2J3n3spxs1wbQ>
    <xmx:55zxX7-X_HXXOp_74yUYIEzE5TwZVd9AllDjJCzJE6EX2jYpX6bkyg>
    <xmx:55zxX6v6Oe_GUEDAW6uc6nQ1DIvpIkZRT8uyKtcVOIbDU7fg-gQkPQ>
    <xmx:6JzxX7EV-uNVd_3vytkWeDJ1KyXryLP3Uz912NtTuGFW_27YondU3g>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7059B108005C;
        Sun,  3 Jan 2021 05:31:02 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
Date:   Sun,  3 Jan 2021 04:30:52 -0600
Message-Id: <20210103103101.33603-2-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC in the A31 and newer sun8i/sun50i SoCs has additional
functionality compared to the sun7i/sun9i NMI controller. Among other
things, it multiplexes up to 128 interrupts corresponding to (and in
parallel to) the first 128 GIC SPIs. This means the NMI is no longer the
lowest-numbered interrupt, since it is SPI 32 or 96 (depending on SoC).

To allow access to all multiplexed IRQs, the R_INTC requires a new
binding where the interrupt number matches the GIC interrupt number.
For simplicity, copy the three-cell GIC binding; this disambiguates
interrupt 0 in the old binding (the NMI) from interrupt 0 in the new
binding (SPI 0) by the number of cells.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../allwinner,sun6i-a31-r-intc.yaml           | 64 +++++++++++++++++++
 .../allwinner,sun7i-a20-sc-nmi.yaml           | 10 ---
 2 files changed, 64 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
new file mode 100644
index 000000000000..18805b6555c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun6i-a31-r-intc.yaml
@@ -0,0 +1,64 @@
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
+      - items:
+          - enum:
+              - allwinner,sun8i-a83t-r-intc
+              - allwinner,sun50i-a64-r-intc
+              - allwinner,sun50i-h6-r-intc
+          - const: allwinner,sun6i-a31-r-intc
+      - const: allwinner,sun6i-a31-r-intc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
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
+unevaluatedProperties: false
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
index 8acca0ae3129..f34ecc8c7093 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/allwinner,sun7i-a20-sc-nmi.yaml
@@ -22,23 +22,13 @@ properties:
 
   compatible:
     oneOf:
-      - const: allwinner,sun6i-a31-r-intc
       - const: allwinner,sun6i-a31-sc-nmi
         deprecated: true
       - const: allwinner,sun7i-a20-sc-nmi
-      - items:
-          - const: allwinner,sun8i-a83t-r-intc
-          - const: allwinner,sun6i-a31-r-intc
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

