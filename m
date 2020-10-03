Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BCD2824A8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgJCOUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgJCOUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFABDC0613D0;
        Sat,  3 Oct 2020 07:20:10 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id h7so1232500wre.4;
        Sat, 03 Oct 2020 07:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ax58UcnPU6lZeDb3EeYExWMlNcsV/u2URQrazxH4tvQ=;
        b=p4P+Px2LIwrBSoaKTOg163my9Jegr6AXir6dFUS50USUcMZwqbkgWuXWq6zBVeWuc9
         e9CO3dejaQGMa73lKpLoVvAcEMUU4DjmpAvWYwZhrP/7ZESVLR4IJtsnqqd05gz2kAFN
         GdfsHb8jxIjB9IuQWONyNUrKV29PDOIhxxfIhWyJa5pdj3h3TMJ0jkjFivj7Z47CIcM0
         aV56vIOjANHCWmqiGXh4BYD0mvisHOBkoZjCJ4qfbFFsvrZXspU0/5WJTt4gQw1dalB9
         RmFCP56Za/jdldA1B82YOAYkxRGhobRZzBwFR/Ft2YIW5uvu9P1BFxLuJxuxjmllFaVE
         XcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ax58UcnPU6lZeDb3EeYExWMlNcsV/u2URQrazxH4tvQ=;
        b=eL0iJjUKHcCNY3dM+eEk5Sd8ausaRfMqKF+bqMz0ECAfj4Sq4aGVfQmVNhRp3xPv3F
         Bvi9uLp0Bvkf/UAfIN8WVDVeAY3bk6aMqopNwhi8U6E3IRWRvVhz//s766sgmrmKe67p
         KGuBcE2sQgNdG8YzlkQh6bzg41IX/k+LBOQ+xlq659wY2rlnnflVqQA4K47u2m9bvZx5
         psai524a4P6WWWgtlTNFffJ/e1tfYVFe2XPFnftwc2H0jlGbsvSBU3hTpzlIdQmdzIVN
         a/NxFDVTp+2SRhnp89sRJLbmfdRdjLcBzeCc7fecQPlsBW+23sDDaayO4RrBhJV/tl5g
         LnJQ==
X-Gm-Message-State: AOAM533AkopqLxFhZaMeUy2koS4QTAIpp+0QyBPJJWxgwbu4lMRImhkD
        N8pwfLUQYv45pj5RFvnhG8c=
X-Google-Smtp-Source: ABdhPJxNULhKp/1O+Gw2xeSC8CsfcKu+uvfzfv/TDKjxZ+wlFm3B8kTNRMittfYqQTkP6AIY46zzrw==
X-Received: by 2002:adf:df8e:: with SMTP id z14mr7450772wrl.32.1601734809588;
        Sat, 03 Oct 2020 07:20:09 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:08 -0700 (PDT)
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
Subject: [PATCH v6 07/14] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Sat,  3 Oct 2020 16:19:43 +0200
Message-Id: <20201003141950.455829-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
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
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 92671eb94db9..fef68146d648 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -588,6 +588,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -916,13 +923,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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

