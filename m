Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE6F2A0852
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgJ3OsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgJ3OrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:20 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C8C0613D7;
        Fri, 30 Oct 2020 07:47:20 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m26so5716130otk.11;
        Fri, 30 Oct 2020 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZdYIRpJXQysolM6oP9zf52EwQrg31M/ZfGFP3DuIu5M=;
        b=OX4GPg5VsTfhqBx058ybshrvZonS3TOFrNB6pQSQYAt9GOJf/+kvU57cdit7QM6sWg
         OQp+W+SwmjJkR80VsUmpkDYuNc6SuE99SGUCm5+RylcABXjLczpWr+cCyFtzH90PV1XN
         ptiSiA5yJ+7Q7MXCWzrawRRbIqzYeIuJdSQJN9gSAJ7g/RPqLvHdWdMSnvm6o/RKr/Fk
         wEM1RD7d9koaF/h9g1WRGU1aj3r68PoV9LoKUPM3muv+LSYDPlILDz6EYEyvuerNju7I
         IBEvamVsWC/fz4GlUzS+cJiO5nXB9HPNJqIsAs6Yfgs6eJApEBMVI/k/wiuYDYdueBfB
         YuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZdYIRpJXQysolM6oP9zf52EwQrg31M/ZfGFP3DuIu5M=;
        b=guBZqbQ4M2otLNP66Z9BEzkxdgsDwwK0NrdszadU0/7qEK6PhSiNQEMfFJEOy+uyvC
         fbye3QpXmA3F7li1e6v/xLC0mKqSj/hR6KWrKV2ztcLGJQgGHidSZ+pU/ka8XNxb+iQv
         fLmtrpeOKI+IesnR20qFSrPI7yCaxsDxQgLiJcelN9cD3wgkn5wgyCIhu4rcQyPQiC9R
         /iiV21O/jQYU1xX9kb130eOKjoyToQ+7rLGHoOXByH/wZWgIM2HQerS8U4YgDXCsB0u4
         czBkvagMNLmvZJrWzbMSd7r32+t9ARISacUBJjn+2IM8EV3399+OWWksuWf5m+fW0qyB
         UE1Q==
X-Gm-Message-State: AOAM531dWDPrAWGYlH/yPfPswBrDGaaswp9GZU4XrP5xkk8s0h1UnVLX
        o30sQwbp3ubHZ2yJ2Ox94jU=
X-Google-Smtp-Source: ABdhPJxuVgbxtNmHxZe8XmLqrwhnM3JiW3gaijw6IDQCb9UiO1JffwDqHqrVnxqYvCOajuDO2rv+Hw==
X-Received: by 2002:a9d:7cce:: with SMTP id r14mr1989365otn.204.1604069240086;
        Fri, 30 Oct 2020 07:47:20 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:19 -0700 (PDT)
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
Subject: [PATCH v10 08/15] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Fri, 30 Oct 2020 15:46:41 +0100
Message-Id: <20201030144648.397824-9-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
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
index 003610c0badf..4f5cd850752d 100644
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

