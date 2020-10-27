Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68329C76A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828436AbgJ0ScG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55369 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828410AbgJ0ScA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:00 -0400
Received: by mail-wm1-f67.google.com with SMTP id a72so2311724wme.5;
        Tue, 27 Oct 2020 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bUF5LSgnsfdi9Dmz32t5Nlmik5QNgZUZsDGC5+lF6a4=;
        b=hZqDATcv7sSLnWgYfAMp+DE8B3SYkc7T1qPxhtHamQ8G9lmchPk2WzxorNxeTFrJWd
         5uTBtwsOaTvNyQ6H/UDRhnF2uVgsRX2zywHbu9x2yodGCI6OKL80PBolnrHeKFI1SOqi
         TGVVCyPJxqU6+7lnohzcVFnrUkWGtpPQ0vEXUxGVKxn3T8TOTORluO1rcmkO2bovYqbT
         0VJ8i3cdlPDd5TfiNW71oWgaXMXWrZMyTi0muxL1XywTxNOIv0MRcwLNMROJjuhI/+zt
         tcDtM6ijantgPtcIIgzWuac7mgj30zYs6eXj3sHdzo1Jvm1rjKrjbJUX1zbeme8MHnKa
         uwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bUF5LSgnsfdi9Dmz32t5Nlmik5QNgZUZsDGC5+lF6a4=;
        b=UyGeJSKEGrnnLWA83rIBilv3XD4B0cvIrITCjjLvzmZOQfn1cC9oOJkOUKqIEFXzS2
         +kC+RdFNSlIkwF5jNcsaNWWYeONN0g8S4Nr/oPdd4jcfNyVHSjWy7OUE4A7K4+0HGad7
         Bjhh2TxmSI9+ur41MOThIIdlxg/mt3M1V8mDBLp3azz63n2nuPH+nltYLNpUTiKusfTj
         jlTzKv1GvHN3JOzyb/R9VsDnRfoPoTBSZTtyuswvAszDaC+XGJ2cb0kjFt1g94TJo4wl
         NmeQLK89B92GorDykzpZI4ShZMrdn4mrhNa0bdBc4v5s0v5lbIeezEl7k7lzwzUp3Ig5
         7yWQ==
X-Gm-Message-State: AOAM530d8KfAwY5I/NN/QqG3vd1p084vezmJY0X6Bgt51ygpUtDGDrfO
        evaTo1XptGZ9Dxp5cb0fVg4=
X-Google-Smtp-Source: ABdhPJxjwsMwLtBKVCXnxljYQoMq6SnwnRLll3li843xrx/nJ4SWKVIUQOMkaz8TmPSCbRJjnMpaiA==
X-Received: by 2002:a05:600c:cb:: with SMTP id u11mr3924703wmm.112.1603823517828;
        Tue, 27 Oct 2020 11:31:57 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:31:57 -0700 (PDT)
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
Subject: [PATCH v9 05/14] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Tue, 27 Oct 2020 19:31:40 +0100
Message-Id: <20201027183149.145165-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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
index 9f9d3e7baad0..39b56d0de1fd 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -600,6 +600,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1081,6 +1084,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1088,14 +1095,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

