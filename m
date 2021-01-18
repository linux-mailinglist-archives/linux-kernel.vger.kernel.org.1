Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11AA2F9998
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbhARF5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:57:30 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:48999 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731481AbhARFwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:52:42 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id A00251657;
        Mon, 18 Jan 2021 00:50:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=rwPrbQh27EHg9
        RIWa6l1v6acfPj+oE8RuCzMCieTED0=; b=A36vCui3c5MirT+9s/LJfs72mhju2
        UMCZYgCuNG455MgVITTAOKyjMsISV0LKcxkYn3nkPZ47VaFA6zA1t/VtFSeHtXCM
        xMbO3KxzLPzQWlVzmUFWLffliaX4tNJPljA3iLKh2glD+jGr7G0rdV8rB4gif39S
        I1jsAi9B2wxCz9T1Kh8BmZzCoXp15cm6QFx4f5CANCYlabXs1kawlz9hVrmeBwPp
        B5+9yZAUzJ+S0lo36YsdIXDq1gHJXmE2u8kRP/JPgcW4NLWXEEQEKl9gVT+JHXeM
        xk86rYKbCfa3i4RZ+srXyV4gJBB4wfbGJKuo05HVviC/t3KkkDXQX0IKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rwPrbQh27EHg9RIWa6l1v6acfPj+oE8RuCzMCieTED0=; b=TNBErMeE
        QDQOw9oL/FLHGsowkARtEora+4R0m7UvaMEQzjGt61lzcRrNmzqTyjS8NDWMS+B1
        YuJaRHydPF61GCE+4/173FWRWuy/I+02+RjK3ZeXtmMxS7g8S9xY0SZ4DSfUxVKT
        HBn13lUBFsV30kkxrTbULafE3ceZDkI3ZRnPtJt7OsQn+awNDxhce0MuzmZnPvzt
        4S8pazLVgZgUaz45MfHlAS1hJT3LpC1Ev/aYUQvq1dddE38hUiWIzHHvFpOI90qn
        r4fz5lXQwRm2UYEqAj3I1Sub4gcl/iSIspOGOCpFPKDfwu/7eJiJi2dMmThs06ZP
        z2Pk0sAhJH8rFQ==
X-ME-Sender: <xms:tiEFYMwCAm80ASR9fUZmEJuXa4t5dQMzc97M8IxySa87xzpYlfRaFw>
    <xme:tiEFYHtwQEDqMluBZHhXLlHLWZKsgx4uRpzrUBJ5tnqO6icqQT1Nwn5V92HrQ6JA1
    EwQPot5dv5oQuCW2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:tiEFYLtuYND6JlX_xA-uryJ0bGy0b2fznMWQOSb8uwf_4gUNDkVMjw>
    <xmx:tiEFYEOruYNDaM77Ff9PXp3KzCMB-F6jDEAQOyDNqdXIOK3ZOzKo5A>
    <xmx:tiEFYB2ZEUxwg60nU1jyHrkpzfA9-HmlUIDTZFP9nu1bIpgtokklyg>
    <xmx:tiEFYIF9lzllx39NGiRmq855P7sTP7C8E5EItRWR_25F5c21VGExsMp-_no>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC1F324005D;
        Mon, 18 Jan 2021 00:50:45 -0500 (EST)
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
Subject: [PATCH v5 10/10] arm64: dts: allwinner: Move wakeup-capable IRQs to r_intc
Date:   Sun, 17 Jan 2021 23:50:40 -0600
Message-Id: <20210118055040.21910-11-samuel@sholland.org>
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
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 5bf9d61fab12..5b30e6c1fa05 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -648,6 +648,7 @@ ccu: clock@1c20000 {
 		pio: pinctrl@1c20800 {
 			compatible = "allwinner,sun50i-a64-pinctrl";
 			reg = <0x01c20800 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
@@ -818,6 +819,7 @@ lradc: lradc@1c21800 {
 			compatible = "allwinner,sun50i-a64-lradc",
 				     "allwinner,sun8i-a83t-r-lradc";
 			reg = <0x01c21800 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 			status = "disabled";
 		};
@@ -1208,6 +1210,7 @@ rtc: rtc@1f00000 {
 			compatible = "allwinner,sun50i-a64-rtc",
 				     "allwinner,sun8i-h3-rtc";
 			reg = <0x01f00000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 40 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
@@ -1279,6 +1282,7 @@ r_pwm: pwm@1f03800 {
 		r_pio: pinctrl@1f02c00 {
 			compatible = "allwinner,sun50i-a64-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 15babb635cf7..4af06f49daa7 100644
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
@@ -902,6 +903,7 @@ tcon_tv_out_tcon_top: endpoint@1 {
 		rtc: rtc@7000000 {
 			compatible = "allwinner,sun50i-h6-rtc";
 			reg = <0x07000000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
 			clock-output-names = "osc32k", "osc32k-out", "iosc";
@@ -937,6 +939,7 @@ r_intc: interrupt-controller@7021000 {
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h6-r-pinctrl";
 			reg = <0x07022000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
-- 
2.26.2

