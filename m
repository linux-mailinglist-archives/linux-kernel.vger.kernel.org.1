Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36FF28D9E0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730527AbgJNGUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:20:33 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:43135 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730539AbgJNGTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:19:54 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 1E026D3C;
        Wed, 14 Oct 2020 02:19:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 14 Oct 2020 02:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=aiuGegFFyV37P
        LripPGWgRFigVm0XQbCfCSOKjRGSb0=; b=Zf0aWabS0N9baFWoJxl7nniWbCOn5
        xL3BGV6828Axsg/BvDYXupwJsWvksCOSPbavZQ3AqRMSZaycQQa2kZouTNTrjMTr
        PqsbO7moRCgen3MsTR/ZnR3Ij1TF/82/SktTgCM3tsLUnDnuiLG4uCyEyeK7i9Ue
        Y/LH0qzPy+kqFpYTWyngm8WYubhInxHwOf7JEOq3c52kL5QtbTwCb18DyDdxBM3s
        /G/yW6zfg3bPfHOXYjFFUfbwxVIUZaf0EzBjLIbT+nEleaf1grbLnT/4X8Ww2OKL
        SCgvwq1flNx/gmd5P5BnoBoH5O9WX1uylkhRqMqamekBSwrJrgQ4VYUSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=aiuGegFFyV37PLripPGWgRFigVm0XQbCfCSOKjRGSb0=; b=C3w9NrlY
        mcmB2NtYXHgv/8cBm3doEahS60fTnYEkhIf60HZ5NxWQBXLFH5fOTw/XY2JN1yoF
        A6AllZyIq1d/yb7U+pbRYMkYszOne1zpGsi75jjeaM7ynlfaPLrgu2nALbDA2JO4
        1cnO0Uj/1qBMQh0zc5FcvBekgz174KXW4QZVOljWIWMJi9vr/1I3YcxRj1QRKJs9
        iweUrOu3q4b6pmTPcA2dRN7W5fV+1ayJw4OY3x8d99ReYuuV16/c2/TJVqU4Lvgo
        qV01u3GNsv9zs97No0+LIjAHCKkfkulpgFMNhkPEt/4Ud/dnGDz4qusxSINHfuyQ
        RfW52Oei7hb64A==
X-ME-Sender: <xms:hZiGXwdA0Ab8GAKw2h4bE-9fQ5vnSce98B8AKmQwar4g7s-4aTvMKA>
    <xme:hZiGXyOpm2AoMLsw2yQLtpiP6BlgTmAJIzg1_5TB2N6Zsq2z3_MGKLJl9f6aGsZog
    9NwB41JMeYthpTzpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedriedtgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepjeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:hZiGXxjO4DlxKnNN9_pc301ZkUL6FbyFumsw0-6T2X49D-pa62DlFw>
    <xmx:hZiGX1-85LA4x9Zh6mQCz3zO0QMYQurxPM2PQ3TB-RS0Et4R4z_zKg>
    <xmx:hZiGX8tSeRg8ETw6gKSxWQewVkPTAwIq8ljzZvcEiWH5wK36s5CScA>
    <xmx:hZiGX6BsPw7E6rtcMoRHU1oLnDLiG0mC0l33jDOBQ7aJuD_cL18SKWKy830>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id ED198328005D;
        Wed, 14 Oct 2020 02:19:48 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 15/17] ASoC: sun8i-codec: Generalize AIF clock control
Date:   Wed, 14 Oct 2020 01:19:39 -0500
Message-Id: <20201014061941.4306-16-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014061941.4306-1-samuel@sholland.org>
References: <20201014061941.4306-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AIF clock control register has the same layout for all three AIFs.
The only difference between them is that AIF3 is missing some fields. We
can reuse the same register field definitions for all three registers,
and use the DAI ID to select the correct register address.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 sound/soc/sunxi/sun8i-codec.c | 62 ++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index e3abf8363d9b..6aa8751f7fa0 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -37,23 +37,23 @@
 #define SUN8I_MOD_CLK_ENA_DAC				2
 #define SUN8I_MOD_RST_CTL				0x014
 #define SUN8I_MOD_RST_CTL_AIF1				15
 #define SUN8I_MOD_RST_CTL_ADC				3
 #define SUN8I_MOD_RST_CTL_DAC				2
 #define SUN8I_SYS_SR_CTRL				0x018
 #define SUN8I_SYS_SR_CTRL_AIF1_FS			12
 #define SUN8I_SYS_SR_CTRL_AIF2_FS			8
