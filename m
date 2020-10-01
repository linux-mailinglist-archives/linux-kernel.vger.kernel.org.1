Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFBCD27F7CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 04:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731263AbgJACMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 22:12:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42651 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730649AbgJACMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 22:12:00 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id DB4F75803A2;
        Wed, 30 Sep 2020 22:11:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 30 Sep 2020 22:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=TyhQ5BRj7y8vd
        ftfNJvyzVRvICOUfXA5VIqkp1avzp0=; b=iB1rnC/W+etRxlGw5b7Y99mZWO9gi
        oROZmxlFJzOSilnarL2q2qbP1gLKPCSxU97RVudRXf7CGYjLMF2jW56Pg8Z+DeDg
        fyatqZihhY5d7cTrEzII39VP0S8Acdeys5cHkJ+PB3e3T4yxAs/gcf6A5B52qLQl
        9cFnZvlt8fORWFilUn90Sfvfk8/MM8Y3RiLzL8o5AOnVPhLu8sFls70LbMOJ/02H
        piDkoDkaLSm3L0ovj5tuQESKO0Lp0iZgaRXzPYVH/+0zl3ditWPHEe2p3oWuexZm
        oxHGRDtG5SQ9iPhuySXOgVxi9u5ygPs1PdDEyqIBw2Pzudv7gam1E303g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=TyhQ5BRj7y8vdftfNJvyzVRvICOUfXA5VIqkp1avzp0=; b=bir+non1
        1vFEuL/BZIk1bmMXajY33DnpVnnqyZUBJkh9b5dhR1BkjV8HmpXrRNZc0zisfedt
        BQUT8szdJYHng/CHrvDjNLFj3CHYRga64qckmVBvnpltAylJ76d2i8J6HkUnWUJE
        YbFVBu1GInmeRyt90NAKklT2CLeiiYHgBwzZc59Fl9DhCuPPe4GoRfLuKpMkazcD
        RHUaDPkPVgmGhuzXBcPCe5a/a4pE2JeWl4YJyY55Y9tLezxQPIQPsqUzH+QVNBcd
        NxLB0rEVNQWz5ecaU3Nl5XfAkVbP9B0PMCEJ/5MskgCxqN6TBDltFWVIduAruoQZ
        RnyGj8QCGqTTVg==
X-ME-Sender: <xms:7zp1XwRZW1h0JlV6zMAneI-30U77ps9er7Pb1JwT5oVCRMjcr1_05Q>
    <xme:7zp1X9yahIDkXcWiNwj4qCkBua8dexFzmKkTy0DbAkV78HW3A2srMBc-2ZJgV71P_
    0SRYnnZF8JV24Pt2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpedujeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:7zp1X93vx12XtHQBPRzed7UhJ6k6SnSCJ1Zndgq4Nll8UM97z5nNKQ>
    <xmx:7zp1X0AbQZo0xAjtx_xbVzy8QlWpSt9cmnhNRqnl5cHYpu2K0Lk2bg>
    <xmx:7zp1X5jedweE4HfYOK-ZvWRm9r-kNvpj0FYK9KrK5jL1Y6uku1mAYQ>
    <xmx:7zp1X6WJdifjlDp_50siHhHCxUkh76aLTaitqi0N8HPoHOfJkNhPrw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37002306467E;
        Wed, 30 Sep 2020 22:11:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 21/25] ASoC: sun8i-codec: Require an exact BCLK divisor match
Date:   Wed, 30 Sep 2020 21:11:44 -0500
Message-Id: <20201001021148.15852-22-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001021148.15852-1-samuel@sholland.org>
References: <20201001021148.15852-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we guarantee that SYSCLK is running at the optimal rate when
hw_params succeeds, and that it will continue running at that rate,
SYSCLK will always be an integer multiple of BCLK. So we can always
pick the exact divider, not just the closest divider.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 86065bee7cd3..d8ce84533ddb 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -384,35 +384,31 @@ static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
 	{ .div = 32,	.val = 8 },
 	{ .div = 48,	.val = 9 },
 	{ .div = 64,	.val = 10 },
 	{ .div = 96,	.val = 11 },
 	{ .div = 128,	.val = 12 },
 	{ .div = 192,	.val = 13 },
 };
 
-static u8 sun8i_codec_get_bclk_div(unsigned int sysclk_rate,
-				   unsigned int lrck_div_order,
-				   unsigned int sample_rate)
+static int sun8i_codec_get_bclk_div(unsigned int sysclk_rate,
+				    unsigned int lrck_div_order,
+				    unsigned int sample_rate)
 {
 	unsigned int div = sysclk_rate / sample_rate >> lrck_div_order;
-	unsigned int best_val = 0, best_diff = ~0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun8i_codec_bclk_div); i++) {
 		const struct sun8i_codec_clk_div *bdiv = &sun8i_codec_bclk_div[i];
-		unsigned int diff = abs(bdiv->div - div);
 
-		if (diff < best_diff) {
-			best_diff = diff;
-			best_val = bdiv->val;
-		}
+		if (bdiv->div == div)
+			return bdiv->val;
 	}
 
-	return best_val;
+	return -EINVAL;
 }
 
 static int sun8i_codec_get_lrck_div_order(unsigned int slots,
 					  unsigned int slot_width)
 {
 	unsigned int div = slots * slot_width;
 
 	if (div < 16 || div > 256)
@@ -431,18 +427,17 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 				 struct snd_soc_dai *dai)
 {
 	struct sun8i_codec *scodec = snd_soc_dai_get_drvdata(dai);
 	struct sun8i_codec_aif *aif = &scodec->aifs[dai->id];
 	unsigned int sample_rate = params_rate(params);
 	unsigned int slots = aif->slots ?: params_channels(params);
 	unsigned int slot_width = aif->slot_width ?: params_width(params);
 	unsigned int sysclk_rate = sun8i_codec_get_sysclk_rate(sample_rate);
-	int lrck_div_order, ret, word_size;
-	u8 bclk_div;
+	int bclk_div, lrck_div_order, ret, word_size;
 
 	/* word size */
 	switch (params_width(params)) {
 	case 8:
 		word_size = 0x0;
 		break;
 	case 16:
 		word_size = 0x1;
@@ -467,16 +462,19 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 		return lrck_div_order;
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
 			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
 	/* BCLK divider (SYSCLK/BCLK ratio) */
 	bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
+	if (bclk_div < 0)
+		return bclk_div;
+
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
 			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
 
 	/* SYSCLK rate */
 	if (aif->open_streams) {
 		ret = clk_set_rate(scodec->clk_module, sysclk_rate);
 		if (ret < 0)
-- 
2.26.2

