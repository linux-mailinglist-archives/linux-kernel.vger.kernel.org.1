Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254482666B7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 19:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgIKRbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 13:31:52 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:59585 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgIKRbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 13:31:46 -0400
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E70E91BF209;
        Fri, 11 Sep 2020 17:31:43 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 2/3] ASoC: tlv320aic32x4: Fix bdiv clock rate derivation
Date:   Fri, 11 Sep 2020 19:31:39 +0200
Message-Id: <20200911173140.29984-3-miquel.raynal@bootlin.com>
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

Current code expects a single channel to be always used. Fix this
situation by forwarding the number of channels used. Then fix the
derivation of the bdiv clock rate.

Fixes: 96c3bb00239d ("ASoC: tlv320aic32x4: Dynamically Determine Clocking")
Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 68165de1c8de..7a1ffbaf48be 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -662,7 +662,7 @@ static int aic32x4_set_processing_blocks(struct snd_soc_component *component,
 }
 
 static int aic32x4_setup_clocks(struct snd_soc_component *component,
-				unsigned int sample_rate)
+				unsigned int sample_rate, unsigned int channels)
 {
 	u8 aosr;
 	u16 dosr;
@@ -750,7 +750,9 @@ static int aic32x4_setup_clocks(struct snd_soc_component *component,
 							dosr);
 
 						clk_set_rate(clocks[5].clk,
-							sample_rate * 32);
+							sample_rate * 32 *
+							channels);
+
 						return 0;
 					}
 				}
@@ -772,7 +774,8 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	u8 iface1_reg = 0;
 	u8 dacsetup_reg = 0;
 
-	aic32x4_setup_clocks(component, params_rate(params));
+	aic32x4_setup_clocks(component, params_rate(params),
+			     params_channels(params));
 
 	switch (params_width(params)) {
 	case 16:
-- 
2.20.1

