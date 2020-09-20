Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B1E2716B8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgITSId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgITSIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:15 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E861C0613D0;
        Sun, 20 Sep 2020 11:08:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d4so9964982wmd.5;
        Sun, 20 Sep 2020 11:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EIccKi4IoikLFt1GHmOwRkpQe5sR20G6j+WnVWrmvso=;
        b=mXfdBiakPfVTHfsCFaHAMPoqT6nvSS+bOVu2VRhbQjcn43WE9jQBGfLs7j4ue2O+ON
         VeOCEnerUl3WKulsPWkvXDrh85uAshFwYIBFsuJwufUciR5GxY9axZ2Epzxx+/FZeElh
         O/llYyDcUqA37WP3Ihml1IJebDSJap2tk3cLVO34w7Hx37rM+uG+KztoDz1ELtYkLUui
         JlF/GPKy5StNSS99nU5/2fYSH84za6Z6aAcILGnByHOLZt2Wt1hbE+ZeqNMyDxu+OLIk
         rAEyNDfBoG1q8aEbP2njunC7XS7XsZxCzgEHYMWSTQP54YeUfJykk12SemCwksbKUX9h
         drXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EIccKi4IoikLFt1GHmOwRkpQe5sR20G6j+WnVWrmvso=;
        b=BqKYUF6QlhSbUXK6FfNSL6S1xzZ9TDSISTgFSAge0NeWqNBBbTGXGFakr7Lr8dFvaz
         eYajCHhvLgUL0JF0X+RQG9Ub/R5Qplx4ZxkAY35+X+yEFHn4/YELj/1QSUS3h4KqjNwU
         0PFN5+r++CqqLX6ED8mCRH4arurQ2bqljgjTzxt7XQEjzMlhZ0mKByNWVbwmSjO05M/p
         wlJMy/5GIjIL5Oaveg1dp6GS3SwUSmSDrptbjHO2JmJbigxLqyloXyts2l0U4k9+NwXl
         F+IBpHKxzf4Xx/aEWUp8tQ8Zb8fRs8SdRZWV7jp3dmbZO25s7X5jOTuyA3app2/+HYEA
         PMAw==
X-Gm-Message-State: AOAM531EMhoLgNWUN8JvI3qr3rpy97ziXFXHp/maEDTVA8VOxjP9SuEM
        LBCwz73UQUD64iIQbab5NNs=
X-Google-Smtp-Source: ABdhPJxvXVdePhLRtAC/BKdGM2ETh2u/JMTIh5NkOTRDcRv3Pfjs3Z1Rz4KEjUot+ag+Zg8wZoPFFQ==
X-Received: by 2002:a05:600c:230f:: with SMTP id 15mr26264114wmo.186.1600625294080;
        Sun, 20 Sep 2020 11:08:14 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:13 -0700 (PDT)
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
Subject: [PATCH v3 05/19] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sun, 20 Sep 2020 20:07:44 +0200
Message-Id: <20200920180758.592217-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
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
index 57a68222f99a..ce4913f0ffe4 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -570,6 +570,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1045,6 +1048,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1052,14 +1059,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

