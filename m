Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABDC2E8BBB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbhACKdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:33:18 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45165 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbhACKdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:33:17 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6F0E95803CA;
        Sun,  3 Jan 2021 05:31:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=wwUTEMQyIcHsA
        32XFCZmreaHfnAYAemDvQfBhbx8gxc=; b=aZ03jvhO+kk5hLUDvTrF3xmieSA1O
        6CQEzEMFP/AaTEQ5XMdOo49oVTQnFS6uPUswj7OYVy/G5rZCkvkrLrasYg3YODpb
        1zCUKD8IKmeehO2+3KIaAshatOF03owfthTfX4io9O2DJX3S6Uo4jgLQ2A177o1y
        yZO/UzsQTqgE6rd16sQNhsi5Cv+ATwyAECN8Xsiv7qBZXNBggEapQ01SLkqkeM8u
        2fOq8KfEwGS7pk5L5EkBNvTbk++BlSKl4enUExHDdDivu/7lhNWcDDCNULtzrI3P
        YwzPPGEmEqxmtDQZZGDfOS37yZ+UdOfIq2ToewEIiTLEo/+y9QYIYZkSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=wwUTEMQyIcHsA32XFCZmreaHfnAYAemDvQfBhbx8gxc=; b=Gipvcnlq
        Mz9TZtTQoxOwyrVAhFb2+r0XYsZwrKKAwo8czIyshl3/m4y6QEaXsXLl2Q3ODo9+
        mb5C/vbHn4SLIzc8gg37/TGunAM34a+wuVgJfL7cDvUNNyXsWWHXs2WoLFqT9XlC
        78ZiPQUZ3W3aPxvJIkL6mPMyyPDKq8eJiHEFRTQTvM0lKoBtLI8LCtt/p53YuSjN
        uaT3zh7B81r51NPZ3dXA0Et0rCPNhHLRrrlSAZ+6F7oBWXKTVywwcQs9v2JrFl4b
        vZ8lDYb3MPlyJNIWhyEDFcVLxjRmOI0etjy7A0WTA+n860zPj7waOZLAqO3VDLl6
        Kcc/1uROyBcs+g==
X-ME-Sender: <xms:7JzxX_abCVb-asCj4cDAYExniVI2vOBl3HD1q8uybUTDof2c32uGdQ>
    <xme:7JzxX-aH9Ka1VyeKYEyNscxjC5VEfD2rNqdkzUIU8KgE-RTbcOV_Si60BMEiPLUv7
    ZW2wF5FLh5jeei67A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:7JzxXx_Znnu40ESKr05aObkgXhpNU7DhSLNpJz_cVHSPUBzuRoHFTQ>
    <xmx:7JzxX1q4K6m5yOXDFgby35fA7Eju-zVxnRa9HX836nM1FQGqzPJmsQ>
    <xmx:7JzxX6oeeooXe_7lpD8ePymRmhjuOimNu61hKgi3u9cVtT846ltvXA>
    <xmx:7JzxXwhj3tmmUa3HnLZy7Q4_Wu9B_1hScO3LTkM6RqmTrEGSgvN4Dw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A3F8F1080063;
        Sun,  3 Jan 2021 05:31:07 -0500 (EST)
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
Subject: [PATCH v3 10/10] arm64: dts: allwinner: Move wakeup-capable IRQs to r_intc
Date:   Sun,  3 Jan 2021 04:31:01 -0600
Message-Id: <20210103103101.33603-11-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index fd4bf90163d5..b8697e84342e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -644,6 +644,7 @@ ccu: clock@1c20000 {
 		pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun50i-a64-pinctrl";
 			reg = <0x01c20800 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -814,6 +815,7 @@ lradc: lradc@1c21800 {
 			compatible = "allwinner,sun50i-a64-lradc",
 				     "allwinner,sun8i-a83t-r-lradc";
 			reg = <0x01c21800 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -1204,6 +1206,7 @@ rtc: rtc@1f00000 {
 			compatible = "allwinner,sun50i-a64-rtc",
 				     "allwinner,sun8i-h3-rtc";
 			reg = <0x01f00000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
@@ -1275,6 +1278,7 @@ r_pwm: pwm@1f03800 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index d838bcc7aa60..7587544301c3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -294,6 +294,7 @@ pwm: pwm@300a000 {
 		pio: pinctrl@300b000 {
 			compatible = "allwinner,sun50i-h6-pinctrl";
 			reg = <0x0300b000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
@@ -895,6 +896,7 @@ tcon_tv_out_tcon_top: endpoint@1 {
 		rtc: rtc@7000000 {
 			compatible = "allwinner,sun50i-h6-rtc";
 			reg = <0x07000000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
@@ -931,6 +933,7 @@ r_intc: interrupt-controller@7021000 {
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h6-r-pinctrl";
 			reg = <0x07022000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
-- 
2.26.2

