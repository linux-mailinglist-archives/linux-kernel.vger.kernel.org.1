Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD2A2D111C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgLGMyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:54:31 -0500
Received: from aposti.net ([89.234.176.197]:58968 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGMya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:54:30 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 1/5] ASoC: codecs/jz47xx: Use regmap_{set,clear}_bits
Date:   Mon,  7 Dec 2020 12:53:33 +0000
Message-Id: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_{set,clear}_bits instead of regmap_update_bits, when
applicable.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4725b.c | 26 ++++++------
 sound/soc/codecs/jz4740.c  | 20 +++------
 sound/soc/codecs/jz4770.c  | 85 +++++++++++++++++---------------------
 3 files changed, 55 insertions(+), 76 deletions(-)

diff --git a/sound/soc/codecs/jz4725b.c b/sound/soc/codecs/jz4725b.c
index e49374c72e70..5201a8f6d7b6 100644
--- a/sound/soc/codecs/jz4725b.c
+++ b/sound/soc/codecs/jz4725b.c
@@ -198,15 +198,15 @@ static int jz4725b_out_stage_enable(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		return regmap_update_bits(map, JZ4725B_CODEC_REG_IFR,
-					  BIT(REG_IFR_RAMP_UP_DONE_OFFSET), 0);
+		return regmap_clear_bits(map, JZ4725B_CODEC_REG_IFR,
+					 BIT(REG_IFR_RAMP_UP_DONE_OFFSET));
 	case SND_SOC_DAPM_POST_PMU:
 		return regmap_read_poll_timeout(map, JZ4725B_CODEC_REG_IFR,
 			       val, val & BIT(REG_IFR_RAMP_UP_DONE_OFFSET),
 			       100000, 500000);
 	case SND_SOC_DAPM_PRE_PMD:
-		return regmap_update_bits(map, JZ4725B_CODEC_REG_IFR,
-				BIT(REG_IFR_RAMP_DOWN_DONE_OFFSET), 0);
+		return regmap_clear_bits(map, JZ4725B_CODEC_REG_IFR,
+				BIT(REG_IFR_RAMP_DOWN_DONE_OFFSET));
 	case SND_SOC_DAPM_POST_PMD:
 		return regmap_read_poll_timeout(map, JZ4725B_CODEC_REG_IFR,
 			       val, val & BIT(REG_IFR_RAMP_DOWN_DONE_OFFSET),
@@ -303,24 +303,22 @@ static int jz4725b_codec_set_bias_level(struct snd_soc_component *component,
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
-		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
-				   BIT(REG_PMR2_SB_SLEEP_OFFSET), 0);
+		regmap_clear_bits(map, JZ4725B_CODEC_REG_PMR2,
+				  BIT(REG_PMR2_SB_SLEEP_OFFSET));
 		break;
 	case SND_SOC_BIAS_PREPARE:
 		/* Enable sound hardware */
-		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
-				   BIT(REG_PMR2_SB_OFFSET), 0);
+		regmap_clear_bits(map, JZ4725B_CODEC_REG_PMR2,
+				  BIT(REG_PMR2_SB_OFFSET));
 		msleep(224);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
-				   BIT(REG_PMR2_SB_SLEEP_OFFSET),
-				   BIT(REG_PMR2_SB_SLEEP_OFFSET));
+		regmap_set_bits(map, JZ4725B_CODEC_REG_PMR2,
+				BIT(REG_PMR2_SB_SLEEP_OFFSET));
 		break;
 	case SND_SOC_BIAS_OFF:
-		regmap_update_bits(map, JZ4725B_CODEC_REG_PMR2,
-				   BIT(REG_PMR2_SB_OFFSET),
-				   BIT(REG_PMR2_SB_OFFSET));
+		regmap_set_bits(map, JZ4725B_CODEC_REG_PMR2,
+				BIT(REG_PMR2_SB_OFFSET));
 		break;
 	}
 
