Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB6C1CDB23
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 15:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgEKNZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 09:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729555AbgEKNZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:25:52 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEBAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:25:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 184F72A1629
Received: by jupiter.universe (Postfix, from userid 1000)
        id E7BA7480105; Mon, 11 May 2020 15:25:45 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv3 5/5] ASoC: da7213: add default clock handling
Date:   Mon, 11 May 2020 15:25:44 +0200
Message-Id: <20200511132544.82364-6-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511132544.82364-1-sebastian.reichel@collabora.com>
References: <20200511132544.82364-1-sebastian.reichel@collabora.com>
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
 sound/soc/codecs/da7213.c | 76 ++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/da7213.h |  2 ++
 2 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3e6ad996741b..4a0edd3b7f83 100644
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
@@ -1532,6 +1553,43 @@ static struct snd_soc_dai_driver da7213_dai = {
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
+	if (enable)
+		mode = DA7213_SYSCLK_PLL;
+	else
+		mode = DA7213_SYSCLK_MCLK;
+
+	switch (da7213->out_rate) {
+	case DA7213_PLL_FREQ_OUT_90316800:
+		if (da7213->mclk_rate == 11289600 ||
+		    da7213->mclk_rate == 22579200 ||
+		    da7213->mclk_rate == 45158400)
+			mode = DA7213_SYSCLK_MCLK;
+		break;
+	case DA7213_PLL_FREQ_OUT_98304000:
+		if (da7213->mclk_rate == 12288000 ||
+		    da7213->mclk_rate == 24576000 ||
+		    da7213->mclk_rate == 49152000)
+			mode = DA7213_SYSCLK_MCLK;
+
+		break;
+	default:
+		return -1;
+	}
+
+	return _da7213_set_component_pll(component, 0, mode,
+					 da7213->mclk_rate, da7213->out_rate);
+}
+
 static int da7213_set_bias_level(struct snd_soc_component *component,
 				 enum snd_soc_bias_level level)
 {
@@ -1551,6 +1609,8 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
 						"Failed to enable mclk\n");
 					return ret;
 				}
+
+				da7213_set_auto_pll(component, true);
 			}
 		}
 		break;
@@ -1562,8 +1622,10 @@ static int da7213_set_bias_level(struct snd_soc_component *component,
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
@@ -1693,7 +1755,6 @@ static struct da7213_platform_data
 	return pdata;
 }
 
-
 static int da7213_probe(struct snd_soc_component *component)
 {
 	struct da7213_priv *da7213 = snd_soc_component_get_drvdata(component);
@@ -1829,6 +1890,11 @@ static int da7213_probe(struct snd_soc_component *component)
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
2.26.2

