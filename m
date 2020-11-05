Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1F2A7724
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgKEFlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:44 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:36499 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730948AbgKEFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F2C035C015B;
        Thu,  5 Nov 2020 00:41:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=jkrVH4j2GkC3P
        3IVwiaih9w84EK5SRrgiFWIljFK7tI=; b=RYCENO/XOI4Q+sFtnwc6lfCMxNl0m
        pkKrWCgSTXnNMQnfLwF6ow8+SAhpWGeW7Drhgvyy/RAvYRjuIrp59VCKHGg6Yxak
        qmMRToEMRBVQg2NZJv1N9U/DCmGTxok9B/ochYAM47f+wj3scfaX5KRwmOZHZWXy
        mvA3TX4WVAfn3kp28lfosuSx7MYUAH5ETJ6BUApleVfd3uisWC/PtpINLCnKgdIN
        QVqGZNNbR9tH+FV5/zTxs/No+3npLXeNVmocTEmG8RGE6JJpaT5mIXtkVC4nHv/M
        0Z2u00gjNzWsrYxWaZmJLX06zu8O6dkSXxHSlz3wEGO9UYyeMZqMGfNPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=jkrVH4j2GkC3P3IVwiaih9w84EK5SRrgiFWIljFK7tI=; b=WTaGYgil
        9IuZds093SZ5P6gPC3582n1YZL+es2kb4IFZFk+bDYj8DTe+prTbiGnMaM5YUOxH
        TIv7yRmPp5mSCPXADn54ZrE3xU8ZYqi07MfTnfu1lXBNExiw+bEhosdCBRWntVa7
        FHkXfqah8J2IT0NUodW9Xj5FEIEl9cedeReBztSoMiZuwqDR9FArC5yLgP1LP3+f
        nB7/dPP5N+H8+sqjX57/g21o6OiSSU8g+/6OjCQZID+xAKeL7xrs0QCvdQBA4kYB
        zxWyAt6Id8bhWmpkncNWm2NJCDl8ePCRc3n1lZdD2AiuyL2q4MV0ILLsIDyzbxCu
        0ap/Wv35tJvRSQ==
X-ME-Sender: <xms:kZCjX4R40DKrCAdOCKy7M0qRkDZs2n8u4M5dZ3ysRhwZt0iT8AKJgg>
    <xme:kZCjX1wEsMjDi0vlqVVow6m7HCQ4sAc4rYV_eKaPmy8jpbxSltvbQx3POMVwWyXrg
    Z8GdLGNp6mT10ij2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpefhvffufffkofgjfhgggfestdekredtredt
    tdenucfhrhhomhepufgrmhhuvghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholh
    hlrghnugdrohhrgheqnecuggftrfgrthhtvghrnhepudfhjeefvdfhgfefheetgffhieei
    gfefhefgvddvveefgeejheejvdfgjeehueeinecukfhppeejtddrudefhedrudegkedrud
    ehudenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehs
    rghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:kZCjX13bDFsa7JDAjPazUXg7KL3qOi72MCYhG3gnApadmjNafSQZwg>
    <xmx:kZCjX8BgLnZQCD_N354cBQB-fjY-r_TS72Zl9flerUnya8EhoxJ30w>
    <xmx:kZCjXxh27-n2F6Rz_y1JXC3jJa74ookW9wpSR_ljfI8zqC8pd4lSxQ>
    <xmx:kZCjX5hd08BZ5MqGU9AWzJRcGe6zMg8F-mv34V0Y3yGykMJmoFWakA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3AE4732801D7;
        Thu,  5 Nov 2020 00:41:37 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: [PATCH 3/6] arm64: dts: allwinner: pinephone: Add LED flash
Date:   Wed,  4 Nov 2020 23:41:32 -0600
Message-Id: <20201105054135.24860-4-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

All revisions of the PinePhone have an SGM3140 LED flash. The gpios were
swapped on v1.0 of the board, but this was fixed in later revisions.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts   |  5 +++++
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts   |  5 +++++
 .../boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts   |  5 +++++
 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi      | 11 +++++++++++
 4 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
index 0c42272106af..3d5a2ae9aa39 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.0.dts
@@ -9,3 +9,8 @@ / {
 	model = "Pine64 PinePhone Developer Batch (1.0)";
 	compatible = "pine64,pinephone-1.0", "allwinner,sun50i-a64";
 };
+
+&sgm3140 {
+	enable-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+	flash-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
index 3e99a87e9ce5..c9b9f6e9ee8c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.1.dts
@@ -28,3 +28,8 @@ &backlight {
 	num-interpolated-steps = <50>;
 	default-brightness-level = <400>;
 };
+
+&sgm3140 {
+	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
index a9f5b670c9b8..94e4f11e0215 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
@@ -38,3 +38,8 @@ &lis3mdl {
 	interrupt-parent = <&pio>;
 	interrupts = <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
 };
+
+&sgm3140 {
+	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
+	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
+};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 57c89c3b71e9..e595a8262920 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -49,6 +49,17 @@ red {
 		};
 	};
 
+	sgm3140: led-controller {
+		compatible = "sgmicro,sgm3140";
+		vin-supply = <&reg_dcdc1>;
+
+		sgm3140_flash: led {
+			function = LED_FUNCTION_FLASH;
+			color = <LED_COLOR_ID_WHITE>;
+			flash-max-timeout-us = <250000>;
+		};
+	};
+
 	speaker_amp: audio-amplifier {
 		compatible = "simple-audio-amplifier";
 		enable-gpios = <&pio 2 7 GPIO_ACTIVE_HIGH>; /* PC7 */
-- 
2.26.2

