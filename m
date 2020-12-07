Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C072D1123
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgLGM4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:56:04 -0500
Received: from aposti.net ([89.234.176.197]:59448 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgLGM4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:56:04 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/5] ASoC: codecs/jz4770: Adjust timeouts for cap-coupled outputs
Date:   Mon,  7 Dec 2020 12:53:35 +0000
Message-Id: <20201207125338.119397-3-paul@crapouillou.net>
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Branchereau <cbranchereau@gmail.com>

When using cap-coupled outputs, the RUP/RDO can take much longer than
the 100ms timeout we used to have. Increase that timeout to one second.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 002f2300e750..0da966785aee 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -287,7 +287,7 @@ static int jz4770_codec_mute_stream(struct snd_soc_dai *dai, int mute, int direc
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
 					       val, val & gain_bit,
-					       1000, 100 * USEC_PER_MSEC);
+					       1000, 1 * USEC_PER_SEC);
 		if (err) {
 			dev_err(jz_codec->dev,
 				"Timeout while setting digital mute: %d", err);
@@ -381,7 +381,7 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
 					       val, val & REG_IFR_RUP,
-					       1000, 100 * USEC_PER_MSEC);
+					       1000, 1 * USEC_PER_SEC);
 		if (err) {
 			dev_err(jz_codec->dev, "RUP timeout: %d", err);
 			return err;
@@ -401,7 +401,7 @@ static int hpout_event(struct snd_soc_dapm_widget *w,
 		err = regmap_read_poll_timeout(jz_codec->regmap,
 					       JZ4770_CODEC_REG_IFR,
 					       val, val & REG_IFR_RDO,
-					       1000, 100 * USEC_PER_MSEC);
+					       1000, 1 * USEC_PER_SEC);
 		if (err) {
 			dev_err(jz_codec->dev, "RDO timeout: %d", err);
 			return err;
@@ -803,7 +803,7 @@ static int jz4770_codec_io_wait(struct jz_codec *codec)
 
 	return readl_poll_timeout(codec->base + ICDC_RGADW_OFFSET, reg,
 				  !(reg & ICDC_RGADW_RGWR),
-				  1000, 10 * USEC_PER_MSEC);
+				  1000, 1 * USEC_PER_SEC);
 }
 
 static int jz4770_codec_reg_read(void *context, unsigned int reg,
-- 
2.29.2

