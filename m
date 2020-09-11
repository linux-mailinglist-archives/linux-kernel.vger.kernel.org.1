Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2DF2666BB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgIKRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:31:56 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:60581 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbgIKRbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:31:47 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 0AE131BF20F;
        Fri, 11 Sep 2020 17:31:44 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 3/3] ASoC: tlv320aic32x4: Enable fast charge
Date:   Fri, 11 Sep 2020 19:31:40 +0200
Message-Id: <20200911173140.29984-4-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911173140.29984-1-miquel.raynal@bootlin.com>
References: <20200911173140.29984-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At power-up the analog circuits may take up to one full second before
being charged with the default configuration. Using the analog blocks
before they are ready generates a *very* crappy sound.

Enable the fast charge feature, which will require a bit more power
than normal charge but will definitely speed up the starting operation
by shrinking this delay to up to 40 ms.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 8 ++++++++
 sound/soc/codecs/tlv320aic32x4.h | 7 +++++++
 2 files changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 7a1ffbaf48be..5fb8ba109bc9 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1009,6 +1009,14 @@ static int aic32x4_component_probe(struct snd_soc_component *component)
 				AIC32X4_LADC_EN | AIC32X4_RADC_EN);
 	snd_soc_component_write(component, AIC32X4_ADCSETUP, tmp_reg);
 
+	/*
+	 * Enable the fast charging feature and ensure the needed 40ms ellapsed
+	 * before using the analog circuits.
+	 */
+	snd_soc_component_write(component, AIC32X4_REFPOWERUP,
+				AIC32X4_REFPOWERUP_40MS);
+	msleep(40);
+
 	return 0;
 }
 
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index 38f47704bb75..7550122e9f8a 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -96,6 +96,7 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_FLOATINGINPUT	AIC32X4_REG(1, 58)
 #define AIC32X4_LMICPGAVOL	AIC32X4_REG(1, 59)
 #define AIC32X4_RMICPGAVOL	AIC32X4_REG(1, 60)
+#define AIC32X4_REFPOWERUP	AIC32X4_REG(1, 123)
 
 /* Bits, masks, and shifts */
 
@@ -205,6 +206,12 @@ int aic32x4_register_clocks(struct device *dev, const char *mclk_name);
 #define AIC32X4_RMICPGANIN_IN1L_10K	0x10
 #define AIC32X4_RMICPGANIN_CM1R_10K	0x40
 
+/* AIC32X4_REFPOWERUP */
+#define AIC32X4_REFPOWERUP_SLOW		0x04
+#define AIC32X4_REFPOWERUP_40MS		0x05
+#define AIC32X4_REFPOWERUP_80MS		0x06
+#define AIC32X4_REFPOWERUP_120MS	0x07
+
 /* Common mask and enable for all of the dividers */
 #define AIC32X4_DIVEN           BIT(7)
 #define AIC32X4_DIV_MASK        GENMASK(6, 0)
-- 
2.20.1

