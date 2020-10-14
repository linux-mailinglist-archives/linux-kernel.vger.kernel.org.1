Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A921728D9DA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbgJNGTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:19:49 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:58269 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730376AbgJNGTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:19:47 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id C6C53250;
        Wed, 14 Oct 2020 02:19:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=dsTqx9fih4qel
        tXgxFFCvDgkr4kxr99tOm8ZaqRJzWc=; b=mCFBuHL278LSXO6A/i6hUVHQSKYiV
        FxOko4paSAlNY5koWEDynyCPPDya3xmctHBNonlMn7cGv8xPSDlQjl1pechlbRyn
        /1V8GK/+kk7f33nD1rcVmNBIJxb12PovXyvEZhFc/iiiQg6Zg13A1bH8GghagMsM
        9bAiXGvQjoDRgKTHHjf7AXz0uR2Anr86gMKbLQhE65Q+5NqU+5QhP/gccHh/xkFm
        oAyz6N+aOh+BG58mI1Q1b0T3g3+IRKH1CAfRxF5kQsCeXaPyM/Qua0vCMk5aRV26
        zjxlyGy3QcMnKapANr9sYAgQcH4GD4uSm5CnLKWc8CTCqyue0S4ic0CCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=dsTqx9fih4qeltXgxFFCvDgkr4kxr99tOm8ZaqRJzWc=; b=K6HfyKo0
        THYsGFONlE8rWh/c0WxceKK2xBA8qZlMRY6QDuiFz8+AgUatZYx++PyfUkwEP0hJ
        pFJpBqI3+5YclgkSjJfCCuIM5O1cNTEOnEWpDYUtVE5V2sygtBhZ4MAM1yJf24dS
        u+nJzaVKpg493hsv0WibHty5t4Wk2TVbdYwkyYBX61lELwqR+G16yqzJuPpxWU9a
        0/Amyxx6I++qi+UZjL6+nXh3hKdBZTV35/E3zGeeQ1mHu61RrL1Wa+OloLfbnfcs
        finy4WVpq6x+9zQC3iUR97TrfTgdi6iOv52SmJ8DmPKSeMTavlDjOxGASsCgLIUd
        CvSLenkNFFaHGg==
X-ME-Sender: <xms:gZiGXyzwYYjpPOcTo5VzpOgYkXlWGgU89XHMSittPl_hzdchBC3n-g>
    <xme:gZiGX-TmAOgO8lKY5E71dFxXR-u2KnmYgAjg1LLAnSd2GzffCQz8ooRh3mqMDs0eV
    P57m428CEC7ioHIOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:gZiGX0V_YyGErE94WOhp7H_TAhL1O5hLjqdGQCT6EwVAhNzorC_fkw>
    <xmx:gZiGX4iaNAoCTAJzeTVB3gJ3DOBh1wRWw3FB6D-Vt7vYwgg2K7wUOQ>
    <xmx:gZiGX0DA3zxiQsJTBESeBV0uu14wnPCRBSLQR_oU2TngSEj2SuyCcw>
    <xmx:gZiGXw3DNAR14v1TqlO3ZU6hRR-8ddugs5MJlBHBMl7BQnV_tyATVjDcnzE>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id ACAFB3280067;
        Wed, 14 Oct 2020 02:19:44 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 06/17] ASoC: sun8i-codec: Correct the BCLK divisor calculation
Date:   Wed, 14 Oct 2020 01:19:30 -0500
Message-Id: <20201014061941.4306-7-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014061941.4306-1-samuel@sholland.org>
References: <20201014061941.4306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the BCLK divisor calculation assumed zero padding and
exactly two slots. In order to support the TDM slot binding and
20/24-bit word sizes, those assumptions must be removed.

Due to hardware limitations, the BCLK/LRCK ratio is not as simple as
"slot_width * slots". However, the correct value is already calculated
elsewhere in this function, since it must also be programmed into the
hardware. Reuse that value to calculate the correct SYSCLK/BCLK divisor.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 92fcef45097d..ae885774c877 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -279,21 +279,21 @@ static const struct sun8i_codec_clk_div sun8i_codec_bclk_div[] = {
 	{ .div = 48,	.val = 9 },
 	{ .div = 64,	.val = 10 },
 	{ .div = 96,	.val = 11 },
 	{ .div = 128,	.val = 12 },
 	{ .div = 192,	.val = 13 },
 };
 
 static u8 sun8i_codec_get_bclk_div(struct sun8i_codec *scodec,
-				   unsigned int rate,
-				   unsigned int word_size)
+				   unsigned int lrck_div_order,
+				   unsigned int sample_rate)
 {
 	unsigned long clk_rate = clk_get_rate(scodec->clk_module);
-	unsigned int div = clk_rate / rate / word_size / 2;
+	unsigned int div = clk_rate / sample_rate >> lrck_div_order;
 	unsigned int best_val = 0, best_diff = ~0;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(sun8i_codec_bclk_div); i++) {
 		const struct sun8i_codec_clk_div *bdiv = &sun8i_codec_bclk_div[i];
 		unsigned int diff = abs(bdiv->div - div);
 
 		if (diff < best_diff) {
@@ -343,30 +343,31 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 	default:
 		return -EINVAL;
 	}
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
 			   word_size << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ);
 
-	bclk_div = sun8i_codec_get_bclk_div(scodec, params_rate(params), 16);
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
-			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
-
 	/* LRCK divider (BCLK/LRCK ratio) */
 	lrck_div_order = sun8i_codec_get_lrck_div_order(slots, slot_width);
 	if (lrck_div_order < 0)
 		return lrck_div_order;
 
 	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
 			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
 			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
 
+	/* BCLK divider (SYSCLK/BCLK ratio) */
+	bclk_div = sun8i_codec_get_bclk_div(scodec, lrck_div_order, params_rate(params));
+	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
+			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
+			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
+
 	sample_rate = sun8i_codec_get_hw_rate(params);
 	if (sample_rate < 0)
 		return sample_rate;
 
 	regmap_update_bits(scodec->regmap, SUN8I_SYS_SR_CTRL,
 			   SUN8I_SYS_SR_CTRL_AIF1_FS_MASK,
 			   sample_rate << SUN8I_SYS_SR_CTRL_AIF1_FS);
 
-- 
2.26.2

