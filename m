Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7A528AA3D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgJKUWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbgJKUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:22:47 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69766C0613D0;
        Sun, 11 Oct 2020 13:22:47 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id y9so3158345qvk.1;
        Sun, 11 Oct 2020 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6foTdNByYaza+7IioC5Au+dQ6O1jD1KqRZFfbjoYWg=;
        b=IyS1xQweqtX7I7JqvRg2RP8mWx2QwzjtmI9o5PT8TY3EyXm5m+AhdZV8JyiEnRfj+C
         SQXu8zpe8zE/rjyALoawdUk2XiW070CIgVf+rojhN9sq2vbPHwPwMCFDfTkKrZxPf0pf
         FHnN2JVCP3rlT1ZSFjUgDXHZ3kGk7ZfgI9J70NuBV+R7H6orPbErWEGODJFUbdqnPWN5
         FjFKLBsRvYbECj/5LjRVLy/7pPAi+nB0Vu1e40h9dBoc/bSke8FSLbbyQuNH3EY5vNJB
         9EQjj1Tu24/533R2j0HvHo3yRw8Qka3QAM7j0MbMhWPN+8UwdZkezRz1CzXOPYBAVUva
         n5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6foTdNByYaza+7IioC5Au+dQ6O1jD1KqRZFfbjoYWg=;
        b=s5NXwByvHOhitu/TH41y/yCnj/WyyvI4885G0uAW9TtmFMkBCrpcLa0LmdA4xN8o3l
         qj/B307a6Q9p/20P35ZdjSyjdgF8PVU3Bk5Q0h3l6Kq7l9z7fM26qzLVvvUkioxRUzDw
         xDcN0dMv54CnJkRkyASx41tPR1LRQGR+PfyQxO4ENSsOTpv8bGq+riDDa3oE9vleHNTD
         au7plSTyGZxJtxaRTgc+eAWUFFW/Y4CYEDceQe3nB9TE+v/dwLZYCcwHHg1k+ok9tWS6
         lUEjMU5oDofyZko9PgnzhrzzcpHpZhEzqbgT2CWbZfP3dnyppZN49pRpwIzzdCNr3jYI
         VvkQ==
X-Gm-Message-State: AOAM530HqGKqDz5tUhT2IiuEaYXFHE3bMSiHFEavTlE6aM8hbjBOLcrN
        L5V5Q5m+lU7yFLP6nkdjLVA=
X-Google-Smtp-Source: ABdhPJx+NO8hs3nQcTr1w1RkQ757q0aA38ZZh4DW7nzWF80tK2zH2HXQsw2IZdsZOYXzR6xqYtxNig==
X-Received: by 2002:a05:6214:153:: with SMTP id x19mr3061824qvs.50.1602447766535;
        Sun, 11 Oct 2020 13:22:46 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:22:45 -0700 (PDT)
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
Subject: [PATCH v7 05/14] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sun, 11 Oct 2020 22:22:15 +0200
Message-Id: <20201011202224.47544-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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
index 0b242f4615fe..d5eba58ff207 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -592,6 +592,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
 		break;
+	case 32:
+		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
+		break;
 	default:
 		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
 			params_physical_width(params));
@@ -1073,6 +1076,10 @@ static int sun4i_i2s_dai_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
+#define SUN4I_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
+
 static struct snd_soc_dai_driver sun4i_i2s_dai = {
 	.probe = sun4i_i2s_dai_probe,
 	.capture = {
@@ -1080,14 +1087,14 @@ static struct snd_soc_dai_driver sun4i_i2s_dai = {
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

