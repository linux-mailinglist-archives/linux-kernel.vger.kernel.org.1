Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFC32F4458
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 07:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbhAMGHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:07:52 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:40777 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726475AbhAMGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:07:51 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id B880C1BA2;
        Wed, 13 Jan 2021 01:06:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 13 Jan 2021 01:06:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=UPQKNjnKYcvfU
        tSZvIh/RoQ33u+HBfkHdg3flk5F7LY=; b=SMRDqMvKCVIy4jszgS4R1HlPRE0OT
        Fzlz2h8sxqaKOK1LpQWuOZ4NboE3mJls4tX3sNkDRdBWxP6wqTWHMl+2sZ6aytEG
        pnbVSnCQp+W32sfhaYk2G5Vbl/gLnPET0VrS7nU3cfsn1q5yVo6QajhGA5Vc2ZbX
        d6lqRxA8Pf/CaiheBgC6v7z9IMFIeb8b+6jKatQmNKO008AG4c5XxHtgza5m2ewS
        GcJVFplwRqUhq37p5unTiHyP3N6c0jEwQsLiMGJmBVgxeZRCybNGIj2nXECP4mwn
        gOEwH6rsgjs2Ug5EoisfJwGci0GycZKg1pdDNB/2jTNFU35egtdA1d/QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=UPQKNjnKYcvfUtSZvIh/RoQ33u+HBfkHdg3flk5F7LY=; b=PUU9cBF1
        NNRl+/gI/l93aeZyLxj7VFAMpED/I7dOjsgTlHVt58QEbRUj16f+Zpqxl4L68Zi4
        wpJ9TIPcirTqPVwX1ZyjTlD0GeWWgmwX5eqvbuhOy8AJKD/aVB6FeJ4MdtNYtkEs
        MgnPquIXvwriv015F78vQhwzOyk42ndNFwcP7wecXedesFEbtT65KUULipGPmu6S
        FwnfweHC/+PaGs3+87gA/XZs66GZQ+aD3sB9kofcOV3iEo5f8pn2+0tf/pO3ilKc
        /j5PTYbV3zrni/8zcX0pRZev3MPWbZB2HiNSmbc8Q48XHizkXhSQjCSO/T1idHk2
        vrvkuLEG4zOUWQ==
X-ME-Sender: <xms:3I3-X3aB6zCisi8S5XNfl057I5kVIRK68MFVi_N6ehkvBa_d3BRmBw>
    <xme:3I3-X90aMMlQ19UoXCQEvqVKAjR1mQu3cvZ01zvDp0JodPn1mBkj_mXoCipe-a8pg
    tMZgovrSXlA2nYN9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddugdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:3I3-X3UG2H-vQe5x2U4v0tLwdfXv4nJD3GSgDDGwXJXKGAb6lfdxMg>
    <xmx:3I3-X3Vhbtd-fpHgFsIgBAjuCX00sk1jxBHpsgReVwj7Ux4e5DTRIQ>
    <xmx:3I3-X2cYzJ21o6FI2wi0u2ijcjYPXECAWYk_y2ApV0hIeH5gq6QnBw>
    <xmx:3I3-XwI-liGhNtt2JLvLIrp06tzBf5YVyUy1B9yahw7NEySNxW45BL-Eh5I>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id A00DA240057;
        Wed, 13 Jan 2021 01:06:19 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 7/7] arm64: dts: allwinner: pinephone: Set audio card name
Date:   Wed, 13 Jan 2021 00:06:15 -0600
Message-Id: <20210113060615.53088-8-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210113060615.53088-1-samuel@sholland.org>
References: <20210113060615.53088-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

Add the "PinePhone" name to the sound card: this will make
upstreaming an ALSA UCM config easier as we can use a unique name.

It also avoids an issue where the default card name is truncated.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
[Samuel: Split out change, updated commit message]
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index e0db2f1373bc..cf6dcdd135b5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -425,6 +425,7 @@ &reg_rtc_ldo {
 
 &sound {
 	status = "okay";
+	simple-audio-card,name = "PinePhone";
 	simple-audio-card,aux-devs = <&codec_analog>, <&speaker_amp>;
 	simple-audio-card,widgets = "Microphone", "Headset Microphone",
 				    "Microphone", "Internal Microphone",
-- 
2.26.2

