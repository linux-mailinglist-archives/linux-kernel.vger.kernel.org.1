Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF682716A7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgITSIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgITSIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:06 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7365C0613CE;
        Sun, 20 Sep 2020 11:08:05 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id b79so10320166wmb.4;
        Sun, 20 Sep 2020 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mvOVEVisAiVz66CKj1JUb8Hz2XWf05WJOgRYC/cB1C4=;
        b=RZscO4VK0CSCUvU7ZtmU+Fgk3hC4mlmAfVvxdxinIjSomoNhjnOvLZ6/FuNpv8ewdc
         7kET+0CeXpJmTIj10cNSRk/e6hZW9NOLHdwcLMBGGr82ZOy4skPg3VEyDO3vHS4P3MRr
         dQyuMkhoRFJcdsRIWOCGoh2gBpk54FPVjDILsx86DmBZdorWOpatY+f2M1cZrG9oNjCh
         IUeWUsqDYxbhhAgvGQg5+05Xlr6u31JDGdR9N5PKpq4KfXbHkbjQHxQTxVRHmOU8/iIu
         4CRWwHd6F3UkwuwmMbe2a0/BoOKyn18jdVlqgM2PCxaC7dcNc+o7Z+1kjm/Hd2RA5UfQ
         8ndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mvOVEVisAiVz66CKj1JUb8Hz2XWf05WJOgRYC/cB1C4=;
        b=LajLzwkB6O+UhvgTyumZ6HUfZOCNcmFyqsyQJKUxppTOqS4fiFnRJKS0uAiEpE3hTn
         MZNyEKOEWvu8A6qWnU0rGuFfLizryK6FVp9duARYutPGc2GjHj4wZmCgppvadohVWowI
         b/nzOCbZxUUrWIQ+J65l0XCLV0nmPGnHPAD/aTxlKnGBZpyeCogtMHXNSI/Rno7w6IeX
         3ajZOXakIvZvZ9kQPcfHdm7GODHx57N8dGnNNaQNVA/bEZ+GDiUii/zYJpeRWz1sQbLn
         wLLryuDX1rnVbxw4lwjS0OCqzh5abvVTRUjyaB1L7y/kEbzo4oCL+8MnwU2x89P8xpoV
         FzMg==
X-Gm-Message-State: AOAM531v/d8vLA49mc2HgaU6SN2jx/drhC0bsowl74no/BNc144AirQ9
        5iTtjXeSmxOed0NahEHOjW4=
X-Google-Smtp-Source: ABdhPJzIUgU67qBi0WANWXWb7j9qTj7PfrRTaFfo/1p/K+K4j9wT+OejbXgwXw1FnuCDaXaur355sA==
X-Received: by 2002:a1c:c256:: with SMTP id s83mr26428974wmf.93.1600625284213;
        Sun, 20 Sep 2020 11:08:04 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:03 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 01/19] ASoC: sun4i-i2s: Add support for H6 I2S
Date:   Sun, 20 Sep 2020 20:07:40 +0200
Message-Id: <20200920180758.592217-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to that in H3, except it supports up to 16
channels.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 218 ++++++++++++++++++++++++++++++++++++
 1 file changed, 218 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f23ff29e7c1d..348057464bed 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -124,6 +124,21 @@
 #define SUN8I_I2S_RX_CHAN_SEL_REG	0x54
 #define SUN8I_I2S_RX_CHAN_MAP_REG	0x58
 
