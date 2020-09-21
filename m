Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225BE272114
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgIUK3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIUK1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977F7C0613CF;
        Mon, 21 Sep 2020 03:27:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so12036824wmb.4;
        Mon, 21 Sep 2020 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JlxXAFB85DXviVVzU9snS3b51VMvFbEM+bK6288hNSg=;
        b=mzu+l6L70rHWw0alVLJS5Xuc5z3XOKT9BcnycIXjFHNqrl4CM9G5faKlLdvqc71WwL
         d4rScfG8Izjpemku5/Hf/d2ewvtMS0d3bNP9BJ8ZLj0yryjreBacKfctPMrWABZUDN87
         22foMN7nBJy/5zPjEQaqzxB97NviGimJp0WsOb0qx/K+cw7OS/Mk4UHfIo5e4sfvhJh5
         v9CrMxXA1xc2tQ06PaeuCoU+Iy98t0lptrj64j+76hxZdHF62my761mgrAfu26c6EL5y
         gx6eGgmDbMjWUCoFN3WDIKG9JfItCszqLMsauUlgUuNTSwGvNxrnuNhlpCqvol+eUQCO
         c8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JlxXAFB85DXviVVzU9snS3b51VMvFbEM+bK6288hNSg=;
        b=GYWnxLlt2ppLNN7v1EQQfej1SzXZehdhRCMDjNO6r1D4oRvA4whI/gh5eOJoJ+KtSf
         vSrAWrb4jYGHCfehvl99k+XVTfcNspzG4iC+JO0fDZ79D4XAuiqzMpllhqWmz6yK9ixk
         /YJaEC4PwPIdo5z80EEruxWp2+53UCbrVFMobIHtTNqfFOJ2zTR8BnxXqiqE/arOgUPb
         lrVgUlMHgPXISmSfN1rnukFiIOwFMVvNAZyvZivxHsAqD741pDax0OkJGz06N4HcRj36
         Uy24ywIT1Xj2aOeoApWmBlTJiDLmKowZMxax/VWtj/UvxxhzyxulQGZO07MyeZ/vYaJM
         x/8Q==
X-Gm-Message-State: AOAM530lzvMnQqiOP9F12eKln75ZIn4KMkTz12qzZsRjAMI6ZjmDgopz
        ka2HxUWZ82L3TdjY4Vf369w=
X-Google-Smtp-Source: ABdhPJy+o10p7bdBaRs62LuKVHz3cb/5w4lrcjRBwwPC64AOJbj/lNF89WZZ4kbdQLrmaqQ8JKCEpA==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr30536852wmm.137.1600684063220;
        Mon, 21 Sep 2020 03:27:43 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:42 -0700 (PDT)
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
Subject: [PATCH v4 06/22] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Mon, 21 Sep 2020 12:27:15 +0200
Message-Id: <20200921102731.747736-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

