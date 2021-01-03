Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E62E8BB1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbhACKcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:39 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53525 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726531AbhACKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 063805803C2;
        Sun,  3 Jan 2021 05:31:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Df4lymlu5yBqY
        l85L0FV6zcP6Hlep3F7ZHHp43Jj0aQ=; b=JM2769Q6wkB3M+lSb03uOGY3lNQC6
        eSsiDBtxiPkz4z6DMgPg4v4vK1O2fLZwtT6miSm6NHbc9gKh0sNO/KHzmE8i+mfc
        2tIHB330npwRnJLaYmV6afq10+Z52xjpZJNIzsK4BAsiLtBmFcGjVuc9YQ+dZvUG
        3NEewbOYY9kUhUPUboAA4BXOcIldfJ0ugt43GBih5b5lTLVHFbgv/cc7nuKl9e1V
        ubUcUDuWxPJPBH4XtIYyNVFn5k80yXj6fJJxI/ygA6F7jb9PzUSXa1YIfNMZUtal
        2ZLrWZBmkvnh25yGib/StVS7Bu2gT6Bcf9DckkgEkqGKxvVTgkszzQDAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Df4lymlu5yBqYl85L0FV6zcP6Hlep3F7ZHHp43Jj0aQ=; b=WyhNWbBQ
        G8YDt7ITCMMeQLCEOAXN2dPjushoo51JzR36kY1HYFjyxRegcM2fOlMVb50pLtVp
        0zInOytxFi85aeaSnxf0cHttW7llqyQe8iAbZd+ZLvb71Ip5J8p165jmecsR+EoC
        GpagX8c7t3q3lY+WwiEtN52HhHlIEwbcBVxb0zW/S2dZeQ5ifUpSiYWE2wm6vcNC
        xXo8IKyiL2Tou6Zhc98lftMzuX9u9hkcbVvbVWb0hRKGhBSI+/1QWL3oj2+afT9O
        zCXmYFbr45aJe/htP/xh4C0dyGLcgO5kBG6Jyk3wIFmDkZJlz+azRqW6d5y7oTz2
        NtVTfe/CWd6jsg==
X-ME-Sender: <xms:6ZzxX9E0_kDSHfqd1dXTfqMpCqrfqN9v6OlKiDjLrWuASm4sfuMZlA>
    <xme:6ZzxX2IXEUZ-YVGpCv4JGRMOOjGmZiJsEshBKfT_Mg7OQfz6yvjDXOS5Mqkz7McQA
    tjfyfwWpCA7IxjsPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:6ZzxX4Ng7gz2n4J4hP-2Zow24gG1eJm6gAeOcsF8UTz3eaY0phtRxQ>
    <xmx:6ZzxX2kl07Jxck_rYg0i3HEEelCilB0QKdi3QBhJiktEojnRaN-iOA>
    <xmx:6ZzxX84-uPDWuXgFSye5slGP3PSMgT00ZR-31wykXtbvNuu7bzRl8A>
    <xmx:6ZzxX9jrSPqLyr2W7Nc7yDLEMUfbwktMEDpWza14FVQIO5aKXOz4yA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5CB5A1080063;
        Sun,  3 Jan 2021 05:31:05 -0500 (EST)
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
Subject: [PATCH v3 06/10] ARM: dts: sunxi: Use the new r_intc binding
Date:   Sun,  3 Jan 2021 04:30:57 -0600
Message-Id: <20210103103101.33603-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding of R_INTC was updated to allow specifying interrupts other
than the external NMI, since routing those interrupts through the R_INTC
driver allows using them for wakeup.

Update the device trees to use the new binding.

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
index f1a565e588cd..1f7cfaa86d3d 100644
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

