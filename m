Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6662AC773
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbgKIVk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 16:40:58 -0500
Received: from host.euro-space.net ([87.117.239.2]:50321 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729451AbgKIVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:40:57 -0500
X-Greylist: delayed 1286 seconds by postgrey-1.27 at vger.kernel.org; Mon, 09 Nov 2020 16:40:56 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
        :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CYkwsVIaLlOhxjKhcFdBd4Owd+Ss0IqNzEdDmO2watg=; b=aS05Lz9Ugh7EwhcU6cpwgxoyO+
        uvZRCfsKa7rs3aM2zDjLcAfOB5D8qYnGE2KHOgSifm/6dHs4T7+AaTC16+GV6l9s0KnKRGjrocGc8
        wQTkumOW8EdLP7MJlXmUYSrc+SIuhjZruPuybI4VqxJQrtTn4J7ObqxSbrFFTY33hf7KYXN5AKmWg
        fE+XZy1wJ1cQB2ap9ZFksXU4Fy1924ZWH3zFcMNwbHtYrSOAnwVZqBql1bfkMb+dFtEkvL2y/TObM
        y4rUODXpkFxxvmAuqiPtLDNu1I3ozklnpaDYynjwYiSliRvybicJd8wcXVFgP8JXSsHX7jjy5fxHP
        gAMif7kA==;
Received: from dynamic-089-014-103-027.89.14.pool.telefonica.de ([89.14.103.27]:44520 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1kcEZS-0000xS-SE; Mon, 09 Nov 2020 21:19:26 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: [PATCH] ASoC: pcm512x: Add support for data formats RJ and LJ
Date:   Mon,  9 Nov 2020 22:21:33 +0100
Message-Id: <20201109212133.25869-1-kmarinushkin@birdec.com>
X-Mailer: git-send-email 2.13.6
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

Currently, pcm512x driver supports only I2S data format.
This commit adds RJ and LJ as well.

I don't expect regression WRT existing sound cards, because:

* default value in corresponding register of pcm512x codec is 0 ==  I2S
* existing in-tree sound cards with pcm512x codec are configured for I2S
* i don't see how existing off-tree sound cards with pcm512x codec could be
  configured differently - it would not work
* tested explicitly, that there is no regression with Raspberry Pi +
  sound card `sound/soc/bcm/hifiberry_dacplus.c`

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
 sound/soc/codecs/pcm512x.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 8153d3d01654..c6e975fb4a43 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1167,6 +1167,7 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_component *component = dai->component;
 	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
 	int alen;
+	int afmt;
 	int gpio;
 	int clock_output;
 	int master_mode;
@@ -1195,6 +1196,22 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	switch (pcm512x->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		afmt = PCM512x_AFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		afmt = PCM512x_AFMT_RTJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		afmt = PCM512x_AFMT_LTJ;
+		break;
+	default:
+		dev_err(component->dev, "unsupported DAI format: 0x%x\n",
+			pcm512x->fmt);
+		return -EINVAL;
+	}
+
 	switch (pcm512x->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		ret = regmap_update_bits(pcm512x->regmap,
@@ -1236,6 +1253,13 @@ static int pcm512x_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
+				 PCM512x_AFMT, afmt);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to set data format: %d\n", ret);
+		return ret;
+	}
+
 	if (pcm512x->pll_out) {
 		ret = regmap_write(pcm512x->regmap, PCM512x_FLEX_A, 0x11);
 		if (ret != 0) {
-- 
2.13.6

