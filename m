Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE802F99A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 07:02:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732375AbhARGBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 01:01:10 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35287 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732327AbhARFwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:52:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B7B7A1660;
        Mon, 18 Jan 2021 00:50:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=vTiyJZn1WOCLR
        v/ekzKxUPw1XFT75ufKwL7hx+CoZFM=; b=gj+0ydYT6N1wtuF4XRZaepTkk271A
        osPuT+hCA+kT1Vd9ha4ZlxETt60ms9cK+SK9u57RuTGFDqjrYoY2FkuEWwY+u7OO
        wQtykmYc4oleKLKS7bcpdRSDBUX0cn7IR7veQK1nBRS5HUWyQ/HI2thNyOqL7psP
        xU4DMV7EvCgCosu0X7t5JX0AktHocFMUgkDXRiTI07htI5rydwosYKlZ4D/l5LsO
        sMytLXwp1i/te5hr0A2MGdTi9vbRhoAThGK0A1f6jWx0fuepli67kbuWbHG7Mp6B
        FA+OFWC0ZQe0FEfsD1qIIt/rpS/11vC/52jV+U4EPUAG6arJlSAW2sL9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=vTiyJZn1WOCLRv/ekzKxUPw1XFT75ufKwL7hx+CoZFM=; b=IjrBR0cF
        a9uB4e+d+VfbgEbLZ8DBT1Kb2NTlFdgOBdp69kqNWYn5toZIUFZwljpz0vHxq0Ac
        PGDDv/+LyN0N3fCFYAy6+SICX1npNJyGZm3Q2XgWn1VfmZLiv19GPjfE3+Z/yx83
        AUe0mdzhOoyK79lRyrqY2ivFv1I8ImoJh03ieksptArq2TQBC2S+LF/rpb/tZL23
        jxNbhnLuWjYVnLy4mym8xd5Uas1OYBWIK8neJ370C0C+2Er7T7qi/k0F3IGS51sb
        G9Yt29Lr5OHT3pXZo8DUgslFznfjrpraU2ZZcOPWLD71mDGBhriJmjm/12My89eN
        WWLm5az74wWi9g==
X-ME-Sender: <xms:tSEFYFV8_80OXM7WnNbFZuZAyn-1OaX3WubGYmz5-GzOed5pEayXZQ>
    <xme:tSEFYNBFqkX0hfiD-e1zckHjNH6hhFLVRM5l6ys9m-3J7W8N6CrhIIZoppfubQ3Ni
    Y0be4eaxtt0JPfY5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:tSEFYOyhdpQ8IH8Q-xlAK8oKlpGhmvl_Ei-rwlu6pLbN5AISCSsbAA>
    <xmx:tSEFYCB9V6Ij7CHn1WcOdtzvdQ-PmKdHT9dBniJ99_5XuLyVr3FLuw>
    <xmx:tSEFYDaCjD1t3y9x5DE6WCvDlrD3iAZ1FDJO7uOnd2gL6PEKeMs9cQ>
    <xmx:tSEFYPLe1MH34nvZ1G1hC1ffw2txdX5Et1zY8YfxTrxHhbAL3EbWre_eMlo>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D3C7224005B;
        Mon, 18 Jan 2021 00:50:44 -0500 (EST)
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
Subject: [PATCH v5 08/10] ARM: dts: sunxi: Move wakeup-capable IRQs to r_intc
Date:   Sun, 17 Jan 2021 23:50:38 -0600
Message-Id: <20210118055040.21910-9-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All IRQs that can be used to wake up the system must be routed through
r_intc, so they are visible to firmware while the system is suspended.

In addition to the external NMI input, which is already routed through
r_intc, these include PIO and R_PIO (gpio-keys), the LRADC, and the RTC.

Acked-by: Maxime Ripard <mripard@kernel.org>
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

