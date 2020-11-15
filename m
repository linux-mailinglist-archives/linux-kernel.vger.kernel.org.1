Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F72B34E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgKOMVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:21:11 -0500
Received: from host.euro-space.net ([87.117.239.2]:50016 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgKOMVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:21:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lSKGQVXPSHX0skNYBLYzXitfSJXzhSyFEZz78vGIj8M=; b=YRz0lGti8eka6i7JgfTMSIYkKe
        9+yixpkRZyF4M/h+MoYLz5//t0dElTrYoO/M6mLO+ufl4A3CqZQCO8gxvRhheLSXZ3ZiSsU0rh9Nq
        oAftNz5cv/umAOk0rup651Ix79iZkoTttO2KcRFuM2O4NFtLpqNwuav9OLBqRCjoAoj4ZX1cf0oPv
        WuSDpiddyNz5G1sYBcLky9wJTvJeIFhRyjpsAiUt+7iv31Td0Ju8gZ3uu/RMXkv4cX4H+LTNaPVaQ
        fftCYiI2GqHLUHEwZyHgeKO+1fs282BHEFI5c+ij5H0ceM3fv0N9o6CiDkDKaZPNHxCcobCp7R2xy
        xBTnw+ZQ==;
Received: from dynamic-078-054-118-130.78.54.pool.telefonica.de ([78.54.118.130]:55232 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1keH1m-000338-72; Sun, 15 Nov 2020 12:21:06 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: [PATCH v3 3/4] ASoC: pcm512x: Move format check into `set_fmt()`
Date:   Sun, 15 Nov 2020 13:23:05 +0100
Message-Id: <20201115122306.18164-4-kmarinushkin@birdec.com>
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

I would like to describe the reasoning by quoting Peter Ujfalusi
<peter.ujfalusi@ti.com> from his review of this patch series v1 [1]:

> When you bind a link you will use set_fmt for the two sides to see if
> they can agree, that both can support what has been asked.
>
> The pcm512x driver just saves the fmt and say back to that card:
> whatever, I'm fine with it. But runtime during hw_params it can fail due
> to unsupported bus format, which it actually acked to be ok.
>
> This is the difference.
>
> Sure, some device have constraint based on the fmt towards the hw_params
> and it is perfectly OK to do such a checks and rejections or build
> rules/constraints based on fmt, but failing hw_params just because
> set_fmt did not checked that the bus format is not even supported is not
> a nice thing to do.

[1] https://patchwork.kernel.org/project/alsa-devel/patch/
    20201109212133.25869-1-kmarinushkin@birdec.com/

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
 sound/soc/codecs/pcm512x.c | 55 +++++++++++++++++++++++++---------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index aa55a477a28f..22ef77955a28 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1168,8 +1168,6 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
 	int alen;
 	int gpio;
-	int clock_output;
-	int master_mode;
 	int ret;
 
 	dev_dbg(component->dev, "hw_params %u Hz, %u channels\n",
@@ -1202,11 +1200,8 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
-		clock_output = 0;
-		master_mode = 0;
-
+	if ((pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) ==
+	    SND_SOC_DAIFMT_CBS_CFS) {
 		ret = regmap_update_bits(pcm512x->regmap, PCM512x_ERROR_DETECT,
 					 PCM512x_DCAS, 0);
 		if (ret != 0) {
@@ -1216,16 +1211,6 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 			return ret;
 		}
 		goto skip_pll;
-	case SND_SOC_DAIFMT_CBM_CFM:
-		clock_output = PCM512x_BCKO | PCM512x_LRKO;
-		master_mode = PCM512x_RLRK | PCM512x_RBCK;
-		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
-		clock_output = PCM512x_BCKO;
-		master_mode = PCM512x_RBCK;
-		break;
-	default:
-		return -EINVAL;
 	}
 
 	if (pcm512x->pll_out) {
@@ -1343,6 +1328,34 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 	}
 
 skip_pll:
+	return 0;
+}
+
+static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
+{
+	struct snd_soc_component *component = dai->component;
+	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	int clock_output;
+	int master_mode;
+	int ret;
+
+	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+		clock_output = 0;
+		master_mode = 0;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFM:
+		clock_output = PCM512x_BCKO | PCM512x_LRKO;
+		master_mode = PCM512x_RLRK | PCM512x_RBCK;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+		clock_output = PCM512x_BCKO;
+		master_mode = PCM512x_RBCK;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	ret = regmap_update_bits(pcm512x->regmap, PCM512x_BCLK_LRCLK_CFG,
 				 PCM512x_BCKP | PCM512x_BCKO | PCM512x_LRKO,
 				 clock_output);
@@ -1359,14 +1372,6 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
-	return 0;
-}
-
-static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
-{
-	struct snd_soc_component *component = dai->component;
-	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
-
 	pcm512x->fmt = fmt;
 
 	return 0;
-- 
2.13.6

