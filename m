Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0D552F445D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhAMGIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:08:12 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:33213 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725912AbhAMGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:08:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 1318E1B99;
        Wed, 13 Jan 2021 01:06:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jan 2021 01:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=9cip7s1aFbMII
        yrk+2/l9sW3AVhWwueouG9RqkcinmI=; b=KeGNzJda1CU72Iy7QVydjqLvHebj9
        WFBl1fjCeI7lykworSTVFxE9n48qpKxQrX/3xjiP2s3c68lnvatFekmdpOHOB7Eb
        8NM7m3JhUItS4Ixv4mM4cL1UyHs4/AAp1gwhCm6S+bU3+xjr1ueALVvBF4JgTcWL
        yCJiY1Wf4HRo05wHWaFHO8AsrTC5W3FQYzcddl462EnbdSw00l6GHTwOH8J/sX9f
        k69ML16V1YqgYcp8Hx5kqKwEPiKWvzuHp10fofooqLXWjXMxG6jNyUYAfR5h8jKa
        gKRwcWc1k4hbFdgO/r4xM/FJXMjsFOoao4xQZ6+KHWEfbkZyuT6RgaYZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=9cip7s1aFbMIIyrk+2/l9sW3AVhWwueouG9RqkcinmI=; b=I+ll3Ibh
        RCxEFTUvQfGHqzRzp1HJEck4tXwh3VUAOyRtPxhkQUNchXdufYxHLFMtR3kHIey+
        4wCzNrFW5UFr/ThHjbKlbA8up8qNWwbH6ZnfKCcgybz4kaeFG6PCfzmCrwhuUCgD
        OggQxUCVXozjjJq3hqrgBZw/nFiFMadWxMrp6eOgc37HFwWJ3WBbIpq5iQsr3RkG
        UtLn82W9UE6k7gExrSgtFLnSu0R0lBIm0rG2cJIH/8xmNXi4LRp22l9g4BKUVMA/
        RDjuoZ2KXT5Es2Wi6H8/cwVRmyI5L6C+C+N9vQ4C6ysR0NqeVncLflRkqvQIeoHc
        243mCw2CRdRcDg==
X-ME-Sender: <xms:243-X8P1x61UUIsaiJxntKkZ24mO6DgWxTXFJYxoRJGYPWjOgLWwhg>
    <xme:243-X6bNhgD_P9W_TEegU5Q4LRx_HBM2VUMcYQ7zQdODJPRNGD5CQ5q_1Bm4y9tBP
    BvXJ7nlPwfpj5NNVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:243-Xwq8rhOLnrnnQq69hOm6Ti5KBNwBZbU6NDkWLorlXDT_Wcrdgw>
    <xmx:243-X-aPWUzPbBnXOZaYO18j7kb4Ro2EVCdDwcaDs_cgC8n-35ipyA>
    <xmx:243-X4Rk1H-b7drw5mSCV9FjZU8TTK_WJ_o8CAOMq35BjsY15XFdfg>
    <xmx:243-X5C835T3mNqguixxiC6Yznd1z0ma-wWVOUhfSl7Z4sQsrY-LOT6qays>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2DAA7240065;
        Wed, 13 Jan 2021 01:06:19 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 6/7] arm64: dts: allwinner: pinephone: Add support for Bluetooth audio
Date:   Wed, 13 Jan 2021 00:06:14 -0600
Message-Id: <20210113060615.53088-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113060615.53088-1-samuel@sholland.org>
References: <20210113060615.53088-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PinePhone has a Bluetooth chip with its PCM interface connected to
AIF3. Add the DAI link so headeset audio can be routed in hardware.

Even though the link is 16 bit PCM, configuring the link a 32-bit slot
is required for compatibility with AIF2, which also uses a 32-bit slot,
and which shares clock dividers with AIF3. Using equal clock frequencies
allows the modem and headset to be used at the same time.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 2dfe9bae8c67..e0db2f1373bc 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -24,6 +24,11 @@ backlight: backlight {
 		/* Backlight configuration differs per PinePhone revision. */
 	};
 
+	bt_sco_codec: bt-sco-codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
@@ -82,6 +87,8 @@ vibrator {
 };
 
 &codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&aif3_pins>;
 	status = "okay";
 };
 
@@ -439,6 +446,23 @@ &sound {
 			"MIC1", "Internal Microphone",
 			"Headset Microphone", "HBIAS",
 			"MIC2", "Headset Microphone";
+
+	simple-audio-card,dai-link@2 {
+		format = "dsp_a";
+		frame-master = <&link2_codec>;
+		bitclock-master = <&link2_codec>;
+		bitclock-inversion;
+
+		link2_cpu: cpu {
+			sound-dai = <&bt_sco_codec 0>;
+		};
+
+		link2_codec: codec {
+			sound-dai = <&codec 2>;
+			dai-tdm-slot-num = <1>;
+			dai-tdm-slot-width = <32>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.26.2

