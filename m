Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1347D27F7C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730736AbgJACMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:12:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:56857 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730233AbgJACL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:11:57 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id C948C580325;
        Wed, 30 Sep 2020 22:11:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=NSmhqV0mmdPNs
        m8wsirGm6E7M0NDVR5Is3lE3Iwkiks=; b=mPaarXF8nE3/c5b4a4ZlpbeBiCHYA
        MGvoS3kmSrPM23eq3Qc2uXTYODFttE0xuX9YfOrUjCLPUf1Bb9dXzGCPks87HlDI
        vVokQUrTnpQUmL1ax27ENxq0lePnCx/celdadlyo9Ucwlaz2GqvHCB8MnMZ1kEPm
        FFeR6ZJ8Y2zZnnld7O72OZKQa865LmTuvWaFHCXXAMGoJQj+mr3IOW6jqtJARCgc
        5kmETlBw2VAMVbI3UET4cwtYZkrUlMJHE05owSaZfP5mssSqiCrcCnC13GJHyhhx
        TfmSndem2WLOVD/AGTCwDXgxztXJd8uv2PUlruoKeaqla5b69jgeQRPZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=NSmhqV0mmdPNsm8wsirGm6E7M0NDVR5Is3lE3Iwkiks=; b=JJzqrXNX
        E+sOpyWwQvdM2rCzzbBJZBsHxp5Ed6IkRwZ52C8U7mvdgSChVEdZvWEYxEk7iyNs
        zZnU65lLXyvz0w+cS6jU+qgdj+FWXddvol8ejiYQ91mQC24PeBWWWF80Zdl+sQQO
        wLuo5su//BtXMUVb915O9Ewa1qLpqjiSrF1Biz3+eipUc+08Vog6siUdlmUoCo3O
        dJ+C6BIfjjY/URHu5TqSAIFm3Wly9tjvsIlZrrakMJsCu4biu4eWMlIyHeOOuzRw
        S54y+vbc4b8jbFB3DD3AEoM9OKu7m3fTrdM9YpGFDU451kLckgtxFVqbMNWQ/eGy
        y1PxF0MVWBAlSA==
X-ME-Sender: <xms:6Tp1X8JMpKPc64Vd7mHI_LF35nI72T66J44at7gvHOD6SlMhrEj8AA>
    <xme:6Tp1X8IWuZBWkUKi-saVWNfHbKKHXcv4KvOLOUspsXXlnmTx7DKfIPWQkP6XJA2qJ
    FrTzs6w-iHBCtIr9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:6Tp1X8tUeRelrf7E5mmhF8CpilM2mnBCVtNlVHrXQnslBjv8OXDo1Q>
    <xmx:6Tp1X5bo3nof-8x23NF0rSFuqPEZJXF0wxMXD9wj7yHqX1BVYGgIwg>
    <xmx:6Tp1XzaQa1BTCwBG-4vJ504eadw7iGC8JOUnsMRTueiuHeXuEvY1lA>
    <xmx:6Tp1XxMGI6xRE7cmx2VsdWhvC66Z7YLdcbzDLA2t4cXt1PY2TljdAw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ADA03064682;
        Wed, 30 Sep 2020 22:11:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 08/25] ASoC: sun8i-codec: Use snd_soc_dai_get_drvdata
Date:   Wed, 30 Sep 2020 21:11:31 -0500
Message-Id: <20201001021148.15852-9-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove a level of indirection by getting the device directly from the
passed-in struct snd_soc_dai, instead of going through its component.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 578c0c0e6330..7590c4b04d14 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -162,17 +162,17 @@ static int sun8i_codec_get_hw_rate(struct snd_pcm_hw_params *params)
 		return 0xa;
 	default:
 		return -EINVAL;
 	}
 }
 
 static int sun8i_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
+	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	u32 value;
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS: /* Codec slave, DAI master */
 		value = 0x1;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM: /* Codec Master, DAI slave */
@@ -294,17 +294,17 @@ static int sun8i_codec_get_lrck_div(unsigned int channels,
 
 	return ilog2(div) - 4;
 }
 
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
-	struct sun8i_codec *scodec = snd_soc_component_get_drvdata(dai->component);
+	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	int sample_rate, lrck_div;
 	u8 bclk_div;
 
 	/*
 	 * The CPU DAI handles only a sample of 16 bits. Configure the
 	 * codec to handle this type of sample resolution.
 	 */
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-- 
2.26.2

