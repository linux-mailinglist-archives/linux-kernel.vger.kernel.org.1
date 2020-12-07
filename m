Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA422D1128
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgLGM4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:56:51 -0500
Received: from aposti.net ([89.234.176.197]:59658 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgLGM4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:56:51 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/5] ASoC: codecs/jz4770: Don't change cap-couple setting in HP PMU/PMD
Date:   Mon,  7 Dec 2020 12:53:36 +0000
Message-Id: <20201207125338.119397-4-paul@crapouillou.net>
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is simply no reason to do that.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 0da966785aee..909b70e817b4 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -371,9 +371,9 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		/* set cap-less, unmute HP */
+		/* unmute HP */
 		regmap_clear_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
-				  REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
+				  REG_CR_HP_MUTE);
 		break;
 
 	case SND_SOC_DAPM_POST_PMU:
@@ -394,9 +394,9 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		break;
 
 	case SND_SOC_DAPM_POST_PMD:
-		/* set cap-couple, mute HP */
+		/* mute HP */
 		regmap_set_bits(jz_codec->regmap, JZ4770_CODEC_REG_CR_HP,
-				REG_CR_HP_SB_HPCM | REG_CR_HP_MUTE);
+				REG_CR_HP_MUTE);
 
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
-- 
2.29.2

