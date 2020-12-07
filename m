Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37F02D1138
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLGM5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:57:38 -0500
Received: from aposti.net ([89.234.176.197]:59886 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLGM5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:57:37 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 5/5] ASoC: codecs/jz4770: Add DAPM widget to set HP out to cap-less mode
Date:   Mon,  7 Dec 2020 12:53:37 +0000
Message-Id: <20201207125338.119397-5-paul@crapouillou.net>
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cap-less mode is useful e.g. if the headphones are used as an antenna
for a FM radio, so that the signal is not altered. For everything else,
we want the cap-couple mode.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 909b70e817b4..c9fe7f72bfcb 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -98,7 +98,7 @@ enum {
 #define REG_CR_HP_MUTE			BIT(7)
 #define REG_CR_HP_LOAD			BIT(6)
 #define REG_CR_HP_SB_OFFSET		4
-#define REG_CR_HP_SB_HPCM		BIT(3)
+#define REG_CR_HP_SB_HPCM_OFFSET	3
 #define REG_CR_HP_SEL_OFFSET		0
 #define REG_CR_HP_SEL_MASK		(0x3 << REG_CR_HP_SEL_OFFSET)
 
@@ -519,6 +519,9 @@ static const struct snd_soc_dapm_widget jz4770_codec_dapm_widgets[] = {
 	SND_SOC_DAPM_SUPPLY("MICBIAS", JZ4770_CODEC_REG_CR_MIC,
 			    REG_CR_MIC_BIAS_SB_OFFSET, 1, NULL, 0),
 
+	SND_SOC_DAPM_SUPPLY("Cap-less", JZ4770_CODEC_REG_CR_HP,
+			    REG_CR_HP_SB_HPCM_OFFSET, 1, NULL, 0),
+
 	SND_SOC_DAPM_INPUT("MIC1P"),
 	SND_SOC_DAPM_INPUT("MIC1N"),
 	SND_SOC_DAPM_INPUT("MIC2P"),
@@ -640,7 +643,8 @@ static void jz4770_codec_codec_init_regs(struct snd_soc_component *codec)
 	regmap_set_bits(regmap, JZ4770_CODEC_REG_CR_ADC, REG_CR_ADC_LRSWAP);
 
 	/* default to cap-less mode(0) */
-	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_HP, REG_CR_HP_SB_HPCM);
+	regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_HP,
+			  BIT(REG_CR_HP_SB_HPCM_OFFSET));
 
 	/* Send collected updates. */
 	regcache_cache_only(regmap, false);
-- 
2.29.2

