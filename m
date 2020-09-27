Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED75A27A298
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 21:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI0T31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 15:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgI0T3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 15:29:23 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A540C0613D4;
        Sun, 27 Sep 2020 12:29:22 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so4404666wme.0;
        Sun, 27 Sep 2020 12:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfoOimVfCN8iFpUENEv9ik5I5IDM2MMc9g699qzOgnE=;
        b=VpmgE9hKsKx/id8FAUpypRINdZZZJDQA2g5lwliDvvPG9+wLh7mwSHeREEXM+3IGo6
         JM4Zsn9otlHItLDUZVOeoSoYYSelVp8w6u84cVugy6ngjkiT0vVSotxMPshnjYhjQKce
         rsy3mzyWMgCzDJ/9o5OkR+MnDXsWjR6EBkFkRT5xUzbWShpRXN/kKk2IvkG+1yG7lCg8
         5/QR7CLhtajvWc3epZeTnRoDNPjefVyXdAQUK08bHmvw4Mj5n1ais1esclJnVyskfSiy
         +bBKwryUU+zccngaYsykzxsW7MX72TzEyen+G0f+zx8+POtGMz4mDz0clZzuF+00Az8I
         rBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfoOimVfCN8iFpUENEv9ik5I5IDM2MMc9g699qzOgnE=;
        b=Etf2qFdYy7YVK3Hb6J6fYX9S2vQ7WjtUOkXqKhHXgTOfcp40vmXMw/7vIJn2/uQD0W
         Ule9CQHGFiF4irmLc29T/jD6KPP2+BTDciC4oXGiioC7IJPyIkGMu7O8UbipR5Z/SXuy
         WPB/otJT4Ghj9MjNBgJdJHaz9jUNOsEZyUuxesfFYd2E8obbylZ1Q7yQbmql8H9kvDnZ
         E9dLVY3KtWDW4uljp540WbRlOeji8xA4c7Qy1dUTTg+R2ef+NG1VMvby/GHi9BoKbDkG
         oQEQCFmMwiEf/+iq9S17FXc0Iy/LoXE38x8cwUn8YIrWNyeox75gwEqYtwl4a1lz/oYP
         Ot/g==
X-Gm-Message-State: AOAM532QIgnv9KXKPIybWCaE1tD7URrT2ZCal8Lv41tNb1OdYc/4jOUN
        C7RUWSNovo5AmC51mILuWeY=
X-Google-Smtp-Source: ABdhPJw3iZIupzVBEAEZQV7hiP0OWDYQ3Rq8IdNg9/nxOE6mZ0V/lg0E7tgNoNIB3xWEaiYI1jaNUQ==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr7949339wmc.81.1601234961223;
        Sun, 27 Sep 2020 12:29:21 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id n21sm6149609wmi.21.2020.09.27.12.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2020 12:29:20 -0700 (PDT)
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
Subject: [PATCH v5 03/20] ASoC: sun4i-i2s: Change get_sr() and get_wss() to be more explicit
Date:   Sun, 27 Sep 2020 21:28:55 +0200
Message-Id: <20200927192912.46323-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200927192912.46323-1-peron.clem@gmail.com>
References: <20200927192912.46323-1-peron.clem@gmail.com>
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

