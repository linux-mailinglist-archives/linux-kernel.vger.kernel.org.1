Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAD3272110
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgIUK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgIUK1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:27:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8E2C0613D1;
        Mon, 21 Sep 2020 03:27:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so11584902wmi.1;
        Mon, 21 Sep 2020 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yae7P0Q6083dv69O1TuhnVIjdtmUZr4BtGd67cLDrDw=;
        b=rCdT//U2AqcdazNuPTd6p8zqxjyzbxQNDjdeI/7jDvZXZShVr3xx8A8HEFgwuTFhOv
         0iCbR/OSGYNyI9OTN99qOQgZGubfICuVJQLaJyzRZNnrRmcPRb03qzID0/mtJeoJvgiP
         hOcqWZmL+pcEmIC2+ZsIG4BjfGAXwlaDMOqs0Wa5ZmjTMBpllKsNwZYV1RA+xdmnvdR6
         mjdM6nO/EJQd2lDGkyHExBqkfoxUynncV6IoWjvnzBVp30upJjgbXNXxnwiwOMVxCR76
         kZZEDwVP1v1bFADbwt9Sn2B1w+DWJ0e2ISmerCAfvbfB/sQJ74dXwv6Ui9C8nzhifF1P
         /UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yae7P0Q6083dv69O1TuhnVIjdtmUZr4BtGd67cLDrDw=;
        b=PynkFD4hkwdpAA44IdVtpEBoK6jGOKLnM9fdvte1tAkiSl+Zinw2BtbCBw6L/ZXy2F
         SXP4iJHW9z7bizRQWb0riNEFy2nytjL11jAW75H5jQf2vx/xXMNw9OAcsyALFT0BtLTW
         CNZPn63ATqYsKg0IB342l13n7D+U+kITHglFiwVunC8aJtjBuXLxKK06w2GKJBd8xlDk
         vEybdqzfNo3Ywa3cP+nTbWMPzVIQShHiV36bBdxOAdz2C4gmlAO79+9b8P3+mN1ISjl4
         e04L8ztBcySaBqK0cLmBn1+QWs63M7HOD83mJzhH/XbXDrmoh8Z4QpZyAvK/zCxcRXC4
         Z9qQ==
X-Gm-Message-State: AOAM531bklo9QEu1bjqXeayRh7iLEX4AW/RtkbiRId8GwAbiCaDQNw1N
        HyIwf2ulpcMrx1CPfql08Ho=
X-Google-Smtp-Source: ABdhPJyC6302uJZIAaQejnS7NYDTwq61oiH+vrMlM+oB3NaVqrV/ajxYP8zA0atuIyOGJ1TuBrkjrQ==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr28632817wmh.44.1600684065594;
        Mon, 21 Sep 2020 03:27:45 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id h2sm20713774wrp.69.2020.09.21.03.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:27:44 -0700 (PDT)
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
Subject: [PATCH v4 08/22] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Mon, 21 Sep 2020 12:27:17 +0200
Message-Id: <20200921102731.747736-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921102731.747736-1-peron.clem@gmail.com>
References: <20200921102731.747736-1-peron.clem@gmail.com>
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