diff --git a/sound/soc/codecs/jz4740.c b/sound/soc/codecs/jz4740.c
index c9900d1cd5c2..5e58bfee2b49 100644
--- a/sound/soc/codecs/jz4740.c
+++ b/sound/soc/codecs/jz4740.c
@@ -219,12 +219,11 @@ static struct snd_soc_dai_driver jz4740_codec_dai = {
 
 static void jz4740_codec_wakeup(struct regmap *regmap)
 {
-	regmap_update_bits(regmap, JZ4740_REG_CODEC_1,
-		JZ4740_CODEC_1_RESET, JZ4740_CODEC_1_RESET);
+	regmap_set_bits(regmap, JZ4740_REG_CODEC_1, JZ4740_CODEC_1_RESET);
 	udelay(2);
 
-	regmap_update_bits(regmap, JZ4740_REG_CODEC_1,
-		JZ4740_CODEC_1_SUSPEND | JZ4740_CODEC_1_RESET, 0);
+	regmap_clear_bits(regmap, JZ4740_REG_CODEC_1,
+			  JZ4740_CODEC_1_SUSPEND | JZ4740_CODEC_1_RESET);
 
 	regcache_sync(regmap);
 }
@@ -235,7 +234,6 @@ static int jz4740_codec_set_bias_level(struct snd_soc_component *component,
 	struct jz4740_codec *jz4740_codec = snd_soc_component_get_drvdata(component);
 	struct regmap *regmap = jz4740_codec->regmap;
 	unsigned int mask;
-	unsigned int value;
 
 	switch (level) {
 	case SND_SOC_BIAS_ON:
@@ -244,9 +242,8 @@ static int jz4740_codec_set_bias_level(struct snd_soc_component *component,
 		mask = JZ4740_CODEC_1_VREF_DISABLE |
 				JZ4740_CODEC_1_VREF_AMP_DISABLE |
 				JZ4740_CODEC_1_HEADPHONE_POWERDOWN_M;
-		value = 0;
 
-		regmap_update_bits(regmap, JZ4740_REG_CODEC_1, mask, value);
+		regmap_clear_bits(regmap, JZ4740_REG_CODEC_1, mask);
 		break;
 	case SND_SOC_BIAS_STANDBY:
 		/* The only way to clear the suspend flag is to reset the codec */
@@ -256,17 +253,12 @@ static int jz4740_codec_set_bias_level(struct snd_soc_component *component,
 		mask = JZ4740_CODEC_1_VREF_DISABLE |
 			JZ4740_CODEC_1_VREF_AMP_DISABLE |
 			JZ4740_CODEC_1_HEADPHONE_POWERDOWN_M;
-		value = JZ4740_CODEC_1_VREF_DISABLE |
-			JZ4740_CODEC_1_VREF_AMP_DISABLE |
-			JZ4740_CODEC_1_HEADPHONE_POWERDOWN_M;
 
-		regmap_update_bits(regmap, JZ4740_REG_CODEC_1, mask, value);
+		regmap_set_bits(regmap, JZ4740_REG_CODEC_1, mask);
 		break;
 	case SND_SOC_BIAS_OFF:
 		mask = JZ4740_CODEC_1_SUSPEND;
-		value = JZ4740_CODEC_1_SUSPEND;
-
-		regmap_update_bits(regmap, JZ4740_REG_CODEC_1, mask, value);
+		regmap_set_bits(regmap, JZ4740_REG_CODEC_1, mask);
 		regcache_mark_dirty(regmap);
 		break;
 	default:
diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 298689a07168..c6b2043f31a9 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -190,18 +190,18 @@ static int jz4770_codec_set_bias_level(struct snd_soc_component *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
-		regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
-				   REG_CR_VIC_SB, 0);
+		regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
+				  REG_CR_VIC_SB);
 		msleep(250);
-		regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
-				   REG_CR_VIC_SB_SLEEP, 0);
+		regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
+				  REG_CR_VIC_SB_SLEEP);
 		msleep(400);
 		break;
 	case SND_SOC_BIAS_STANDBY:
-		regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
-				   REG_CR_VIC_SB_SLEEP, REG_CR_VIC_SB_SLEEP);
-		regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
-				   REG_CR_VIC_SB, REG_CR_VIC_SB);
+		regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
+				REG_CR_VIC_SB_SLEEP);
+		regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
+				REG_CR_VIC_SB);
 		fallthrough;
 	default:
 		break;
@@ -292,8 +292,8 @@ static int jz4770_codec_mute_stream(struct snd_soc_dai *dai, int mute, int direc
 		}
 
 		/* clear GUP/GDO flag */
-		regmap_update_bits(jz_codec->regmap, JZ4770_CODEC_REG_IFR,
-				   gain_bit, gain_bit);
+		regmap_set_bits(jz_codec->regmap, JZ4770_CODEC_REG_IFR,
+				gain_bit);
 	}
 
 	return 0;
@@ -369,8 +369,8 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
 		/* set cap-less, unmute HP */
-		regmap_update_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
-				   REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE, 0);
+		regmap_clear_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
+				  REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
@@ -385,16 +385,15 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		}
 
 		/* clear RUP flag */
