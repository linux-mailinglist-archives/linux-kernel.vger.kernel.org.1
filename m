Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A873D20B625
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgFZQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgFZQqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:46:43 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D87C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 09:46:43 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B85F32A5E1E
Received: by jupiter.universe (Postfix, from userid 1000)
        id 215EC480101; Fri, 26 Jun 2020 18:46:40 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv4] ASoC: da7213: add default clock handling
Date:   Fri, 26 Jun 2020 18:46:23 +0200
Message-Id: <20200626164623.87894-1-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <AM6PR10MB2263094DD176499308EC8B2A80B80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
References: <AM6PR10MB2263094DD176499308EC8B2A80B80@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds default clock/PLL configuration to the driver
for usage with generic drivers like simple-card for usage
with a fixed rate clock.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Changes since PATCHv3:
 * rebase to v5.8-rc1
 * add SRM support for usage in slave mode with simple-card.
   I only tested with master mode, though.
---
 sound/soc/codecs/da7213.c | 83 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7213.h |  2 +
 2 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3e6ad996741b..1a4fece20bcd 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -1156,6 +1156,7 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct snd_soc_component *component = dai->component;
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 	u8 dai_ctrl = 0;
 	u8 fs;
 
@@ -1181,33 +1182,43 @@ static int da7213_hw_params(struct snd_pcm_substream *substream,
 	switch (params_rate(params)) {
 	case 8000:
 		fs = DA7213_SR_8000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 11025:
 		fs = DA7213_SR_11025;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 12000:
 		fs = DA7213_SR_12000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 16000:
 		fs = DA7213_SR_16000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 22050:
 		fs = DA7213_SR_22050;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 32000:
 		fs = DA7213_SR_32000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 44100:
 		fs = DA7213_SR_44100;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 48000:
 		fs = DA7213_SR_48000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	case 88200:
 		fs = DA7213_SR_88200;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_90316800;
 		break;
 	case 96000:
 		fs = DA7213_SR_96000;
+		da7213->out_rate = DA7213_PLL_FREQ_OUT_98304000;
 		break;
 	default:
 		return -EINVAL;
@@ -1392,9 +1403,9 @@ static int da7213_set_component_sysclk(struct snd_soc_component *component,
 }
 
 /* Supported PLL input frequencies are 32KHz, 5MHz - 54MHz. */
-static int da7213_set_component_pll(struct snd_soc_component *component,
-				    int pll_id, int source,
-				    unsigned int fref, unsigned int fout)
+static int _da7213_set_component_pll(struct snd_soc_component *component,
+				     int pll_id, int source,
+				     unsigned int fref, unsigned int fout)
 {
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
 
@@ -1503,6 +1514,16 @@ static int da7213_set_component_pll(struct snd_soc_component *component,
 	return 0;
 }
 
+static int da7213_set_component_pll(struct snd_soc_component *component,
+				    int pll_id, int source,
+				    unsigned int fref, unsigned int fout)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	da7213->fixed_clk_auto_pll = false;
+
+	return _da7213_set_component_pll(component, pll_id, source, fref, fout);
+}
+
 /* DAI operations */
 static const struct snd_soc_dai_ops da7213_dai_ops = {
 	.hw_params	= da7213_hw_params,
@@ -1532,6 +1553,50 @@ static struct snd_soc_dai_driver da7213_dai = {
 	.symmetric_rates = 1,
 };
 
+static int da7213_set_auto_pll(struct snd_soc_component *component, bool enable)
+{
+	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
+	int mode;
+
+	if (!da7213->fixed_clk_auto_pll)
+		return 0;
+
+	da7213->mclk_rate = clk_get_rate(da7213->mclk);
+
+	if (enable) {
+		/* Slave mode needs SRM for non-harmonic frequencies */
+		if (da7213->master)
+			mode = DA7213_SYSCLK_PLL;
+		else
+			mode = DA7213_SYSCLK_PLL_SRM;
+
+		/* PLL is not required for harmonic frequencies */
+		switch (da7213->out_rate) {
+		case DA7213_PLL_FREQ_OUT_90316800:
+			if (da7213->mclk_rate == 11289600 ||
+			    da7213->mclk_rate == 22579200 ||
+			    da7213->mclk_rate == 45158400)
+				mode = DA7213_SYSCLK_MCLK;
+			break;
+		case DA7213_PLL_FREQ_OUT_98304000:
+			if (da7213->mclk_rate == 12288000 ||
+			    da7213->mclk_rate == 24576000 ||
+			    da7213->mclk_rate == 49152000)
+				mode = DA7213_SYSCLK_MCLK;
+
+			break;
+		default:
+			return -1;
+		}
+	} else {
+		/* Disable PLL in standby */
+		mode = DA7213_SYSCLK_MCLK;
+	}
+
+	return _da7213_set_component_pll(component, 0, mode,
+					 da7213->mclk_rate, da7213->out_rate);
+}
+
 static int da7213_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
@@ -1551,6 +1616,8 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 						"Failed to enable mclk\n");
 					return ret;
 				}
+
+				da7213_set_auto_pll(component, true);
 			}
 		}
 		break;
@@ -1562,8 +1629,10 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 					    DA7213_VMID_EN | DA7213_BIAS_EN);
 		} else {
 			/* Remove MCLK */
-			if (da7213->mclk)
+			if (da7213->mclk) {
+				da7213_set_auto_pll(component, false);
 				clk_disable_unprepare(da7213->mclk);
+			}
 		}
 		break;
 	case SND_SOC_BIAS_OFF:
@@ -1693,7 +1762,6 @@ static struct da7213_platform_data
 	return pdata;
 }
 
-
 static int da7213_probe(struct snd_soc_component *component)
 {
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
@@ -1829,6 +1897,11 @@ static int da7213_probe(struct snd_soc_component *component)
 			return PTR_ERR(da7213->mclk);
 		else
 			da7213->mclk = NULL;
+	} else {
+		/* Do automatic PLL handling assuming fixed clock until
+		 * set_pll() has been called. This makes the codec usable
+		 * with the simple-audio-card driver. */
+		da7213->fixed_clk_auto_pll = true;
 	}
 
 	return 0;
diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
index 3890829dfb6e..97ccf0ddd2be 100644
--- a/sound/soc/codecs/da7213.h
+++ b/sound/soc/codecs/da7213.h
@@ -535,10 +535,12 @@ struct da7213_priv {
 	struct regulator_bulk_data supplies[DA7213_NUM_SUPPLIES];
 	struct clk *mclk;
 	unsigned int mclk_rate;
+	unsigned int out_rate;
 	int clk_src;
 	bool master;
 	bool alc_calib_auto;
 	bool alc_en;
+	bool fixed_clk_auto_pll;
 	struct da7213_platform_data *pdata;
 };
 
-- 
2.27.0