-#define SUN8I_AIF1CLK_CTRL				0x040
-#define SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD		15
-#define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV			13
-#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV		9
-#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV		6
-#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ		4
-#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT		2
+#define SUN8I_AIF_CLK_CTRL(n)				(0x040 * (1 + (n)))
+#define SUN8I_AIF_CLK_CTRL_MSTR_MOD			15
+#define SUN8I_AIF_CLK_CTRL_CLK_INV			13
+#define SUN8I_AIF_CLK_CTRL_BCLK_DIV			9
+#define SUN8I_AIF_CLK_CTRL_LRCK_DIV			6
+#define SUN8I_AIF_CLK_CTRL_WORD_SIZ			4
+#define SUN8I_AIF_CLK_CTRL_DATA_FMT			2
 #define SUN8I_AIF1_ADCDAT_CTRL				0x044
 #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_ENA		15
 #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_ENA		14
 #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0L_SRC		10
 #define SUN8I_AIF1_ADCDAT_CTRL_AIF1_AD0R_SRC		8
 #define SUN8I_AIF1_DACDAT_CTRL				0x048
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0L_ENA		15
 #define SUN8I_AIF1_DACDAT_CTRL_AIF1_DA0R_ENA		14
@@ -83,21 +83,21 @@
 #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF1DA1R		10
 #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_AIF2DACR		9
 #define SUN8I_DAC_MXR_SRC_DACR_MXR_SRC_ADCR		8
 
 #define SUN8I_SYSCLK_CTL_AIF1CLK_SRC_MASK	GENMASK(9, 8)
 #define SUN8I_SYSCLK_CTL_AIF2CLK_SRC_MASK	GENMASK(5, 4)
 #define SUN8I_SYS_SR_CTRL_AIF1_FS_MASK		GENMASK(15, 12)
 #define SUN8I_SYS_SR_CTRL_AIF2_FS_MASK		GENMASK(11, 8)
-#define SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV_MASK	GENMASK(14, 13)
-#define SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK	GENMASK(12, 9)
-#define SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK	GENMASK(8, 6)
-#define SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK	GENMASK(5, 4)
-#define SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK	GENMASK(3, 2)
+#define SUN8I_AIF_CLK_CTRL_CLK_INV_MASK		GENMASK(14, 13)
+#define SUN8I_AIF_CLK_CTRL_BCLK_DIV_MASK	GENMASK(12, 9)
+#define SUN8I_AIF_CLK_CTRL_LRCK_DIV_MASK	GENMASK(8, 6)
+#define SUN8I_AIF_CLK_CTRL_WORD_SIZ_MASK	GENMASK(5, 4)
+#define SUN8I_AIF_CLK_CTRL_DATA_FMT_MASK	GENMASK(3, 2)
 
 #define SUN8I_CODEC_PASSTHROUGH_SAMPLE_RATE 48000
 
 #define SUN8I_CODEC_PCM_FORMATS	(SNDRV_PCM_FMTBIT_S8     |\
 				 SNDRV_PCM_FMTBIT_S16_LE |\
 				 SNDRV_PCM_FMTBIT_S20_LE |\
 				 SNDRV_PCM_FMTBIT_S24_LE |\
 				 SNDRV_PCM_FMTBIT_S20_3LE|\
@@ -236,19 +236,20 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		value = 0x1;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM: /* Codec Master, DAI slave */
 		value = 0x0;
 		break;
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   BIT(SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD),
-			   value << SUN8I_AIF1CLK_CTRL_AIF1_MSTR_MOD);
+
+	regmap_update_bits(scodec->regmap, SUN8I_AIF_CLK_CTRL(dai->id),
+			   BIT(SUN8I_AIF_CLK_CTRL_MSTR_MOD),
+			   value << SUN8I_AIF_CLK_CTRL_MSTR_MOD);
 
 	/* DAI format */
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		format = 0x0;
 		break;
 	case SND_SOC_DAIFMT_LEFT_J:
 		format = 0x1;
