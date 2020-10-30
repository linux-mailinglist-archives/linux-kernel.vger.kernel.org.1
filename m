Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AEA2A0833
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgJ3OrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgJ3OrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:09 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7D4C0613D2;
        Fri, 30 Oct 2020 07:47:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m128so6871658oig.7;
        Fri, 30 Oct 2020 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5dXPwP3nPMsD1MvZsFZgKNVn/8P2UAXunD7d2xZR25E=;
        b=g/nRHam1RQHr+gi1IiHlz4fz+p2vaeEcHpT3i2oFxSI5vKJY61ZwIEJK0feGAc9h30
         n1QyytLVq7cMQHbh1/vFuqqEmwg0Denm5XepQrQZdmH5b1uphiWbL5judK25RKliemxz
         uEiy2hTB7BIEEVIi9+vxK08teTYBa+ZdqklX1E+ZSV6mcevsYA+IVvOzXu4PKthpli8q
         CLCtI1s5ILYFXGPJsQwG7C9dkMXWxLUnVwgHD8QaS4iM+LgxzoC650NUvdxKd6lL9jf7
         4AGQRFPTM/YGqRj0iNFaUZJEvAeKL1v7usVgTNYDZSd+PANjelalbDJExcUrb9BHo5Fv
         SALA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5dXPwP3nPMsD1MvZsFZgKNVn/8P2UAXunD7d2xZR25E=;
        b=XSfKaRjpNnxV7u9F6eIdZu0VCiBjscfTDZx96nWRq0yE0VFb0gh80FTW7nZYNb2T3u
         Vhj0ACLPaCM2LVJrfKlWRQ06xy5DmARQmdet5ac3VLVWLYnYmGAKvjEQ7wVBjFmiQXHX
         e9ItU2MkbJd9x0ob97hkxmP5Q1798s9BMxxJ1FojOgURcuAE/jQXoXtHkgmFd0WxJe22
         AJ7CclkoaU+tkNOHk66cyj4fjMEnNhNyHmLLsYw8FTzc9nosOTF2c9xqjyc5CNFXMbcs
         fUCGQ1ZT+Vf8DTVooEh0MUwd5LIemgWV2Dwes7EwHB3juRJNNhzMjL7qynz+fEpCc2nb
         ltTA==
X-Gm-Message-State: AOAM533WuHKQQNNu5Ncfj3HeO8M7uw6DUV/fkdYG8cGALA6iFz5XdIj+
        KFvvn51oRH6VNOhPmA9gcus=
X-Google-Smtp-Source: ABdhPJw9UfyKv2OLKutMa77IpODhqsnntbYeKFty3IdsnEA5PjFgRI0GbmcVqu+ZY8GPiIIv+X71kg==
X-Received: by 2002:a05:6808:6c8:: with SMTP id m8mr1825933oih.36.1604069228048;
        Fri, 30 Oct 2020 07:47:08 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:07 -0700 (PDT)
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
Subject: [PATCH v10 04/15] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
Date:   Fri, 30 Oct 2020 15:46:37 +0100
Message-Id: <20201030144648.397824-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are actually using a complex formula to just return a bunch of
simple values. Also this formula is wrong for sun4i when calling
get_wss() the function return 4 instead of 3.

Replace this with a simpler switch case.

Also drop the i2s params which is unused and return a simple int as
returning an error code could be out of range for an s8 and there is
no optim to return a s8 here.

Fixes: 619c15f7fac9 ("ASoC: sun4i-i2s: Change SR and WSS computation")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 24b3137afbc2..6ee9c2995b4f 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -175,8 +175,8 @@ struct sun4i_i2s_quirks {
 	unsigned int			num_mclk_dividers;
 
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
-	s8	(*get_sr)(const struct sun4i_i2s *, int);
-	s8	(*get_wss)(const struct sun4i_i2s *, int);
+	int	(*get_sr)(unsigned int width);
+	int	(*get_wss)(unsigned int width);
 
 	/*
 	 * In the set_chan_cfg() function pointer:
@@ -387,37 +387,56 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static s8 sun4i_i2s_get_sr(const struct sun4i_i2s *i2s, int width)
+static int sun4i_i2s_get_sr(unsigned int width)
 {
-	if (width < 16 || width > 24)
-		return -EINVAL;
-
-	if (width % 4)
-		return -EINVAL;
+	switch (width) {
+	case 16:
+		return 0;
+	case 20:
+		return 1;
+	case 24:
+		return 2;
+	}
 
-	return (width - 16) / 4;
+	return -EINVAL;
 }
 
-static s8 sun4i_i2s_get_wss(const struct sun4i_i2s *i2s, int width)
+static int sun4i_i2s_get_wss(unsigned int width)
 {
-	if (width < 16 || width > 32)
-		return -EINVAL;
-
-	if (width % 4)
-		return -EINVAL;
+	switch (width) {
+	case 16:
+		return 0;
+	case 20:
+		return 1;
+	case 24:
+		return 2;
+	case 32:
+		return 3;
+	}
 
-	return (width - 16) / 4;
+	return -EINVAL;
 }
 
-static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
+static int sun8i_i2s_get_sr_wss(unsigned int width)
 {
-	if (width % 4)
-		return -EINVAL;
-
-	if (width < 8 || width > 32)
-		return -EINVAL;
+	switch (width) {
+	case 8:
+		return 1;
+	case 12:
+		return 2;
+	case 16:
+		return 3;
+	case 20:
+		return 4;
+	case 24:
+		return 5;
+	case 28:
+		return 6;
+	case 32:
+		return 7;
+	}
 
-	return (width - 8) / 4 + 1;
+	return -EINVAL;
 }
 
 static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
@@ -582,11 +601,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 	i2s->playback_dma_data.addr_width = width;
 
-	sr = i2s->variant->get_sr(i2s, word_size);
+	sr = i2s->variant->get_sr(word_size);
 	if (sr < 0)
 		return -EINVAL;
 
-	wss = i2s->variant->get_wss(i2s, slot_width);
+	wss = i2s->variant->get_wss(slot_width);
 	if (wss < 0)
 		return -EINVAL;
 
-- 
2.25.1