+/* Defines required for sun50i-h6 support */
+#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK	GENMASK(21, 20)
+#define SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset)	((offset) << 20)
+#define SUN50I_H6_I2S_TX_CHAN_SEL_MASK		GENMASK(19, 16)
+#define SUN50I_H6_I2S_TX_CHAN_SEL(chan)		((chan - 1) << 16)
+#define SUN50I_H6_I2S_TX_CHAN_EN_MASK		GENMASK(15, 0)
+#define SUN50I_H6_I2S_TX_CHAN_EN(num_chan)	(((1 << num_chan) - 1))
+
+#define SUN50I_H6_I2S_TX_CHAN_MAP0_REG	0x44
+#define SUN50I_H6_I2S_TX_CHAN_MAP1_REG	0x48
+
+#define SUN50I_H6_I2S_RX_CHAN_SEL_REG	0x64
+#define SUN50I_H6_I2S_RX_CHAN_MAP0_REG	0x68
+#define SUN50I_H6_I2S_RX_CHAN_MAP1_REG	0x6C
+
 struct sun4i_i2s;
 
 /**
@@ -474,6 +489,62 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	return 0;
 }
 
+static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
+				      const struct snd_pcm_hw_params *params)
+{
+	unsigned int channels = params_channels(params);
+	unsigned int slots = channels;
+	unsigned int lrck_period;
+
+	if (i2s->slots)
+		slots = i2s->slots;
+
+	/* Map the channels for playback and capture */
+	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
+	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
+
+	/* Configure the channels */
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
+			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
+	regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
+			   SUN50I_H6_I2S_TX_CHAN_SEL_MASK,
+			   SUN50I_H6_I2S_TX_CHAN_SEL(channels));
+
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK,
+			   SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(channels));
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_CHAN_CFG_REG,
+			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK,
+			   SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(channels));
+
+	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_LEFT_J:
+	case SND_SOC_DAIFMT_RIGHT_J:
+		lrck_period = params_physical_width(params) * slots;
+		break;
+
+	case SND_SOC_DAIFMT_I2S:
+		lrck_period = params_physical_width(params);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
+			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
+
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+			   SUN50I_H6_I2S_TX_CHAN_EN_MASK,
+			   SUN50I_H6_I2S_TX_CHAN_EN(channels));
+
+	return 0;
+}
+
 static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 			       struct snd_pcm_hw_params *params,
 			       struct snd_soc_dai *dai)
@@ -699,6 +770,102 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	return 0;
 }
 
+static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
+				     unsigned int fmt)
+{
+	u32 mode, val;
+	u8 offset;
+
+	/* DAI clock polarity */
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_IB_IF:
+		/* Invert both clocks */
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED |
+		      SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		/* Invert bit clock */
+		val = SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_IF:
+		/* Invert frame clock */
+		val = SUN8I_I2S_FMT0_LRCLK_POLARITY_INVERTED;
+		break;
+	case SND_SOC_DAIFMT_NB_NF:
+		val = 0;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
+			   SUN8I_I2S_FMT0_LRCLK_POLARITY_MASK |
+			   SUN8I_I2S_FMT0_BCLK_POLARITY_MASK,
+			   val);
+
+	/* DAI Mode */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_A:
+		mode = SUN8I_I2S_CTRL_MODE_PCM;
+		offset = 1;
+		break;
+
+	case SND_SOC_DAIFMT_DSP_B:
+		mode = SUN8I_I2S_CTRL_MODE_PCM;
+		offset = 0;
+		break;
+
+	case SND_SOC_DAIFMT_I2S:
+		mode = SUN8I_I2S_CTRL_MODE_LEFT;
+		offset = 1;
+		break;
+
+	case SND_SOC_DAIFMT_LEFT_J:
+		mode = SUN8I_I2S_CTRL_MODE_LEFT;
+		offset = 0;
+		break;
+
+	case SND_SOC_DAIFMT_RIGHT_J:
+		mode = SUN8I_I2S_CTRL_MODE_RIGHT;
+		offset = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN8I_I2S_CTRL_MODE_MASK, mode);
+	regmap_update_bits(i2s->regmap, SUN8I_I2S_TX_CHAN_SEL_REG,
+			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
+			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
+	regmap_update_bits(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_SEL_REG,
+			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET_MASK,
+			   SUN50I_H6_I2S_TX_CHAN_SEL_OFFSET(offset));
+
+	/* DAI clock master masks */
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		/* BCLK and LRCLK master */
+		val = SUN8I_I2S_CTRL_BCLK_OUT |	SUN8I_I2S_CTRL_LRCK_OUT;
+		break;
+
+	case SND_SOC_DAIFMT_CBM_CFM:
+		/* BCLK and LRCLK slave */
+		val = 0;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
+			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
+			   val);
+
+	return 0;
+}
+
 static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
@@ -979,6 +1146,22 @@ static const struct reg_default sun8i_i2s_reg_defaults[] = {
 	{ SUN8I_I2S_RX_CHAN_MAP_REG, 0x00000000 },
 };
 
