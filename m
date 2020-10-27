Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDF529C77D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828566AbgJ0Scx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:32:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43195 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828421AbgJ0ScC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:32:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so3013424wrp.10;
        Tue, 27 Oct 2020 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/c21paZsZJba8DF8tLoBjklcU/pJ5XW5IJeLsS+Kt2k=;
        b=Qq7QZoCmy3TG4ygb3zE5N9P9WwwrdWRvnwyFqTugFRCwtD8y0B79yV80bbWFTHlS3B
         laFP7MJZXthqxDAyFScKHBXrLD0CNzRem3b+BB8IlbWO0eZHx1RvmnmHdeBM4GsI3r7T
         7/5/LfySsMy0D43qEsW1hGFYZZc5E2bTDlLZbOBahwdNUPEriU3TZSCy3HU050xKmv8o
         Ln/dkQiVXEKmpUIOjB3BdZ5DJRN5FFan/AbEdGRzd8NsC1zX2L7l2z/3ZiSBwNMr4oNO
         T1Rj7RTK/ja2Rk+ajzINEpm0aI4tJRGELYqL2YY1PXuzfmsZc05K9yaIgaIG8rEQsFzz
         8tCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/c21paZsZJba8DF8tLoBjklcU/pJ5XW5IJeLsS+Kt2k=;
        b=Gy2nJwjgDJxPyDznkw2AKBTrA2gHBYYRsF3Zy/NIaQTKsArL3kKydSAATPqutpkn6V
         po/y+ln6HBapWtjvThZq7FX1U0YsPZoyhpm6X0tDkwEbMFc0iG/iVXjmnPvQt4XIz6o8
         3LHNZJn9z+EEv9IN0cd8gH8EJCVM3fbc/kEqetTafNkCKJJsSp35I3+QlqcJ7p5ITU1C
         sKdXbzVpkX/5Iie1IzJcRrVpREo3N64I8MG7Sr5pZLNWvZgrcvkhRdtjkh8O7JfQUX97
         Bb/pxXbsDqmUE7dlaaMI4ph776QHn4xDSa4FjFE1G21/bko0SFX7dY5Mxv39nFzebrTA
         WN/g==
X-Gm-Message-State: AOAM531k5pie7y7whUBOxgwdIapZJYFwpr2RdxrVzVZprAaTmTb9IOvk
        5qo3PE0BBaErf+G0BlR+m20=
X-Google-Smtp-Source: ABdhPJybTKURTTgkaIrteg61pZdd9OQfEw3Zti19H4IKrVduAttOy9laYU4qyz5dK9TRTLYbl8fiGQ==
X-Received: by 2002:adf:fe4b:: with SMTP id m11mr4110664wrs.98.1603823520009;
        Tue, 27 Oct 2020 11:32:00 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:31:59 -0700 (PDT)
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
Subject: [PATCH v9 07/14] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Tue, 27 Oct 2020 19:31:42 +0100
Message-Id: <20201027183149.145165-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 83537538f8ee..6a3207245ae2 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -596,6 +596,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -924,13 +931,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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

