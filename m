Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3E72A8E28
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 05:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgKFEP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 23:15:26 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:52855 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgKFEPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 23:15:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6AD6658054F;
        Thu,  5 Nov 2020 23:15:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 23:15:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=FLNKgMQp1sEij
        kf7PisxaNL+a7J3S3rke3nEpFDnkfY=; b=JOSd5y5TbhDmbIit1LNIQMorGbdZJ
        qilSynMCvH2up6KQBfUabRULaa09UveIlGJ05BMEuzNb00X+I1oAnY8e6QCJBxoR
        D4d+cIOb4jC/3kiOMo2nBLHsLFDac351zpxdF82svhdsthdZiUGv4RCYUVAH5+pc
        rasSwalDyniIfqAcnTayx9uPkO12oz3KyiXKWaZy2lTPscGj5txNGC+XrxXArs61
        u+12yV223f8SPNFVr8HTD2Z6jI4up/P7DOP/koNcdefcXx1fpAyPIUhl4d72EYnR
        iHmmNfKzdjJ9yXHA2nymov53cPv7m0GY0s4J/mH5ghQ4XlvjR6tpLkozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=FLNKgMQp1sEijkf7PisxaNL+a7J3S3rke3nEpFDnkfY=; b=jVX6tJHi
        J9FRcScOzES4WTtJtDOgrC3mnEkTgrevRFLJt6O/YDQcNbukmubdguSX4BAgE0ry
        YOjTcr9RuPjK/NAcokIQgowATDOVEomD4Ox8B2smJsmJfKc+Xb3eDNaOWVQmrQgz
        XBb5JGAtUQ4y/mkXSbJNhAXOrAvx2aikVbNCMigxNtGTWkHHe20ytVZaTqjnYEFg
        0bun2cFA7w3vf8vjVNx59hlAHIIjXKHXPCujSRjUznk++whCm0wFH0cCv7Vy8N+D
        u+wNhRBJ6sbY8GbEDeGMUR6biB6ykyFQouUI4FbLCG7OS654x8l5ktygQ4fxLcnn
        dRCE6o2mYZyqMQ==
X-ME-Sender: <xms:1c2kX3QAhGxujIYZu-3pCE680fW0yeZQkPTSRt3lOToX4OFAyoBDAw>
    <xme:1c2kX4yFghdmoYZoqFp4v34iKj-lagtRZVaYiF48eVQP3jD_QgWgyhH4EbB0B_EPd
    riG0tvd1dgPmeKxQg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtkedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:1c2kX838_sJPG7y2X_7HnuBcRQ5qjKz7g0-q20EYPUuu3dgSKpnDIw>
    <xmx:1c2kX3A9kTUmsJxRMTf8Swk0waxBP4NDumha2nCDLsL13jET_8cRng>
    <xmx:1c2kXwiNjUtfpkOjPmfIX9nfyfENq9mI7n11lTie8DDJIuRzx4pdBA>
    <xmx:1c2kXzOaMLAOW6Xm4J_UxpSMdjVky2-TfHGpCV-atnV-mQnF2EL39A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9F8EA3060057;
        Thu,  5 Nov 2020 23:15:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, Samuel Holland <samuel@sholland.org>
Subject: [PATCH 6/7] arm64: dts: allwinner: pinephone: Add support for Bluetooth audio
Date:   Thu,  5 Nov 2020 22:15:12 -0600
Message-Id: <20201106041513.38481-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201106041513.38481-1-samuel@sholland.org>
References: <20201106041513.38481-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PinePhone has a Bluetooth chip with its PCM interface connected to
AIF3. Add the DAI link so headeset audio can be routed in hardware.

Even though the link is mono, configuring the link for 2 slots is
required for compatibility with AIF2, which also uses 2 slots, and
which shares clock dividers with AIF3. Using equal clock frequencies
allows the modem and headset to be used at the same time.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 5780713b0dba..6125910d29db 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -23,6 +23,11 @@ backlight: backlight {
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
@@ -63,6 +68,8 @@ vibrator {
 };
 
 &codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&aif3_pins>;
 	status = "okay";
 };
 
@@ -400,6 +407,23 @@ &sound {
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
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+	};
 };
 
 &uart0 {
-- 
2.26.2

