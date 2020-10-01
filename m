Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A21727F7CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgJACMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:12:38 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42357 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgJACMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:12:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D87D58039C;
        Wed, 30 Sep 2020 22:11:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=5k3SUOehEkVJQ
        tme0JHjR/CoY8DUxDwQgt0QBEnrJQw=; b=m+EWPEymCYukaw/YH6/fa6Ffs5Gae
        KHLwVePL9K9RBfOcaCUHqiiihvHZ60VhBCrY4oOUct35r7UzL1fONlZT0wziLvfd
        fAVo5jo/TKQB/wwWVOjzlbVFB5/SNiHDrqBIktOEWOWSn6EpmvUfMByAg9fBub93
        nzwgqSDhQjr1ocUWjsxeVKfw5VhBpjsrgzWO8pwmtT1d2Z9ii0fIYtA4Wdt/bZo6
        snywUNuxPKRefRP1QFYpngcACu2hURIyhEzAFPk+D/+vILfjYXFeN2LkjrvLQ4dv
        fkbk9W+UqIkrqnUxyUzrXbp7TmcSAk29SyBAc7csGJhC5vBEk4egamoig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=5k3SUOehEkVJQtme0JHjR/CoY8DUxDwQgt0QBEnrJQw=; b=XH5liIg8
        wIeQWOHVlvXLpxoO7r5jYwLF3XOae/fYZKmpTWKN11y8VlSQlCoRaQATl/9TorjQ
        vps65xqznWuj1FVUU9SJlkU4WLmidTVQ+YEGLlhfzmoYzR7O6SPRPIrTRtnYQIZs
        oKG5/FWqI+ZCI4sSBo0njDG2ztLg180aqBWabOKByV9MQSUUcjoDKpSQCORv776X
        uyDxJsw+EHb/TKMStua3Dpst3htBF2P5h1kOJ0mDDL1JVaH59gZx639redJi8ZLJ
        jwqVxEz2JBQ2FL0bmjxmYptNL9e0Ko4YlND3Sv3zSMjhkHbZIKDZA2SW9+iE+nR4
        MRrhBYBwJxCKWw==
X-ME-Sender: <xms:7zp1XzMa4L1aLGyvrxUpQphKPiBxj0lH1niX5JzZaLwttMdSc_rhgg>
    <xme:7zp1X98V79j-dtjoLabL3XPnDnOQbNv_9p-IaFT-76Yvib-GzboLlIt2de9878upz
    9zFUZzzcl0jCNLsMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedujeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:7zp1XyQCZ64VAgujoTU-4Qh1ZTW77olzed-es9aFIuZfrdQjI3n_GA>
    <xmx:7zp1X3ut20MJjrYkWwZ_PgZ3vNX2WOgEdpWXM9C6Kxo1KI31N29v2g>
    <xmx:7zp1X7cjDRbP-GE58ekSEW4dTvt2qUq8gyZ2cEgEj_WrhoccRRVSUg>
    <xmx:7zp1X6y7KsbUs_0ISYQZCxK7lOuik88RJ1jWlkU6IWoWmSZAWdvfzw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B93043064682;
        Wed, 30 Sep 2020 22:11:58 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 20/25] ASoC: sun8i-codec: Protect the clock rate while streams are open
Date:   Wed, 30 Sep 2020 21:11:43 -0500
Message-Id: <20201001021148.15852-21-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The codec's clock input is shared among all AIFs, and shared with other
audio-related hardware in the SoC, including I2S and SPDIF controllers.
To ensure sample rates selected by userspace or by codec2codec DAI links
are maintained, the clock rate must be protected while it is in use.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 501af64d43a0..86065bee7cd3 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -416,27 +416,32 @@ static int sun8i_codec_get_lrck_div_order(unsigned int slots,
 	unsigned int div = slots * slot_width;
 
 	if (div < 16 || div > 256)
 		return -EINVAL;
 
 	return order_base_2(div);
 }
 
+static unsigned int sun8i_codec_get_sysclk_rate(unsigned int sample_rate)
+{
+	return sample_rate % 4000 ? 22579200 : 24576000;
+}
+
 static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_pcm_hw_params *params,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
 	unsigned int sample_rate = params_rate(params);
 	unsigned int slots = aif->slots ?: params_channels(params);
 	unsigned int slot_width = aif->slot_width ?: params_width(params);
-	unsigned int sysclk_rate = clk_get_rate(scodec->clk_module);
-	int lrck_div_order, word_size;
+	unsigned int sysclk_rate = sun8i_codec_get_sysclk_rate(sample_rate);
+	int lrck_div_order, ret, word_size;
 	u8 bclk_div;
 
 	/* word size */
 	switch (params_width(params)) {
 	case 8:
 		word_size = 0x0;
 		break;
 	case 16:
@@ -466,17 +471,30 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
 	/* BCLK divider (SYSCLK/BCLK ratio) */
 	bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
-	if (!aif->open_streams) {
+	/* SYSCLK rate */
+	if (aif->open_streams) {
+		ret = clk_set_rate(scodec->clk_module, sysclk_rate);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = clk_set_rate_exclusive(scodec->clk_module, sysclk_rate);
+		if (ret == -EBUSY)
+			dev_err(dai->dev, "%s: clock is busy! Sample rate %u Hz "
+				"conflicts with other audio streams.\n",
+				dai->name, sample_rate);
+		if (ret < 0)
+			return ret;
+
 		scodec->sysclk_rate = sysclk_rate;
 		scodec->sysclk_refcnt++;
 	}
 
 	aif->sample_rate = sample_rate;
 	aif->open_streams |= BIT(substream->stream);
 
 	return sun8i_codec_update_sample_rate(scodec);
@@ -487,16 +505,17 @@ static int sun8i_codec_hw_free(struct snd_pcm_substream *substream,
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
 
 	if (aif->open_streams != BIT(substream->stream))
 		goto done;
 
 	scodec->sysclk_refcnt--;
+	clk_rate_exclusive_put(scodec->clk_module);
 
 	aif->sample_rate = 0;
 
 done:
 	aif->open_streams &= ~BIT(substream->stream);
 	return 0;
 }
 
-- 
2.26.2