@@ -262,19 +263,20 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	case SND_SOC_DAIFMT_DSP_B:
 		format = 0x3;
 		dsp_format = 0x1; /* Set LRCK_INV to 1 */
 		break;
 	default:
 		return -EINVAL;
 	}
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT_MASK,
-			   format << SUN8I_AIF1CLK_CTRL_AIF1_DATA_FMT);
+
+	regmap_update_bits(scodec->regmap, SUN8I_AIF_CLK_CTRL(dai->id),
+			   SUN8I_AIF_CLK_CTRL_DATA_FMT_MASK,
+			   format << SUN8I_AIF_CLK_CTRL_DATA_FMT);
 
 	/* clock inversion */
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF: /* Normal */
 		invert = 0x0;
 		break;
 	case SND_SOC_DAIFMT_NB_IF: /* Inverted LRCK */
 		invert = 0x1;
@@ -305,19 +307,19 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		 * Since the DAI here is our regular i2s driver that have been
 		 * tested with way more codecs than just this one, it means
 		 * that the codec probably gets it backward, and we have to
 		 * invert the value here.
 		 */
 		invert ^= scodec->quirks->lrck_inversion;
 	}
 
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV_MASK,
-			   invert << SUN8I_AIF1CLK_CTRL_AIF1_CLK_INV);
+	regmap_update_bits(scodec->regmap, SUN8I_AIF_CLK_CTRL(dai->id),
+			   SUN8I_AIF_CLK_CTRL_CLK_INV_MASK,
+			   invert << SUN8I_AIF_CLK_CTRL_CLK_INV);
 
 	return 0;
 }
 
 static int sun8i_codec_set_tdm_slot(struct snd_soc_dai *dai,
 				    unsigned int tx_mask, unsigned int rx_mask,
 				    int slots, int slot_width)
 {
@@ -454,37 +456,37 @@ static int sun8i_codec_hw_params(struct snd_pcm_substream *substream,
 		break;
 	case 24:
 		word_size = 0x3;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ_MASK,
-			   word_size << SUN8I_AIF1CLK_CTRL_AIF1_WORD_SIZ);
+	regmap_update_bits(scodec->regmap, SUN8I_AIF_CLK_CTRL(dai->id),
+			   SUN8I_AIF_CLK_CTRL_WORD_SIZ_MASK,
+			   word_size << SUN8I_AIF_CLK_CTRL_WORD_SIZ);
 
 	/* LRCK divider (BCLK/LRCK ratio) */
 	lrck_div_order = sun8i_codec_get_lrck_div_order(slots, slot_width);
 	if (lrck_div_order < 0)
 		return lrck_div_order;
 
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV_MASK,
-			   (lrck_div_order - 4) << SUN8I_AIF1CLK_CTRL_AIF1_LRCK_DIV);
+	regmap_update_bits(scodec->regmap, SUN8I_AIF_CLK_CTRL(dai->id),
+			   SUN8I_AIF_CLK_CTRL_LRCK_DIV_MASK,
+			   (lrck_div_order - 4) << SUN8I_AIF_CLK_CTRL_LRCK_DIV);
 
 	/* BCLK divider (SYSCLK/BCLK ratio) */
 	bclk_div = sun8i_codec_get_bclk_div(sysclk_rate, lrck_div_order, sample_rate);
 	if (bclk_div < 0)
 		return bclk_div;
 
-	regmap_update_bits(scodec->regmap, SUN8I_AIF1CLK_CTRL,
-			   SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV_MASK,
-			   bclk_div << SUN8I_AIF1CLK_CTRL_AIF1_BCLK_DIV);
+	regmap_update_bits(scodec->regmap, SUN8I_AIF_CLK_CTRL(dai->id),
+			   SUN8I_AIF_CLK_CTRL_BCLK_DIV_MASK,
+			   bclk_div << SUN8I_AIF_CLK_CTRL_BCLK_DIV);
 
 	/*
 	 * SYSCLK rate
 	 *
 	 * Clock rate protection is reference counted; but hw_params may be
 	 * called many times per substream, without matching calls to hw_free.
 	 * Protect the clock rate once per AIF, on the first hw_params call
 	 * for the first substream. clk_set_rate() will allow clock rate
-- 
2.26.2

