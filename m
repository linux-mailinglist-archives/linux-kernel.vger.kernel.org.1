Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BA927A29C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgI0T3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgI0T30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:26 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0A5C0613CE;
        Sun, 27 Sep 2020 12:29:26 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e2so4633507wme.1;
        Sun, 27 Sep 2020 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JlxXAFB85DXviVVzU9snS3b51VMvFbEM+bK6288hNSg=;
        b=LLJ61lgaZTOMqpVlNPKwbccLGS/qKNP3TcbScbdHfhnJ57en1huY00FJx1oxE1n3LB
         124K55B/1sRjka5yKE1J3I6Bx58rgfrPkKft9px1ggdQiNp1KYYH6mcOoSr13ZFI1Me8
         NjNsx91mcPoB3s1koIWgwyg1jI2nX46eb+A383oA79ZuafsEv3KxKDGB2Ft5n5y52kAT
         Vbp7+spDWmRGv7zWxrdI8KJRymtbX6OF4cFQwwwBi8Xt2siPVqkJQMMR9LyGgf99g+eW
         bPaIaLUKmrj2trNfxDerkD8x9CzfwYQBI2WDsaE5rzUWF/QHzUTnHkJmu3/ybWAPMx5l
         piRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JlxXAFB85DXviVVzU9snS3b51VMvFbEM+bK6288hNSg=;
        b=K1248n8MUKA08mMfjcy/wKYVDUZLS1+0T3qiKvkzEKLJbQqrVpLhSE0ltG/1Z/1TPi
         4Iziq90zcPR/XqCRSnEj6ovOaZ5MRDLyD4dOAIo7jDfBklU7MTytMFcFLBBLPVLCrIxo
         DBlJEs3o4dL2jpdIf1GTblIa/apP33tXwucJePdmpYqhn2uzmuctGgGEaD6Y5bNx0TDy
         i51O2kE5lAOE+eJhwGSwj7oKsujvSqcWRoWIOSF7eczBlWYV2c+cFlmlrzwNUMDqoWt+
         sllK11bLU9SLfpmaxsybXKaaR0ujeiYyR4t3wrYYhtcJYnFPpWklQIz7dyAfNE40hEWL
         gAfA==
X-Gm-Message-State: AOAM533SazOs/JrKX7c2I+cggI2tmkIqfujZlN8w6sZhgESGASKJjlHD
        MthuS0F7530Rc8H/Yg/CyxU=
X-Google-Smtp-Source: ABdhPJzU+oCRv5cPGJT6Jhm1gGotghAHe7SKA1ZenbPaXNMkpCnPCWNF1TQAQSwhJCnE9s5ZUCum2A==
X-Received: by 2002:a1c:e046:: with SMTP id x67mr7969163wmg.35.1601234964796;
        Sun, 27 Sep 2020 12:29:24 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:24 -0700 (PDT)
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
Subject: [PATCH v5 06/20] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sun, 27 Sep 2020 21:28:58 +0200
Message-Id: <20200927192912.46323-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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
Signed-off-by: Clément Péron <peron.clem@gmail.com>
Acked-by: Maxime Ripard <mripard@kernel.org>
---
 sound/soc/sunxi/sun4i-i2s.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index b31454eee43c..60b2fec1bbe9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -590,6 +590,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1071,6 +1074,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1078,14 +1085,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

