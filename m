Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BA12F445B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbhAMGIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:08:11 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:48507 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbhAMGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:08:11 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 043591B94;
        Wed, 13 Jan 2021 01:06:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jan 2021 01:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=Oda4KQahWE9Uh
        MYoMLXF4jmERx7gEcdKJ0UOyDojC+8=; b=feUoPkU3lkUTQlnh9ACSfdVpJwdlR
        Xc7y5IYcBRp2dy9LYEEVDOHsKdmW0F/uzc3R+YLWYJlbB4riXfMPBaz0JOWUMVlW
        3skstspY2PN3QhcVXnMtVJoqIXkJNIvyGylwxxplpSae3y6lQMM1V1uUQwgqD9Cu
        /+UV5N2JYbLYr25gSmTYLn1WMtPJrZVq1BLJmvVrbesx+l42NecBMCSMz4aCNoFa
        AohSQkrQ6zvBZE6vkbj5NF95msk5rXHWRw3c8T//jozYa7KLaQ0qtdumjAvwk9ZX
        G43KpelOS0tV+DV8eH+stMNwxmg/9YNC4dPwH505xN4USUSidVL9YvT9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Oda4KQahWE9UhMYoMLXF4jmERx7gEcdKJ0UOyDojC+8=; b=WT9yw4L1
        Luc0ygtIoRUVsW03y2KU4GK0auAmJ/3PAKifBkP7rdEi+Ft5E/RoBbhgcAdJ1YCB
        52ESEHR8+ktRTzsw77G29IWvspMntXYMWV8eSOMnmgcx/n+E5HT99oHSFVTliu83
        7ioI1VfGwMASFowiT9o2lL1lRDshKVtCd6Vm6eRIncv0UzsTNeWyL1AJ9tt/0qmo
        TcxevckqI3kEZjO2d2oc7xljcTvB+SqfDhfWLE3zcguydaEQ7HgXXRnaaVs4dkHC
        VGrFSv1Sy0Gyr4/MIRAgIbjjxnoyX7HWbaPsyp1X5QWRhS3b2QH9Z+cTOUc5F7r7
        Yutqyw/B84j/8A==
X-ME-Sender: <xms:243-XxcifwsDAGI7KirdliJcGzqB5sKnsmwmykPupoNjmdSIqtOBhw>
    <xme:243-X_NJ7MR7oR3-Y2R4XylCbk-5pJ6tyUpnrnR5LzK9j-c6-o5lGnPoYihOJ9VmF
    ggDemtxEhnWamz_Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:243-X6gmcADM5X3Bw-O5CoYEnBjdhR74gCKn43_Yd7XoRLuhHtMXBg>
    <xmx:243-X6_RPopep0cT7DzfhlVarM8mENMNtNvlKoMDn1FBH5wKfyD0Nw>
    <xmx:243-X9tFupjisH0GQabiKIUjHcExvE5r4JUnU-X_Q-YqsBe4oVxPQg>
    <xmx:243-XzAJlrhvtumR3L-6Wz2sS5mUaA9cDLr3Iw0Znwhvsj3NiUymgPe66qs>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B190324005E;
        Wed, 13 Jan 2021 01:06:18 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 5/7] arm64: dts: allwinner: a64: Allow multiple DAI links
Date:   Wed, 13 Jan 2021 00:06:13 -0600
Message-Id: <20210113060615.53088-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113060615.53088-1-samuel@sholland.org>
References: <20210113060615.53088-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simple-audio-card supports either a single DAI link at the top level, or
subnodes with one or more DAI links. To use the secondary AIFs on the
codec, we need to add additional DAI links to the same sound card, so we
need to use the other binding.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 4bba468d8ec2..fd9a278f014a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -131,12 +131,10 @@ psci {
 	};
 
 	sound: sound {
+		#address-cells = <1>;
+		#size-cells = <0>;
 		compatible = "simple-audio-card";
 		simple-audio-card,name = "sun50i-a64-audio";
-		simple-audio-card,format = "i2s";
-		simple-audio-card,frame-master = <&cpudai>;
-		simple-audio-card,bitclock-master = <&cpudai>;
-		simple-audio-card,mclk-fs = <128>;
 		simple-audio-card,aux-devs = <&codec_analog>;
 		simple-audio-card,routing =
 				"Left DAC", "DACL",
@@ -145,12 +143,19 @@ sound: sound {
 				"ADCR", "Right ADC";
 		status = "disabled";
 
-		cpudai: simple-audio-card,cpu {
-			sound-dai = <&dai>;
-		};
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			frame-master = <&link0_cpu>;
+			bitclock-master = <&link0_cpu>;
+			mclk-fs = <128>;
 
-		link_codec: simple-audio-card,codec {
-			sound-dai = <&codec 0>;
+			link0_cpu: cpu {
+				sound-dai = <&dai>;
+			};
+
+			link0_codec: codec {
+				sound-dai = <&codec 0>;
+			};
 		};
 	};
 
-- 
2.26.2