+static const struct reg_default sun50i_h6_i2s_reg_defaults[] = {
+	{ SUN4I_I2S_CTRL_REG, 0x00060000 },
+	{ SUN4I_I2S_FMT0_REG, 0x00000033 },
+	{ SUN4I_I2S_FMT1_REG, 0x00000030 },
+	{ SUN4I_I2S_FIFO_CTRL_REG, 0x000400f0 },
+	{ SUN4I_I2S_DMA_INT_CTRL_REG, 0x00000000 },
+	{ SUN4I_I2S_CLK_DIV_REG, 0x00000000 },
+	{ SUN8I_I2S_CHAN_CFG_REG, 0x00000000 },
+	{ SUN8I_I2S_TX_CHAN_SEL_REG, 0x00000000 },
+	{ SUN50I_H6_I2S_TX_CHAN_MAP0_REG, 0x00000000 },
+	{ SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x00000000 },
+	{ SUN50I_H6_I2S_RX_CHAN_SEL_REG, 0x00000000 },
+	{ SUN50I_H6_I2S_RX_CHAN_MAP0_REG, 0x00000000 },
+	{ SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x00000000 },
+};
+
 static const struct regmap_config sun4i_i2s_regmap_config = {
 	.reg_bits	= 32,
 	.reg_stride	= 4,
@@ -1006,6 +1189,19 @@ static const struct regmap_config sun8i_i2s_regmap_config = {
 	.volatile_reg	= sun8i_i2s_volatile_reg,
 };
 
+static const struct regmap_config sun50i_h6_i2s_regmap_config = {
+	.reg_bits	= 32,
+	.reg_stride	= 4,
+	.val_bits	= 32,
+	.max_register	= SUN50I_H6_I2S_RX_CHAN_MAP1_REG,
+	.cache_type	= REGCACHE_FLAT,
+	.reg_defaults	= sun50i_h6_i2s_reg_defaults,
+	.num_reg_defaults	= ARRAY_SIZE(sun50i_h6_i2s_reg_defaults),
+	.writeable_reg	= sun4i_i2s_wr_reg,
+	.readable_reg	= sun8i_i2s_rd_reg,
+	.volatile_reg	= sun8i_i2s_volatile_reg,
+};
+
 static int sun4i_i2s_runtime_resume(struct device *dev)
 {
 	struct sun4i_i2s *i2s = dev_get_drvdata(dev);
@@ -1164,6 +1360,24 @@ static const struct sun4i_i2s_quirks sun50i_a64_codec_i2s_quirks = {
 	.set_fmt		= sun4i_i2s_set_soc_fmt,
 };
 
+static const struct sun4i_i2s_quirks sun50i_h6_i2s_quirks = {
+	.has_reset		= true,
+	.reg_offset_txdata	= SUN8I_I2S_FIFO_TX_REG,
+	.sun4i_i2s_regmap	= &sun50i_h6_i2s_regmap_config,
+	.field_clkdiv_mclk_en	= REG_FIELD(SUN4I_I2S_CLK_DIV_REG, 8, 8),
+	.field_fmt_wss		= REG_FIELD(SUN4I_I2S_FMT0_REG, 0, 2),
+	.field_fmt_sr		= REG_FIELD(SUN4I_I2S_FMT0_REG, 4, 6),
+	.bclk_dividers		= sun8i_i2s_clk_div,
+	.num_bclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
+	.mclk_dividers		= sun8i_i2s_clk_div,
+	.num_mclk_dividers	= ARRAY_SIZE(sun8i_i2s_clk_div),
+	.get_bclk_parent_rate	= sun8i_i2s_get_bclk_parent_rate,
+	.get_sr			= sun8i_i2s_get_sr_wss,
+	.get_wss		= sun8i_i2s_get_sr_wss,
+	.set_chan_cfg		= sun50i_h6_i2s_set_chan_cfg,
+	.set_fmt		= sun50i_h6_i2s_set_soc_fmt,
+};
+
 static int sun4i_i2s_init_regmap_fields(struct device *dev,
 					struct sun4i_i2s *i2s)
 {
@@ -1333,6 +1547,10 @@ static const struct of_device_id sun4i_i2s_match[] = {
 		.compatible = "allwinner,sun50i-a64-codec-i2s",
 		.data = &sun50i_a64_codec_i2s_quirks,
 	},
+	{
+		.compatible = "allwinner,sun50i-h6-i2s",
+		.data = &sun50i_h6_i2s_quirks,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sun4i_i2s_match);
-- 
2.25.1

