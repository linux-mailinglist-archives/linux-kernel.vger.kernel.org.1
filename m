Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4228C28249B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgJCOUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgJCOUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:07 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D70CC0613E8;
        Sat,  3 Oct 2020 07:20:06 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k10so4853102wru.6;
        Sat, 03 Oct 2020 07:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c3QS3j+CeqKrt27pTi8NL7yFtwOG0PZkLe82cU+0pxA=;
        b=kMAqJeFUdJ0bC8iwfYBMz7Yvlg882gYnH+oOugICVuxhuJhRGCEC9We1CMO04vqn9W
         cNFBbl5DDkx9EXhfpdJufMQVmwehk/QBSSyZ0mssQ/1hNNyiMVAwjvhXX86wV0tItZ2/
         fBicXWVALqgSLDAboeHCE/nrQ55coP8oTIAigInk331ndEUzyhmui3QKK/2dSL8HJI66
         TqolQqQUk1pTXmwqYM7ITtfaO/oGFj4aqTN5dNyJg4kwsa548z+hxHUsZ2MUpGNJ8Eg+
         N8Y+KGddoq7qLfhQbkJdhOIqv44qz5VLVoHrAGn8xUWOa0faLMpK4RquykDRe4fL3w3L
         yfhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c3QS3j+CeqKrt27pTi8NL7yFtwOG0PZkLe82cU+0pxA=;
        b=GE9gNe/WbD1Bo0or81dhwsyJuv/tbRIRw4OCjaEkrG/+TiKwppaPKPchhah59W85Tf
         2MdQn7woqRF3cWQ1LViGSJBcwl1xJfhox7a3fJEJoUw06CsJAzOaWYaatnlEF23jNYLo
         0H6K+IWdKGCvT2FUD2bn6Q5ODN6VJBosPtkv98BMXGa2p/xkxjMfzKarcSdfJ897cIQG
         Yq2okpMkEzH+H/tlcdR6rBiR8iRmStOyoc5LRygJVLSNxAP8lDE8KPy0IeWpXsEhLPw4
         i13A66kUuaKYC/WgJPPXl5q0/iwe3Xu5ymfobtIkg98juZgCVHUKjavNfXed5d0tYDdy
         3smA==
X-Gm-Message-State: AOAM530JQxlWbRRlngUREomFJnGj5ux1OQ7CSD5Ojs3EaWvCnhlDW5Cq
        t581JVN897PYuPTy1ggXIhE=
X-Google-Smtp-Source: ABdhPJwKkHNl8pWb6gTzIH1iTPyzjAW/z57oJrJ3Kbl5rA5SmPgDK5L4bHXq7zHEgvEvGOKi4oM19w==
X-Received: by 2002:a5d:6547:: with SMTP id z7mr8402679wrv.322.1601734805100;
        Sat, 03 Oct 2020 07:20:05 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:04 -0700 (PDT)
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
Subject: [PATCH v6 05/14] ASoc: sun4i-i2s: Add 20 and 24 bit support
Date:   Sat,  3 Oct 2020 16:19:41 +0200
Message-Id: <20201003141950.455829-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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
index 73103673643a..ba7514849b73 100644
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

