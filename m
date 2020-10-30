Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492192A084D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgJ3OrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgJ3OrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D830C0613D2;
        Fri, 30 Oct 2020 07:47:14 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j21so5717621ota.13;
        Fri, 30 Oct 2020 07:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hVl8qXyL4uyE+bKvgQrUQIjmv0VmS+Xl5odcY5Z+CoI=;
        b=rEPruIXPTVXLfk67LDH5YCfgYBjZF5vIrUX5Tbnn9ls+c7uvOSpuBR/pxgWaM4eLSA
         uucxveJU5jrBrOSrMFqsyyhPBvcOeI4XyN2NmHddCtWdlLfsEopLtb5OqTayDGPTX3u4
         xg7DRqPCiYusOR/daBojNeKKOYebXxUlXDcNxTita3qsSUKzL2+Yki2pnNB0D7/Dz0jQ
         76XaRk7uZ4dpmNl5+4w5lFgXRRrf6+CidQu/MUSiiAZHf8JX5Cl+TjWzDmqDijky8nca
         UUtDE+1n1CYaGMkN6L/rs//PJWFax6Csj+ooUdl1J8mU9Hjds5ip3msnn/3Ki+Jjqiga
         Jp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hVl8qXyL4uyE+bKvgQrUQIjmv0VmS+Xl5odcY5Z+CoI=;
        b=ulDqsF9PMtPVWDOxV/EX7GzXHRpWLv5XSLUq6CA3lByW4uI1AaGDG1SrAN3pW+Eos1
         kG/2lPWN+swMnWUuR7uq4gMAUup/qXwnhXkzuHa1QJ625mIkL+Mllss0UwQCGHFBsMo7
         s3ftchjiEqtnv5ePuerG5+a1oXNw4WN4dBAacAHeqTOtROz2YAlPxrSyYiVgXJRXstNC
         VlB5oTtvmJz1fo/K/GiGl/nnsfbGt6aMzHCT68q02gZhrC6iAm/ZCssglTV4FVYDyOQJ
         gfDEYgWf19wOjbBdToEU9o2YU2TzMOWTXcHzPc47l1ZLJe+duxQ0DnyNREAVKyp5LJ1c
         SMiw==
X-Gm-Message-State: AOAM531WtdoZoqWZ0SkBFKUTjK1r6ZVHS27Wty9cG4zYH4AW1+iUb8sD
        jyLhsPXB/LicTNU+OT/fV/U3h8jSBTJo1Q==
X-Google-Smtp-Source: ABdhPJyXk1sTONN1FzWWHkaULZ0gNYWaxtyOSeBBxR4VbPDIVIvSmhcinPoe5FOpCzGCuc0JWuo7/A==
X-Received: by 2002:a9d:3d44:: with SMTP id a62mr1834140otc.254.1604069233998;
        Fri, 30 Oct 2020 07:47:13 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:13 -0700 (PDT)
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
Subject: [PATCH v10 06/15] ASoC: sun4i-i2s: Add 20 and 24 bit support
Date:   Fri, 30 Oct 2020 15:46:39 +0100
Message-Id: <20201030144648.397824-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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
index 46e4da18c27f..786731191d90 100644
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

