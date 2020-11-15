Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF822B34E4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgKOMVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:21:18 -0500
Received: from host.euro-space.net ([87.117.239.2]:40155 "EHLO
        host.euro-space.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbgKOMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=birdec.com;
         s=default; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4oo0hbU3ekJrFD+VdnDUAiKmeIwqAfw/S+FCziusOw8=; b=ZvPNc9KZ1E2+p70iK6KumfJCD0
        NQLvMh+pnmK/PaZXKvk1PKKwazky/Y/AyRhUkUj+Cir9b93pkkMwj5zmXbx0vxH5x77NkiimzQFJd
        /ntmNkYvI4zTaquKFJFDtnfXJCFIHmFWMvgmx2MuwYYusMSsCzO2KiKgKXEYNoSmtHKlUnI+hMySu
        PgSSV+E8DFxVR2JRNpzk48XfDQmO9XC9U/tabduNK6kMhCkJfhRPiblQrFGS/adjM6OmMixhJ3QMz
        r8cXfzA07wuDdGkEsf+Orp2Ke1Z90T/hve02Rhl2SpqX1YOcwp8QNCIjefLgFxqVGBhiLdNVZKJeO
        f1uIGFOg==;
Received: from dynamic-078-054-118-130.78.54.pool.telefonica.de ([78.54.118.130]:55232 helo=gentoo0.localdomain)
        by host.euro-space.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <kmarinushkin@birdec.com>)
        id 1keH1u-000338-Qb; Sun, 15 Nov 2020 12:21:14 +0000
From:   Kirill Marinushkin <kmarinushkin@birdec.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Matthias Reichl <hias@horus.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Kirill Marinushkin <kmarinushkin@birdec.com>
Subject: [PATCH v3 4/4] ASoC: pcm512x: Add support for more data formats
Date:   Sun, 15 Nov 2020 13:23:06 +0100
Message-Id: <20201115122306.18164-5-kmarinushkin@birdec.com>
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

Currently, pcm512x driver supports only I2S data format.
This commit adds RJ, LJ, DSP_A and DSP_B as well.

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
 sound/soc/codecs/pcm512x.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/sound/soc/codecs/pcm512x.c b/sound/soc/codecs/pcm512x.c
index 22ef77955a28..4dc844f3c1fc 100644
--- a/sound/soc/codecs/pcm512x.c
+++ b/sound/soc/codecs/pcm512x.c
@@ -1335,6 +1335,8 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
 	struct snd_soc_component *component = dai->component;
 	struct pcm512x_priv *pcm512x = snd_soc_component_get_drvdata(component);
+	int afmt;
+	int offset = 0;
 	int clock_output;
 	int master_mode;
 	int ret;
@@ -1372,6 +1374,42 @@ static int pcm512x_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return ret;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		afmt = PCM512x_AFMT_I2S;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		afmt = PCM512x_AFMT_RTJ;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		afmt = PCM512x_AFMT_LTJ;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		offset = 1;
+		fallthrough;
+	case SND_SOC_DAIFMT_DSP_B:
+		afmt = PCM512x_AFMT_DSP;
+		break;
+	default:
+		dev_err(component->dev, "unsupported DAI format: 0x%x\n",
+			pcm512x->fmt);
+		return -EINVAL;
+	}
+
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_1,
+				 PCM512x_AFMT, afmt);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to set data format: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_update_bits(pcm512x->regmap, PCM512x_I2S_2,
+				 0xFF, offset);
+	if (ret != 0) {
+		dev_err(component->dev, "Failed to set data offset: %d\n", ret);
+		return ret;
+	}
+
 	pcm512x->fmt = fmt;
 
 	return 0;
-- 
2.13.6

