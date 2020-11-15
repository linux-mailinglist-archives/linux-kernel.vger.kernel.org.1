Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51882B34E2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgKOMVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:21:09 -0500
Received: from host.euro-space.net ([87.117.239.2]:56382 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKOMVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:21:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3DS/oTYDN8+O79A+7WTTW5ETsjJABZbWKbWErfdWpPk=; b=pHux+tYEXSyXrGv5uxQqGxJOG7
        ZH+X7KKiRxlSjf0VeeKY39gTpVXxyEqdKAx+YnQua4jb3EsaGf9cUw/gZ/TC5HsVoDDJPZJvWGNUm
        hu3KquzN4Twes0v6k4WQqHNsCdmzi5fCfZWVK2kCdCs4lV6HH7TxkjNGHQjIukVbk5+LT2oummp9S
        EZNIccKc8pyxmNiltif8ZH/xeOwRsNVFA103dcMPyDa5/e19bpUFwvu5jO2fJTYJAdCO+UNddvjjF
        NBFSP9QVuHSZXgmvrb7sFu7ESR2Gl/UJKCCOGaKomf9+86oGgsZ8oxIDKLK/njDq/xdph31KgrbpZ
        74xfu7jw==;
Received: from dynamic-078-054-118-130.78.54.pool.telefonica.de ([78.54.118.130]:55232 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1keH1k-000338-M0; Sun, 15 Nov 2020 12:21:04 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: [PATCH v3 2/4] ASoC: pcm512x: Rearrange operations in `hw_params()`
Date:   Sun, 15 Nov 2020 13:23:04 +0100
Message-Id: <20201115122306.18164-3-kmarinushkin@birdec.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20201115122306.18164-1-kmarinushkin@birdec.com>
References: <20201115122306.18164-1-kmarinushkin@birdec.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.euro-space.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - birdec.com
X-Get-Message-Sender-Via: host.euro-space.net: authenticated_id: kmarinushkin@birdec.com
X-Authenticated-Sender: host.euro-space.net: kmarinushkin@birdec.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit is a preparation for the next patch in the series.
It's goal is to make format check easy-to-move-out. Theoretically, more
butifications are possile in `hw_params()` func, but my intention in this
commit is to keep behaviour unchanged.

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Matthias Reichl <hias@horus.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/pcm512x.c | 49 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index db3dc6a40feb..aa55a477a28f 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1204,16 +1204,8 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 
 	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
-		ret = regmap_update_bits(pcm512x->regmap,
-					 PCM512x_BCLK_LRCLK_CFG,
-					 PCM512x_BCKP
-					 | PCM512x_BCKO | PCM512x_LRKO,
-					 0);
-		if (ret != 0) {
-			dev_err(component->dev,
-				"Failed to enable slave mode: %d\n", ret);
-			return ret;
-		}
+		clock_output = 0;
+		master_mode = 0;
 
 		ret = regmap_update_bits(pcm512x->regmap, PCM512x_ERROR_DETECT,
 					 PCM512x_DCAS, 0);
@@ -1223,7 +1215,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 				ret);
 			return ret;
 		}
-		return 0;
+		goto skip_pll;
 	case SND_SOC_DAIFMT_CBM_CFM:
 		clock_output = PCM512x_BCKO | PCM512x_LRKO;
 		master_mode = PCM512x_RLRK | PCM512x_RBCK;
@@ -1316,25 +1308,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 			dev_err(component->dev, "Failed to enable pll: %d\n", ret);
 			return ret;
 		}
-	}
-
-	ret = regmap_update_bits(pcm512x->regmap, PCM512x_BCLK_LRCLK_CFG,
-				 PCM512x_BCKP | PCM512x_BCKO | PCM512x_LRKO,
-				 clock_output);
-	if (ret != 0) {
-		dev_err(component->dev, "Failed to enable clock output: %d\n", ret);
-		return ret;
-	}
 
-	ret = regmap_update_bits(pcm512x->regmap, PCM512x_MASTER_MODE,
-				 PCM512x_RLRK | PCM512x_RBCK,
-				 master_mode);
-	if (ret != 0) {
-		dev_err(component->dev, "Failed to enable master mode: %d\n", ret);
-		return ret;
-	}
-
-	if (pcm512x->pll_out) {
 		gpio = PCM512x_G1OE << (pcm512x->pll_out - 1);
 		ret = regmap_update_bits(pcm512x->regmap, PCM512x_GPIO_EN,
 					 gpio, gpio);
@@ -1368,6 +1342,23 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+skip_pll:
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_BCLK_LRCLK_CFG,
+				 PCM512x_BCKP | PCM512x_BCKO | PCM512x_LRKO,
+				 clock_output);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to enable clock output: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_MASTER_MODE,
+				 PCM512x_RLRK | PCM512x_RBCK,
+				 master_mode);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to enable master mode: %d\n", ret);
+		return ret;
+	}
+
 	return 0;
 }
 
-- 
2.13.6

