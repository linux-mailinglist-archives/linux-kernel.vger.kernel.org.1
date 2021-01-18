Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55362F999F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbhARGAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:00:09 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:44777 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731439AbhARFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:52:36 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 834641617;
        Mon, 18 Jan 2021 00:50:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=JCaBWNRaqR+9o
        KH6kMXGT5V7FkCjRiGpzzJkcd8E/r0=; b=ZcemnhAeMvCEhkZ8H3qvc/YWCnfVT
        aaikMSmxW4T+YjuuhvS9JfbU3tFcVYxVYG5ZauPfuAyb3yH8jW7pJAGyiriGuxT0
        SbJP6BvAbZpf1u2h2okGdxO/P83EQcBFu/2phH5Sftq9D6GMHFy3mdqAViwRF3EY
        5HLSzRUGZS9lEaJhhBR7iZZ1x3HwmyYo/+VmaTj8Vzn1crUcNWxFt7K19c263RnY
        IsaZAwQRNRrDp0v6g8WKWK+CXrBtenCcg37vGSIMYXUA9K5qJyoIRN7TpVBf0FaI
        AZKVn9IoNrSHvTwq2+5bTGPYi4sA+ESwf++fUWviYtot2BUHMkDiFZC+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JCaBWNRaqR+9oKH6kMXGT5V7FkCjRiGpzzJkcd8E/r0=; b=eDaW8nop
        q3w9CTweqFCrcgHEYHgZqc3hd0/LAH6WP+FxyLpzacLkoHa7tKQR6+dHAqrhkjgD
        FHlprt8cf8WndW/JfJAhipqkAFN1HtY66vKIOm8W0L5rlleTT2eTK78WxbcTrfDq
        fiiX35OMxl5G8FJMcciHjOcKfd+knmfifJzyL6r6gh3ZKOcXUz70O9YLOlXE6U3k
        23Ny5dCRsNLBfMM4FGkJpKnj1nPXVeqpqeSbL75K7WTlHKan1t4hSJYhmRYyjjvD
        gsBgXLj37JhOQxNtuD6kH969jvlhagT2LIr+lN+pogXBfA/agqf9eNfX+0u01G1V
        3G51+7s+QRrvmA==
X-ME-Sender: <xms:syEFYAl4ZOrPrsYujIvBDuYiV2yoVXpot-Mh9bc29OIBmLjIV9XB9w>
    <xme:syEFYP1N4c67wGtvD7lOtqmDGWRb3yk1B_c1mYVHQrAj55J6AfTBSZYhyiZIlD-ET
    hqZKBpPnsSgyvYeeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:syEFYOram8R6bUxyM-X1cGg0XFAkXpzEktRcRDocVDq7P6mOqovh7w>
    <xmx:syEFYMndpb3XEsimfGgTwiJzsh-LDL8c4x3LbZxwBvUixrKrG5oMQw>
    <xmx:syEFYO3IccRX8V9dHi04f7IoJgJWTLRQS8F3S1Q3LFDyyf4PaGjg5Q>
    <xmx:tCEFYPJR_0zpsSS9NkAesbCOmLCxFIXIAX_dpZFiCrtAs1v0HzIwz-CPOIw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7B2AC240064;
        Mon, 18 Jan 2021 00:50:43 -0500 (EST)
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
Subject: [PATCH v5 05/10] ARM: dts: sunxi: Rename nmi_intc to r_intc
Date:   Sun, 17 Jan 2021 23:50:35 -0600
Message-Id: <20210118055040.21910-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC block controls more than just the NMI, and it is a different
hardware block than the NMI INTC found in some other Allwinner SoCs, so
the label "nmi_intc" is inaccurate. Name it "r_intc" to match the
compatible and to match the few references in the vendor documentation.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts              | 2 +-
 arch/arm/boot/dts/sun6i-a31-m9.dts                       | 2 +-
 arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts         | 2 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                         | 2 +-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts                 | 2 +-
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi           | 2 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts         | 2 +-
 arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts | 2 +-
 arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi     | 2 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi                     | 2 +-
 arch/arm/boot/dts/sun8i-a33-olinuxino.dts                | 2 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts           | 2 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts             | 2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts                   | 2 +-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi     | 2 +-
 15 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 73de34ae37fd..486cec6f71e0 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -226,7 +226,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index a645c8f4257c..6aeb5a9696f7 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -115,7 +115,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index 648f24746234..6c6c1bd22bf6 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -115,7 +115,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index f3425a66fc0a..6a733a36d34a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -1305,7 +1305,7 @@ rtc: rtc@1f00000 {
 			clock-output-names = "osc32k";
 		};
 
-		nmi_intc: interrupt-controller@1f00c00 {
+		r_intc: interrupt-controller@1f00c00 {
 			compatible = "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index bc3170a0b8b5..429a165b79b2 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -159,7 +159,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
index 3099491de8c4..7455c0db4a8a 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -78,7 +78,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 367006fb280d..0d124a4a7cf2 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -148,7 +148,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index 2504e7189c54..cadc45255d7b 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -98,7 +98,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index 7de2abd541c1..6bf3fbdd738f 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -79,7 +79,7 @@ &p2wi {
 	axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		drivevbus-supply = <&reg_vcc5v0>;
 		x-powers,drive-vbus-en;
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index c1362d0f0ff8..a42fac676b31 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -716,7 +716,7 @@ rtc: rtc@1f00000 {
 			#clock-cells = <1>;
 		};
 
-		nmi_intc: interrupt-controller@1f00c00 {
+		r_intc: interrupt-controller@1f00c00 {
 			compatible = "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
 			#interrupt-cells = <2>;
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index a1953b2872d0..2c8db949f99f 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -98,7 +98,7 @@ &r_rsb {
 	axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 785798e3a104..f18ae8a1976e 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -164,7 +164,7 @@ &r_rsb {
 	axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 	};
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index e1c75f7fa3ca..09ec68c64535 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -163,7 +163,7 @@ &r_rsb {
 	axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 4f48eec6b2ef..9cdc2ed84847 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -164,7 +164,7 @@ &r_rsb {
 	axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		drivevbus-supply = <&reg_vcc5v0>;
 		x-powers,drive-vbus-en;
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index b3d8b8f056cd..8175bf307eb1 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -92,7 +92,7 @@ &r_rsb {
 	axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
-		interrupt-parent = <&nmi_intc>;
+		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		drivevbus-supply = <&reg_vcc5v0>;
-- 
2.26.2

