Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41F302F2828
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390688AbhALGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:01:29 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:51359 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731080AbhALGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:01:27 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5CB3258056C;
        Tue, 12 Jan 2021 00:59:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 12 Jan 2021 00:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=gFMb1siCBB3vI
        qaTnOqZ8KYmLwwQQQewrMV14IDyRQY=; b=E+7UMOqVTXfuF2hj2MaJIme+pDUBe
        l/nImstlK6EIw7l45FAjiaE5mng6LWLnNRiFH1MtWR+Vwi7ysF119xb3ErvYli9V
        w0s845hGLFpDxDTKbV7+rwDdDJwVa0QjhquFMuuIdboW9kfP3U3+XEUAUhEfyLSr
        oakjuTMgkreYtP+04tN1brOxTUmnn7p32nMB58ulosomE9I7WwZxd0BvlO+48ixd
        SBCL+ESdJBQ3YrPKA8GHyn5OO2Y+XVEX3oSTVlhU/y6Iisy6ICszM5l6kmfRmXHm
        TooVJNj35wLITwcf7dWYB/bE0d6QOuC8DaIfP0Hd5GsNWYvxJ54Y9WoCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gFMb1siCBB3vIqaTnOqZ8KYmLwwQQQewrMV14IDyRQY=; b=Wph/7OU4
        cIPMLhEP/Sy/v0csGTHNNPt5YerwGHpfPIH6qMF/1c1JDc6i/VSr28Vfl9GeAuYt
        quBO2Lhm4pj/kKg2/gDp5/H+ytM2BcV5aVOE0tjdgl/JyjI9P6j6k5NghNt2RmjP
        uN1kQaNit72On0Row+VwLaI1qrUpfx0YjCM1zm4+XpDwNaxy3+bDOL5+84g95YGv
        H+NF4NHpPkZfXpskKkbIA1u1WbGw1fxVGqV/ktX5SWKY63eea2peQaYa0atixoyE
        qc9U8pptiFTaUrTv3P/9GiFogfaTmRfgC9vpRPW+pP5h8B99tBw4S7WnXp8NcKi1
        /Kf+apUVujKJTA==
X-ME-Sender: <xms:2zr9XyEZWNrRpMpmQem4R5oV3bvwxe6ZtFv4hRxR47YpAC2HTfi4vg>
    <xme:2zr9XzTa904TU3kkVIfhtdMOhJQdr40pOiCGMEw-rCbNl7koYf1fcpTdqgwObAxWa
    FueDWBfBnbhuF7PSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:2zr9X5CVpy680ZXOFTPMeNGZYF4x5jy2IQmUvfboXgIUEaCWLxVf1g>
    <xmx:2zr9Xz37JPBeezrBUDHp0DgaKTINXkQINxdZMv5yqm1MyvzZ0jemgw>
    <xmx:2zr9X3XQsgoqfhmWq_u6xQaYBNNGcXD0oovmuTqhZjc1m_oS46HSgQ>
    <xmx:3Dr9X38-I7-Np3tkuBPiw3mRSJT8Im_dVvBk2vLejcd8P6USzf11dA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2DD5024005C;
        Tue, 12 Jan 2021 00:59:55 -0500 (EST)
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
Subject: [PATCH v4 08/10] ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
Date:   Mon, 11 Jan 2021 23:59:48 -0600
Message-Id: <20210112055950.21209-9-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IRQs that can be used to wake up the system must be routed through
r_intc, so they are visible to firmware while the system is suspended.

In addition to the external NMI input, which is already routed through
r_intc, these include PIO and R_PIO (gpio-keys), the LRADC, and the RTC.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi     | 4 ++++
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 4 ++++
 arch/arm/boot/dts/sun8i-a83t.dtsi    | 3 +++
 arch/arm/boot/dts/sunxi-h3-h5.dtsi   | 3 +++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index faf85c5f4e1e..50324688c28a 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -611,6 +611,7 @@ ccu: clock@1c20000 {
 		pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun6i-a31-pinctrl";
 			reg = <0x01c20800 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>,
@@ -802,6 +803,7 @@ i2s1: i2s@1c22400 {
 		lradc: lradc@1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -1299,6 +1301,7 @@ rtc: rtc@1f00000 {
 			#clock-cells = <1>;
 			compatible = "allwinner,sun6i-a31-rtc";
 			reg = <0x01f00000 0x54>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&osc32k>;
@@ -1383,6 +1386,7 @@ ir: ir@1f02000 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun6i-a31-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a84c90a660ca..4461d5098b20 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -338,6 +338,7 @@ ccu: clock@1c20000 {
 		pio: pinctrl@1c20800 {
 			/* compatible gets set in SoC specific dtsi file */
 			reg = <0x01c20800 0x400>;
+			interrupt-parent = <&r_intc>;
 			/* interrupts get set in SoC specific dtsi file */
 			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
@@ -473,6 +474,7 @@ pwm: pwm@1c21400 {
 		lradc: lradc@1c22800 {
 			compatible = "allwinner,sun4i-a10-lradc-keys";
 			reg = <0x01c22800 0x100>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -709,6 +711,7 @@ drc0_out_tcon0: endpoint {
 		rtc: rtc@1f00000 {
 			compatible = "allwinner,sun8i-a23-rtc";
 			reg = <0x01f00000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out";
@@ -805,6 +808,7 @@ r_i2c: i2c@1f02400 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a23-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 0fce227f56d4..2c05e296b3d8 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -708,6 +708,7 @@ ccu: clock@1c20000 {
 
 		pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun8i-a83t-pinctrl";
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
@@ -1150,6 +1151,7 @@ r_cir: ir@1f02000 {
 		r_lradc: lradc@1f03c00 {
 			compatible = "allwinner,sun8i-a83t-r-lradc";
 			reg = <0x01f03c00 0x100>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -1157,6 +1159,7 @@ r_lradc: lradc@1f03c00 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>,
 				 <&osc16Md512>;
diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 4bf25c5b873e..c7428df9469e 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -395,6 +395,7 @@ ccu: clock@1c20000 {
 		pio: pinctrl@1c20800 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01c20800 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_PIO>, <&osc24M>, <&rtc 0>;
@@ -852,6 +853,7 @@ hdmi_phy: hdmi-phy@1ef0000 {
 		rtc: rtc@1f00000 {
 			/* compatible is in per SoC .dtsi file */
 			reg = <0x01f00000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
@@ -909,6 +911,7 @@ r_i2c: i2c@1f02400 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun8i-h3-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
-- 
2.26.2

