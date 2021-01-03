Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14C2E8BB3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhACKcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:42 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43303 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726718AbhACKci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:38 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 44DBA5803C7;
        Sun,  3 Jan 2021 05:31:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=gFMb1siCBB3vI
        qaTnOqZ8KYmLwwQQQewrMV14IDyRQY=; b=QXFq94Xrsnd9OkpU8J5nAnT0kk+bt
        0VeMgJtCfFLEmCSBFlHdtFBgQ8A4/e/6F4ifvrpsbF0KVpzb0p9M9jcUGSOIX7yw
        V4mQ6yBtifgXQ9snclmo2Rqx1PezR9ZXs3NvgfBEYVZOKVxg9mld1TEAKQmroRUe
        MzqW76P+zgXHsBoVt6btUPGWMsDT0hQJ6gq7dJMudiH3t4WDJLo8ZQ9wlU+v1n38
        Gww2VC6jskf9sYcWp7XEgjEmwAMS59v0FgFwB6Hhxi9lUaNIA2UGyv/nz8UdsxVR
        bzBnWbrT7jDAhXKIQaGLtQF2ScfJAvs6j12jXOvxpegHeegMQRWZWuM0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=gFMb1siCBB3vIqaTnOqZ8KYmLwwQQQewrMV14IDyRQY=; b=bPqAhNEg
        jE3Wls0WdZN5Qc8xXa9ECMACbZOMYpCwK8wkLVqLl3dculI5oCIQ9ReqS6NJwfcA
        MaG9maS7h6g2l2hnLpb6OTbENhqS4miuWqt5s6CGsD0mP1SZpaBQuo8XI1x7bqxW
        45GgSNI7j1B+3tAWQknEc+TvBUQFU59X3+tgZWJHMr/txAEOvbQMNcBpAkAs4QUt
        TRTusOsnOK61Nm8QPhFrRBeBtSo8TgJbGyNzKJ5T1R+q8nPBgOOsm0HWmu//bSxJ
        smd9+M9MeHxnxN8kFzxO6U0GkK38MuY7EnByTVMyhnoUXBzkbj5VELAF2vKCZbWt
        sYYRhVzRbkUNZQ==
X-ME-Sender: <xms:65zxXxWpLMLC01DxLKLPdhiaTqSww0ov4D7pP2i-oHRI-vCDv7fOKQ>
    <xme:65zxXxn4PipakAObDb0jowlpju_G2pRbbZYMXTQuzsNd0WQ7O4JlinGn82cUE1hke
    C6Ra8JU-VvNDNrPzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:65zxX9ZwIuyaqsoMUkJIq-l3KaqmagiS2rLp1RlJk1jUteZ8DFIHpQ>
    <xmx:65zxX0W7NVpTC0zJMafoHD6euBU7f5hizUGSSFCqmNXeSGCDow-11Q>
    <xmx:65zxX7l-AGVjhlQUvsBreNXOv2TES-WdslJ1BQWtTKgKWHOoNnPjzQ>
    <xmx:65zxX--2f8kthGnokqL5UIIZQSAkc5nWUiFDzqbIi_tbv-c-wDPOIQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7FE3C108005F;
        Sun,  3 Jan 2021 05:31:06 -0500 (EST)
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
Subject: [PATCH v3 08/10] ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
Date:   Sun,  3 Jan 2021 04:30:59 -0600
Message-Id: <20210103103101.33603-9-samuel@sholland.org>
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

