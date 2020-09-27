Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C014D27A2B8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgI0TaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgI0T32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71297C0613CE;
        Sun, 27 Sep 2020 12:29:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y15so4630239wmi.0;
        Sun, 27 Sep 2020 12:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yae7P0Q6083dv69O1TuhnVIjdtmUZr4BtGd67cLDrDw=;
        b=OAwisc7aL0o8lIuJum3WM3sV9ofN665KoKM9NtgnT/G8zNo9Q9fgkMTuJqx1czeNc6
         t1lx9xyjNwWHn8T8dqJm7/uG89/1NEjyVHD9C0S3HrqsKi5L5zwlxwMACbPvSgp6iWTd
         Dy0/3YjquAtjsMFUxepIlSBFuo+pWSSG5Rh7fyL016BPO28nT1wjpu5yHxRPxz8md0tG
         YT1lo3v6o7OkhuMsva3JMXgsP8srntNNyEWGRcq0GK6BaA9Q1dA9XquEzK6VS0a/uoI9
         M6QVFWhXRstuXj6maGreKLFXuCV7/3Xm2rPglp5ST/wqN/EtFpRsYi/EqTbHR86zAeA2
         /p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yae7P0Q6083dv69O1TuhnVIjdtmUZr4BtGd67cLDrDw=;
        b=Jzq9i/4zXDNlbX9WFzpkHB4REAeSLpqHhfWna+fWK458Vl3AlZQuOznEWHuoXEovFn
         /j2cu7rb7bFskpF5XKsV+1azdj7TYRzB0CezDtaTvn1iZyvpovopnfADxIAn3/duUd8h
         jKJt8vtiEdO+2iNFXyjm8w3S29rs+KMGVv5W3K8LmLybmdEa0UYiRUyLCqoCC2UFgsg7
         bBrQ8PBEqHCv6mJxm5OAUoxrEbl6wrvC7R1bllp6niNBbwLBuczvdFMQbIecIXpWEkiW
         svcV+kw1/sNGUXWqSrb1UBf/SuD5s3+NMoMNOk6UkxwUOLVNM4ioui0k3ayzYfb0kmf8
         LHEw==
X-Gm-Message-State: AOAM532cgFiFcGudsgwxJLH0TQ6V/ZzLaukHQfUr4Cuv2HdPIYvD6pyW
        BaU6X/3tPkNRCB/i2rrjwvQ=
X-Google-Smtp-Source: ABdhPJzIyHV+/LUfm7D9nL9vW8OGycgbDVJ8xGPlS1ktTBXE2yfbAvN/oB5kTGyRlhsp44nQJOXkXw==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr8404691wmb.155.1601234967071;
        Sun, 27 Sep 2020 12:29:27 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:26 -0700 (PDT)
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
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 08/20] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Sun, 27 Sep 2020 21:29:00 +0200
Message-Id: <20200927192912.46323-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

Because SUN4I_I2S_FIFO_CTRL_REG is volatile, writes done while the
regmap is cache-only are ignored. To work around this, move the
configuration to a callback that runs while the ASoC core has a
runtime PM reference to the device.

Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 3f9110d70941..9cd6cd1cd284 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -586,6 +586,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 		return ret;
 	}
 
+	/* Set significant bits in our FIFOs */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
+			   SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
+			   SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
+			   SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
+			   SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
+
 	switch (params_physical_width(params)) {
 	case 16:
 		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -914,13 +921,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		return ret;
 	}
 
-	/* Set significant bits in our FIFOs */
-	regmap_update_bits(i2s->regmap, SUN4I_I2S_FIFO_CTRL_REG,
-			   SUN4I_I2S_FIFO_CTRL_TX_MODE_MASK |
-			   SUN4I_I2S_FIFO_CTRL_RX_MODE_MASK,
-			   SUN4I_I2S_FIFO_CTRL_TX_MODE(1) |
-			   SUN4I_I2S_FIFO_CTRL_RX_MODE(1));
-
 	i2s->format = fmt;
 
 	return 0;
-- 
2.25.1

