Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC32D111F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgLGMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:55:18 -0500
Received: from aposti.net ([89.234.176.197]:59224 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbgLGMzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:55:17 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     od@zcrc.me, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 2/5] ASoC: codecs/jz4770: Reset interrupt flags in bias PREPARE
Date:   Mon,  7 Dec 2020 12:53:34 +0000
Message-Id: <20201207125338.119397-2-paul@crapouillou.net>
In-Reply-To: <20201207125338.119397-1-paul@crapouillou.net>
References: <20201207125338.119397-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Branchereau <cbranchereau@gmail.com>

In case a poll for RUP times out, we might be left with some IRQ flags
that should be cleared before the next power on.

Signed-off-by: Christophe Branchereau <cbranchereau@gmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 sound/soc/codecs/jz4770.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index c6b2043f31a9..002f2300e750 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -190,6 +190,9 @@ static int jz4770_codec_set_bias_level(struct snd_soc_component *codec,
 
 	switch (level) {
 	case SND_SOC_BIAS_PREPARE:
+		/* Reset all interrupt flags. */
+		regmap_write(regmap, JZ4770_CODEC_REG_IFR, REG_IFR_ALL_MASK);
+
 		regmap_clear_bits(regmap, JZ4770_CODEC_REG_CR_VIC,
 				  REG_CR_VIC_SB);
 		msleep(250);
@@ -642,9 +645,6 @@ static void jz4770_codec_codec_init_regs(struct snd_soc_component *codec)
 	/* Send collected updates. */
 	regcache_cache_only(regmap, false);
 	regcache_sync(regmap);
-
-	/* Reset all interrupt flags. */
-	regmap_write(regmap, JZ4770_CODEC_REG_IFR, REG_IFR_ALL_MASK);
 }
 
 static int jz4770_codec_codec_probe(struct snd_soc_component *codec)
-- 
2.29.2

