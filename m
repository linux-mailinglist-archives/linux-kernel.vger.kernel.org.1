Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740692720E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgIUK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgIUK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:40 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4990EC0613D0;
        Mon, 21 Sep 2020 03:27:40 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so12147436wrx.7;
        Mon, 21 Sep 2020 03:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=edlSUT/Y078NXbAZqDd8CvaKkdPfuHJQ/JeQ1t1s3zw=;
        b=jnag0fqDdXTzH7mJmr/nHlCqEUC2q1l0NOwme88e8hBjTYY8yvZxkoFcn5x2oxWOFg
         GxaB2+IakXYFHyl1hJIAk9vBDGCwfnx9exyigyT7DB2XlY+s/RifWzoYU4umXVUfUNof
         Wtha0ZzWvQ6ziUsmsqC1BE8gEiXietWKSgZLVqgIKZdLaOSjmqIdMsrHTbIbeVyrFzn2
         J4XDrv5R1jyjikClYuEb4z/BDp02aV+u/zfAI7lU5py/chj8whvxZ7o6F/SM+Ub098HK
         pEppTaatuCVvCTO/zImKSqN2xgMo/8rt0IF4RG2aGT6oCt6qGY8bhA6MZCprotV3kqfZ
         EE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=edlSUT/Y078NXbAZqDd8CvaKkdPfuHJQ/JeQ1t1s3zw=;
        b=R0gLnePrjn6qUj2nXCrKNQERdrJkv02hxRvcctfyVA7S0o5QkNKPv1CsWKYewEYz3D
         y0JGs8NGjOk9mNmIMmHoqs53Dv5hYLwH9I/yiUd8CB5bX4YFBscgOWWS8LBRUTp4vkeV
         lK3VGh56SbaG9Tca5NnFiBAAZLj3bi622m/RgI66JmJba6quZw7sXQFHkWVETlZNk+/1
         bEWhBlhkuzfLLQdvdKxkN5jAq0lWXIC5r9Zc4ELnVPGbGph7Rnhm4CkNz0eNtVwYJixR
         Nf4sUdBnzLC3piXbmdK8WXvBfcscQGq2wSjdyFBFQ+9mq/4kmixcwGVqpSDBVY7oAu6D
         eAQQ==
X-Gm-Message-State: AOAM532QMgqGVh/KUsQH99POPPYbXLDLVE1aKmVkwBCMED+GX0UmDPEm
        1PZhrUQVwBBxGbr1vkYgWYs=
X-Google-Smtp-Source: ABdhPJxmFW+NaCfURDMye6Dosi+5xOQ1AdjDzKmNSK/hSvD75t+zteXJgK4z547kQ2tx9GTkQqXoAQ==
X-Received: by 2002:a5d:4710:: with SMTP id y16mr53373939wrq.203.1600684058897;
        Mon, 21 Sep 2020 03:27:38 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:37 -0700 (PDT)
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
Subject: [PATCH v4 03/22] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
Date:   Mon, 21 Sep 2020 12:27:12 +0200
Message-Id: <20200921102731.747736-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are actually using a complex formula to just return a bunch of
simple values. Also this formula is wrong for sun4i.

Replace this with a simpler switch case.

Also drop the i2s params not used.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 69 +++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 25 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 0633b9fba3d7..11bbcbe24d6b 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -175,8 +175,8 @@ struct sun4i_i2s_quirks {
 	unsigned int			num_mclk_dividers;
 
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
-	s8	(*get_sr)(const struct sun4i_i2s *, int);
-	s8	(*get_wss)(const struct sun4i_i2s *, int);
+	int	(*get_sr)(unsigned int width);
+	int	(*get_wss)(unsigned int width);
 	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
 				unsigned int channels,	unsigned int slots,
 				unsigned int slot_width);
@@ -381,37 +381,56 @@ static int sun4i_i2s_set_clk_rate(struct snd_soc_dai *dai,
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
+		return 0x0;
+	case 20:
+		return 0x1;
+	case 24:
+		return 0x2;
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
+		return 0x0;
+	case 20:
+		return 0x1;
+	case 24:
+		return 0x2;
+	case 32:
+		return 0x3;
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
+		return 0x1;
+	case 12:
+		return 0x2;
+	case 16:
+		return 0x3;
+	case 20:
+		return 0x4;
+	case 24:
+		return 0x5;
+	case 28:
+		return 0x6;
+	case 32:
+		return 0x7;
+	}
 
-	return (width - 8) / 4 + 1;
+	return -EINVAL;
 }
 
 static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
@@ -572,11 +591,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
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

