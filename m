Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FF2F282C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391000AbhALGBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:01:48 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:55737 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390730AbhALGBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:01:46 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 73A9E580560;
        Tue, 12 Jan 2021 00:59:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=JyMfcNHYaRd5U
        RFc4fnETjLAVdNUP7bEvNnbaoJBv+E=; b=BVKrwbXD6g5H9jKYMXZ8u0gzLTZMF
        My90ZRsRVfrkpzya8YPaK6Cay0ol1t4bngCPyXKbbc9SYDIOuf42qpIOMyfDjSmt
        SVvKMdhqpRDNF5lpe/lVLlG2E/OEfcoW10tnvsH9SsoudgasPq071eJR2qk2ugFL
        7TdU8GSnlMCYJZ8prUxaYlxZ+4sFr5MPLmH1LZdcz02vkmPmyMB/E50DRFFfyn5A
        waKk/NjP2c5PHyzYr/BW2AWXyiTcZirvA//iKSc+Akjqzj0ruSJi5sNKSnq6sDd8
        dcXFBiEICYhyPQiUaeLtS0g4FrP99p6Rm1EqDrrrwluAMIdcFijNN5CPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=JyMfcNHYaRd5URFc4fnETjLAVdNUP7bEvNnbaoJBv+E=; b=f8Xx8C4m
        gt894KdWHI00972AgGGZleEkAAMMncuegX7vjtDBd+gD/YTQPrTSKIbahHKSbSdn
        n0Nc5ts8JjXm+bsNPBwHEEq87G2ERbl4ettHB0dy3JK74e3c58jqYUTJbABoBW84
        nhB71XMyMJGaGC4MrbvaJwG+D+KyxwLo16+1A/lW40QUZn0ZJDLgUKFMV61SOsjQ
        pvuoqj1/JlFU38btOBQ+7YMzmeYnM/hiR9WMqjmCzasq15U35ULSyCgQlbBsZsIy
        IHkE0xbyFStyp7xUhX0rvFJtHwoj8ut/zyDcYYODOr2elg+w/b0QKEusiWimddUV
        o1zQxFz4hzEIDA==
X-ME-Sender: <xms:2jr9X6GNQ1_8fR0Ylouo0xsaDTnn4Lm5dDW2qbGa7QeQwUiWnm-Ufw>
    <xme:2jr9X7UPZLfEqD-zF9HFl-W1RrcApFOm6rM_vYnxX1D2DVswsg6frrUKiAUvT7Ua_
    v638hDcYkOp0dQajw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:2jr9X0Km82NjfFz2LWW9Pak4FuHjU81KrQ83cSg_YYpSxgMU6mzJOw>
    <xmx:2jr9X0GC2DtFQTYvX5Mc1wxQRtqj9u-vNUBZmkV0lE2b5HMeRGBBnA>
    <xmx:2jr9XwWgZa6ap63FetIq0paH9QwggAy5XfNR4gXqG3aKNisrLYTogw>
    <xmx:2jr9X0qjwJWt_yxv4poZjZ36MQeRZIijbgjTsjy_6z10WFHi5ct_IA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C415824005A;
        Tue, 12 Jan 2021 00:59:53 -0500 (EST)
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
Subject: [PATCH v4 05/10] ARM: dts: sunxi: Rename nmi_intc to r_intc
Date:   Mon, 11 Jan 2021 23:59:45 -0600
Message-Id: <20210112055950.21209-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The R_INTC block controls more than just the NMI, and it is a different
hardware block than the NMI INTC found in some other Allwinner SoCs, so
the label "nmi_intc" is inaccurate. Name it "r_intc" to match the
compatible and to match the few references in the vendor documentation.

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

