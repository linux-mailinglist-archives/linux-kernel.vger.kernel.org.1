Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554C52995CD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790543AbgJZSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:52:58 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45771 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790504AbgJZSww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id e17so13877424wru.12;
        Mon, 26 Oct 2020 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djM7OyfVgD6rWaDQbsh+ExufRJOlpqGGlwiwTkQsm9s=;
        b=XPITp7Mn/F7ykF8dNJcHLgRgIoXgXlp/x/xHlDBwv4gzqpHQZIFPutG/5sI+OJlIMK
         fiWQqhIt68mai1qt8GzW8z4MKvGRb/YwhrU7cNjkfYjUC2FC1w5FcqiGb4dZaOxoJc6V
         inp2DbSQjsd7THaT8b9AgiVKvxbb49QaM3wMvOHA2/NMV0UhRh3XBgul+DBqbINOPjHh
         nDaOr+s1DRoERDgX/yXQRF8q6811drP5IHIstzDRneRb9RfqbltzeNt7O0Fr+fxUHwEN
         BHzcVtIxco2ocKBM6Ljsd79OSMLetjsLJdcVxKYy5H+YvH6+ZE0WRxG88hKVPyPW2FfI
         /OjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djM7OyfVgD6rWaDQbsh+ExufRJOlpqGGlwiwTkQsm9s=;
        b=Xo0ObsbhQKG3awuj9NQ9m5X6lv1KoxmemCwZuYRn6ODjzdZzK7wCd5Bt/HbfkHYFqh
         jv4xS6Ev49bSQkQoGHzl0rbOs8e0ruvzrRZdnSqVCwBjstEFyHvYkIzWeYnUi7yXVj8v
         rwy56bigBs1DzHIvSTwEszDslLLL+oFWZtFo/U7VChttBc6PDZ1Jbx632cX7kjOV6YKY
         +3DmFYnZEGN45YG9Ejji+Hk8xqEE13NxtX+nK4IHefSO0xNKst0ZZ4aew5Ei/VOECGBg
         E0wrTxVOPNAUxArr6kSdsnBTjOR2zt2slkmuVOD3QtLRbDbuKwsR6Xu01gt+rRvK5Z/9
         5e4g==
X-Gm-Message-State: AOAM533WdVRW9ZMgQZRViV6zyCejoA4PPN8V4dNm5OCHelFNd452Oc6D
        57ZANcDV+4U4AdhFSSbXPug=
X-Google-Smtp-Source: ABdhPJwo6Q8s0AOAx3BYAVnRxx4Uhh3HP4/cvorgqun4R1kWEC8iSfm/uBzLSX1PyYGm0OnWIf8i1A==
X-Received: by 2002:adf:f20e:: with SMTP id p14mr455926wro.376.1603738368761;
        Mon, 26 Oct 2020 11:52:48 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:47 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v8 05/14] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Mon, 26 Oct 2020 19:52:30 +0100
Message-Id: <20201026185239.379417-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Extend the functionality of the driver to include support of 20 and
24 bits per sample.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index beaca56a44ae..eee1e64cd8f4 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -599,6 +599,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1080,6 +1083,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1087,14 +1094,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.playback = {
 		.stream_name = "Playback",
 		.channels_min = 1,
 		.channels_max = 8,
 		.rates = SNDRV_PCM_RATE_8000_192000,
-		.formats = SNDRV_PCM_FMTBIT_S16_LE,
+		.formats = SUN4I_FORMATS,
 	},
 	.ops = &sun4i_i2s_dai_ops,
 	.symmetric_rates = 1,
-- 
2.25.1