-		regmap_update_bits(jz_codec->regmap, JZ4770_CODEC_REG_IFR,
-				   REG_IFR_RUP, REG_IFR_RUP);
+		regmap_set_bits(jz_codec->regmap, JZ4770_CODEC_REG_IFR,
+				REG_IFR_RUP);
 
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
 		/* set cap-couple, mute HP */
-		regmap_update_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
-				   REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE,
-				   REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
+		regmap_set_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
+				REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
 
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
@@ -406,8 +405,8 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		}
 
 		/* clear RDO flag */
-		regmap_update_bits(jz_codec->regmap, JZ4770_CODEC_REG_IFR,
-				   REG_IFR_RDO, REG_IFR_RDO);
+		regmap_set_bits(jz_codec->regmap, JZ4770_CODEC_REG_IFR,
+				REG_IFR_RDO);
 
 		break;
 	}
@@ -592,63 +591,53 @@ static void jz4770_codec_codec_init_regs(struct snd_soc_component *codec)
 	regcache_cache_only(regmap, true);
 
 	/* default HP output to PCM */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_HP,
-			   REG_CR_HP_SEL_MASK, REG_CR_HP_SEL_MASK);
+	regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_HP, REG_CR_HP_SEL_MASK);
 
 	/* default line output to PCM */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_LO,
-			   REG_CR_LO_SEL_MASK, REG_CR_LO_SEL_MASK);
+	regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_LO, REG_CR_LO_SEL_MASK);
 
 	/* Disable stereo mic */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_MIC,
-			   BIT(REG_CR_MIC_STEREO_OFFSET), 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_MIC,
+			  BIT(REG_CR_MIC_STEREO_OFFSET));
 
 	/* Set mic 1 as default source for ADC */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_ADC,
-			   REG_CR_ADC_IN_SEL_MASK, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_ADC,
+			  REG_CR_ADC_IN_SEL_MASK);
 
 	/* ADC/DAC: serial + i2s */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_AICR_ADC,
-			   REG_AICR_ADC_SERIAL | REG_AICR_ADC_I2S,
-			   REG_AICR_ADC_SERIAL | REG_AICR_ADC_I2S);
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_AICR_DAC,
-			   REG_AICR_DAC_SERIAL | REG_AICR_DAC_I2S,
-			   REG_AICR_DAC_SERIAL | REG_AICR_DAC_I2S);
+	regmap_set_bits(regmap, JZ4770_CODEC_REG_AICR_ADC,
+			REG_AICR_ADC_SERIAL | REG_AICR_ADC_I2S);
+	regmap_set_bits(regmap, JZ4770_CODEC_REG_AICR_DAC,
+			REG_AICR_DAC_SERIAL | REG_AICR_DAC_I2S);
 
 	/* The generated IRQ is a high level */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_ICR,
-			   REG_ICR_INT_FORM_MASK, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_ICR, REG_ICR_INT_FORM_MASK);
 	regmap_update_bits(regmap, JZ4770_CODEC_REG_IMR, REG_IMR_ALL_MASK,
 			   REG_IMR_JACK_MASK | REG_IMR_RUP_MASK |
 			   REG_IMR_RDO_MASK | REG_IMR_GUP_MASK |
 			   REG_IMR_GDO_MASK);
 
 	/* 12M oscillator */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CCR,
-			   REG_CCR_CRYSTAL_MASK, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CCR, REG_CCR_CRYSTAL_MASK);
 
 	/* 0: 16ohm/220uF, 1: 10kohm/1uF */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_HP,
-			   REG_CR_HP_LOAD, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_HP, REG_CR_HP_LOAD);
 
 	/* disable automatic gain */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_AGC1, REG_AGC1_EN, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_AGC1, REG_AGC1_EN);
 
 	/* Disable DAC lrswap */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_DAC,
-			   REG_CR_DAC_LRSWAP, REG_CR_DAC_LRSWAP);
+	regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_DAC, REG_CR_DAC_LRSWAP);
 
 	/* Independent L/R DAC gain control */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_GCR_DACL,
-			   REG_GCR_DACL_RLGOD, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_GCR_DACL,
+			  REG_GCR_DACL_RLGOD);
 
 	/* Disable ADC lrswap */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_ADC,
-			   REG_CR_ADC_LRSWAP, REG_CR_ADC_LRSWAP);
+	regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_ADC, REG_CR_ADC_LRSWAP);
 
 	/* default to cap-less mode(0) */
-	regmap_update_bits(regmap, JZ4770_CODEC_REG_CR_HP,
-			   REG_CR_HP_SB_HPCM, 0);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_HP, REG_CR_HP_SB_HPCM);
 
 	/* Send collected updates. */
 	regcache_cache_only(regmap, false);
-- 
2.29.2

