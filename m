Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D522E8BB7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbhACKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:50 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41815 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbhACKch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:37 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 90B695803C1;
        Sun,  3 Jan 2021 05:31:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=kHNUdiyg8S7Tg
        ouKi0a01PLkbd8OkZQLHLc1mjEb1AE=; b=ZD/IkwnTNvnxNaskj2D8waxHLaFKz
        y9QbZDTEGMzAY0XK7xbKupnGqZ2Jyc2qV/TQNggiGtjS+nLerzfPmNAO9c362YSC
        uqTiZvkmTX4eqsKtyvbwLksCiBIY1j41vo+Ir9xkcgzeUXpC4O2Sh/BzvEHVfbxz
        3tUuy/VmOXnTTwpBuac1tvw/iVL1lnHL0IpizYDopflPmazAZiJ/4LFs55g20uSy
        B6xbBCYvqn1fXwwMh8hB0N3r71KspBT+yrUrCqye2m5DaoXSQFFW3u4ev/9cucRE
        IYqj2NcWQ+WzykNNmT406AeCXKEi7psqfbcfmjoYso11mMauurue4Oylg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=kHNUdiyg8S7TgouKi0a01PLkbd8OkZQLHLc1mjEb1AE=; b=bvr2zcOY
        QTN+l+km4gjznBiDBcQRsFzPjUBn5pQ8MHVJQaJt2LHlt9508ytV0Kxty38AJNpy
        fNsmekgtXPlZSW2f7TRAT2eXOCdgpuyzlb7zYo7isds1YCY7QRdCqg1tUmsXtcZj
        GGbnNrAn9fzb0aYcEnws6zkzAbsqdq1Pt0vPs/9nrO+EknD9RzwUhN+K4YQ2dyke
        FzWXTfjU/iLZHxZJpQs4aFOeoQAkTnerdNoWac4sAfvPvSdeNvwg3da66iMtmKvd
        tH0EMT6r+WUN5Hh0aFnguzy2aRdwb5WcGvli56t15Dsru20db8/+pKpzXNUpbnuF
        2YDAPo2L/V9B5A==
X-ME-Sender: <xms:6ZzxX6oXkoLCrZqkKqWVoTTPdRKwCLo2FspzpBaWHSSR2b6t3Y_g8A>
    <xme:6ZzxX4rrJF5hvYNhMX3tgj0BASI72td_BiV4SEcikwnsPlkweMjoNDMCTj7cdzXW0
    _MvRT0r2EYCQydK2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:6ZzxX_Od7gfmeSimqcexlBQFy7wKX1KWP1SLTuYhN29xZfH3_Xaz3g>
    <xmx:6ZzxX57-aF30cFdOtNUyXnbnHiprJbRoo3fPPWC0aGZMgjsJqj-g_A>
    <xmx:6ZzxX54hYhR-iLrz6mIf2Bx_tJdfR4rOeLABPkAu08nCVTx5l-WHIQ>
    <xmx:6ZzxXxzO4EUoPD8hpR-lEwnB1e4TWAGS5D7gl9xflkNhTpC6fz_lsQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id C443A108005C;
        Sun,  3 Jan 2021 05:31:04 -0500 (EST)
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
Subject: [PATCH v3 05/10] ARM: dts: sunxi: Rename nmi_intc to r_intc
Date:   Sun,  3 Jan 2021 04:30:56 -0600
Message-Id: <20210103103101.33603-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
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
index 708caee52425..f1a565e588cd 100644
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

