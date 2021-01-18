Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAC62F9995
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbhARF40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:56:26 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:60445 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732319AbhARFwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:52:16 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id D41CE164F;
        Mon, 18 Jan 2021 00:50:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=0mK8xipRz9uKB
        pZJRUzcavsWYDSQTY9PY1dr4SOts8A=; b=qQqS5TnotK7g9US5xQ4R2/7Gv3hnS
        X43T7lS3eUAmd09njRtuEtrAjmotWj9pJHnHajHuZqpK9nrEWDwCVWq5c5sJDNNZ
        /Ya+fM8AAWrQ4tu8N79W9dECQZoeP7WGlyESg7hy9R00taZOKC5TiU1Q/UX7JBbd
        WnWuG1FfSmMrCvwwGjm+e9bbYVc0Z6W4BIDLrH7lIbNG+loapxZ93BQrc92xDLZ5
        9xedtPt0/l2np+TRoMtYJOvV2et73gqsgtW143/vIZdKF2LHwyBfAA27YNLYUqTs
        ALnNNQkhGPCPVs3jRejDqyE9WAV1YngIOPM1m7uQfnpkbOy5zPYWVFA/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=0mK8xipRz9uKBpZJRUzcavsWYDSQTY9PY1dr4SOts8A=; b=mRIYEwFa
        z78gkznqy1WWpaAiF1zEl7Pqry6DIneaED3QmpP7Ma93xOu6Xknjo0vTnkHZAccD
        7zejrUnRVOlOMxiugPcANWVHm4Y0bg0PfD7xIaQWXgKu5UZt0D7Qs0L88tuYkRb/
        jRFFRDccz1IePxKS+DKZ9A0x3DCpK/FBub6YKAgz2DiQZsIz95m8/oxe5mdLsUR7
        JZaPLJkGjU6iipUXFBEtcJDf4S+l6Nb1VuGQIgE0mvEaDyvUb6s2COaE3kEAMTYT
        J0d9I0DMtiOSy6phEK5KdYh0Q/C0iWbwl5neSyYDrKu/yOToI1Sq4Hc+zcwl/QB1
        GhtDHg3vS6hMCw==
X-ME-Sender: <xms:tCEFYN7yOC1hwNg-Z9Wc3Cj07BShVtKltLCQFWNJSXH3vEl94sZQPA>
    <xme:tCEFYOLkmAiXoU5tFRAfq0i_GZu1YUY4AYA5_eAk_YuAkQG9gE5j9t_JwQ8m11N49
    _nFNW5FcR_kuTo5pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:tCEFYN4D3-s76MigYzMsufcvs8I2oFhOSc130LVZgnVcavyfoA2T0A>
    <xmx:tCEFYByVd0qwma4jwPYzlXzg5ghV16h641ODFtfxa6tgx3anFHdeEQ>
    <xmx:tCEFYBYmQ-07E9xgqC-StrNg-HqeBkZq4MbHA0I64NEkkf6bmpniUw>
    <xmx:tCEFYKtMCCunS0Fk6aTFKquh4ThirXlkamfO3VBniZTpNIHyxuqxBUUXNyc>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E9E16240065;
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
Subject: [PATCH v5 06/10] ARM: dts: sunxi: Use the new r_intc binding
Date:   Sun, 17 Jan 2021 23:50:36 -0600
Message-Id: <20210118055040.21910-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding of R_INTC was updated to allow specifying interrupts other
than the external NMI, since routing those interrupts through the R_INTC
driver allows using them for wakeup.

Update the device trees to use the new binding.

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
 arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts   | 4 ++--
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts             | 4 ++--
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts         | 4 ++--
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                | 4 ++--
 arch/arm/boot/dts/sun8i-a83t.dtsi                        | 2 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts             | 2 +-
 arch/arm/boot/dts/sun8i-r16-parrot.dts                   | 2 +-
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi     | 2 +-
 20 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
index 486cec6f71e0..236ebfc06192 100644
--- a/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
+++ b/arch/arm/boot/dts/sun6i-a31-hummingbird.dts
@@ -227,7 +227,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 6aeb5a9696f7..2436b13cbce1 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -116,7 +116,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
index 6c6c1bd22bf6..ce712bdd8cd0 100644
--- a/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
+++ b/arch/arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts
@@ -116,7 +116,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 6a733a36d34a..faf85c5f4e1e 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -1308,7 +1308,7 @@ rtc: rtc@1f00000 {
 		r_intc: interrupt-controller@1f00c00 {
 			compatible = "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			reg = <0x01f00c00 0x400>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/sun6i-a31s-primo81.dts b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
index 429a165b79b2..c5c85eb44cc7 100644
--- a/arch/arm/boot/dts/sun6i-a31s-primo81.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-primo81.dts
@@ -160,7 +160,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;
 	};
 };
diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
index 7455c0db4a8a..227ad489731c 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi
@@ -79,7 +79,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 0d124a4a7cf2..abf742c4d47e 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -149,7 +149,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
index cadc45255d7b..0b61f5368d44 100644
--- a/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-yones-toptech-bs1078-v2.dts
@@ -99,7 +99,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
index 6bf3fbdd738f..f38d19c6be8c 100644
--- a/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun6i-reference-design-tablet.dtsi
@@ -80,7 +80,7 @@ axp22x: pmic@68 {
 		compatible = "x-powers,axp221";
 		reg = <0x68>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		drivevbus-supply = <&reg_vcc5v0>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a42fac676b31..a84c90a660ca 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -719,7 +719,7 @@ rtc: rtc@1f00000 {
 		r_intc: interrupt-controller@1f00c00 {
 			compatible = "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			reg = <0x01f00c00 0x400>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
index 2c8db949f99f..810fada3db00 100644
--- a/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
+++ b/arch/arm/boot/dts/sun8i-a33-olinuxino.dts
@@ -99,7 +99,7 @@ axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index f18ae8a1976e..66fec9a8c777 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -165,7 +165,7 @@ axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 	};
 };
diff --git a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
index 9c006fc18821..c31c97d16024 100644
--- a/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts
@@ -122,7 +122,7 @@ axp81x: pmic@3a3 {
 		compatible = "x-powers,axp818", "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		swin-supply = <&reg_dcdc1>;
 	};
@@ -142,7 +142,7 @@ ac100_codec: codec {
 		ac100_rtc: rtc {
 			compatible = "x-powers,ac100-rtc";
 			interrupt-parent = <&r_intc>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&ac100_codec>;
 			#clock-cells = <1>;
 			clock-output-names = "cko1_rtc",
diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 431f70234d36..2e8e1134a852 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -203,7 +203,7 @@ axp81x: pmic@3a3 {
 		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		fldoin-supply = <&reg_dcdc5>;
 		swin-supply = <&reg_dcdc1>;
@@ -225,7 +225,7 @@ ac100_codec: codec {
 		ac100_rtc: rtc {
 			compatible = "x-powers,ac100-rtc";
 			interrupt-parent = <&r_intc>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&ac100_codec>;
 			#clock-cells = <1>;
 			clock-output-names = "cko1_rtc",
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index d8326a5c681d..f15eb782bca3 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -239,7 +239,7 @@ axp81x: pmic@3a3 {
 		compatible = "x-powers,axp818", "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		swin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
@@ -260,7 +260,7 @@ ac100_codec: codec {
 		ac100_rtc: rtc {
 			compatible = "x-powers,ac100-rtc";
 			interrupt-parent = <&r_intc>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&ac100_codec>;
 			#clock-cells = <1>;
 			clock-output-names = "cko1_rtc",
diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index bfc9bb277a49..1a146e200cde 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -263,7 +263,7 @@ axp81x: pmic@3a3 {
 		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		swin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
 	};
@@ -283,7 +283,7 @@ ac100_codec: codec {
 		ac100_rtc: rtc {
 			compatible = "x-powers,ac100-rtc";
 			interrupt-parent = <&r_intc>;
-			interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 			clocks = <&ac100_codec>;
 			#clock-cells = <1>;
 			clock-output-names = "cko1_rtc",
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index c010b27fdb6a..0fce227f56d4 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -1114,7 +1114,7 @@ r_intc: interrupt-controller@1f00c00 {
 			compatible = "allwinner,sun8i-a83t-r-intc",
 				     "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			reg = <0x01f00c00 0x400>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index 09ec68c64535..8e8ecdcd3a83 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -164,7 +164,7 @@ axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun8i-r16-parrot.dts b/arch/arm/boot/dts/sun8i-r16-parrot.dts
index 9cdc2ed84847..de4bce5f89a8 100644
--- a/arch/arm/boot/dts/sun8i-r16-parrot.dts
+++ b/arch/arm/boot/dts/sun8i-r16-parrot.dts
@@ -165,7 +165,7 @@ axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		drivevbus-supply = <&reg_vcc5v0>;
 		x-powers,drive-vbus-en;
 	};
diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 8175bf307eb1..d71ea3637850 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -93,7 +93,7 @@ axp22x: pmic@3a3 {
 		compatible = "x-powers,axp223";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		eldoin-supply = <&reg_dcdc1>;
 		drivevbus-supply = <&reg_vcc5v0>;
 		x-powers,drive-vbus-en;
-- 
2.26.2

