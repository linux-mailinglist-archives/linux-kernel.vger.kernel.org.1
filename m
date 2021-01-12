Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0442F282E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391135AbhALGBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:01:52 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59301 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390803AbhALGBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:01:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id BD3C658056D;
        Tue, 12 Jan 2021 00:59:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=mnmbcjyB8pD2d
        0MXqgq3tgrNYPFuBBvPX326wBo9HV8=; b=S4gub/MbeVJx0SuypsAA1Ez8GopcJ
        YC6h3MNwrGXD4HVkD62L1Va7DCamYt42FHYiyWT2n2/oDONqT7xjHD1cXTkrU2iT
        V6gugfwqVeiEGE5PaCSfuWEy11+XFC4fzyCrWjOEK1UYjmReLJxO+2NI5fnv2BXI
        mlDgvK1vXCEEGsTOfaYZHXzxpe+pZCM+FbuAb8+PiQSVsJdv5fLW6yOLeDUi79i3
        9ntTZsWiGYCzm4NlkjThouukecJa0gScZhk/Ttur9lEgtrKrF+TSglB3DSrMxFv1
        p0UAvalCk1QLLuSQuhLhY9zk5VFYlxSbPm1sWL8AF6Q2ffG/8NhoDumSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=mnmbcjyB8pD2d0MXqgq3tgrNYPFuBBvPX326wBo9HV8=; b=AQ3ssDBe
        UxJC/1z5NKKTxaeoIAXXymuH3u1evLujtl8+XPLiB8kw2THM7VUCkH+HjQ/EWoBj
        GF4Va3xHfArUH6psizwmRfR4zPv0Y6t036ozLFroAhvJFfZeu/VU4zQlbGa5gWsV
        DFbz9zrd5FYQ2/7oBtX5msgPFVZtBJ9YpzFNi4Qv5hckjryNOoagsHc0c7ORzW86
        qscspCUf+tdjts/SJnw58T8MK91z5whTKdXU95Hs0a+HdEQpAAhmcWlJkY+TFbzC
        rLVnOzT4b176l2DerRlpeddhjcxA11uAZ5zaAeJIYDOwU7IxT2twQh2ySQj8fQeF
        YhgABOOt7ot+CQ==
X-ME-Sender: <xms:3Dr9XzrsDkajJOgcppkbivMz4VPjyh0hMr9tvc41JlgdR68obU9h8w>
    <xme:3Dr9X9rMBJYMSYp7mcikecPXQXj8tpNnbtdVIehNT6luerdvdKuMquz1A5jlNt-er
    qBFZ9LjDtpXkX9NVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:3Dr9XwNtbwy4K8IFTFpSBemsBm7LOXIY7zSPYdMO7k824smokwSdSA>
    <xmx:3Dr9X26ICcV7NDU0oMqCWTlW2Z0h3vVSXKfFivYFPAojPgahtAkioA>
    <xmx:3Dr9Xy6vTdsNMiE71jk0DWf4jdAxDgNN6uEvg9PRE2Qzrd8HrNtoHg>
    <xmx:3Dr9X0ucL8Tf1o6QE-NqGp_bQRoBzLcZnYnZWwrgBDuUsng6U6AQtA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B2FE24005B;
        Tue, 12 Jan 2021 00:59:56 -0500 (EST)
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
Subject: [PATCH v4 10/10] arm64: dts: allwinner: Move wakeup-capable IRQs to r_intc
Date:   Mon, 11 Jan 2021 23:59:50 -0600
Message-Id: <20210112055950.21209-11-samuel@sholland.org>
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
index 93b8456f3b49..d467fe1bc566 100644
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
@@ -930,6 +932,7 @@ r_intc: interrupt-controller@7021000 {
 		r_pio: pinctrl@7022000 {
 			compatible = "allwinner,sun50i-h6-r-pinctrl";
 			reg = <0x07022000 0x400>;
+			interrupt-parent = <&r_intc>;
 			interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&r_ccu CLK_R_APB1>, <&osc24M>, <&rtc 0>;
-- 
2.26.2

