Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E962A0830
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgJ3OrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgJ3OrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:47:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85E0C0613D4;
        Fri, 30 Oct 2020 07:47:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k27so6852920oij.11;
        Fri, 30 Oct 2020 07:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLJXPtjTNSugnrrI4n/vT0cn/oCNnN/c4HbxdKvwJMI=;
        b=AYTrqqkCTFZ13V0uwZeUgAsQFWspiIzE2Teact5kpugvXy5SI1L6T+/iRuTjN7bO5y
         Kwqy+Px9klnbI3jvNzDn21DBz2L46Nt0GIRyuKk3Jy1sTiQneK/DlCeuPza3hEmJWyId
         e1MrLpq+Vn9ysEGn1Q67oMLw5HsnFA/w5ZmoNZDF6YMKz7GmYbyWKcyS+AMztGQ/Rq3I
         pX3ZjrkC9bxNzvtViIWBWn9nNDYfcQUyGVXVb8SVJWYESaE8cKUxEyoVFaBXGsU0Nh+c
         4zebUkfhlby2BFOpqOdComH389TABZEmr1ZUwHA58a5dkL355t+bA65K+P3LSj+mN+uE
         6W0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLJXPtjTNSugnrrI4n/vT0cn/oCNnN/c4HbxdKvwJMI=;
        b=YRGzSQ/UfA4IrLXWBtq4nhgEau4yLs12d2gzRJM6KhVxSJUCyrP1fyIY7VxL3+vcOK
         6JuT6v6fG3R4SZo5n1bG5i5Qq04zWLWrq2cwaXchFw6cEXvLxCJEZg9UKVX8LiSQ4U2O
         6HqLeyJWPirqiGJHT0CRlvzx8DQfbUsyDVMV1+BpkOwXUk2qYtHLNdSaKdE+WXKIdiAE
         Xg9JXnTgXu3CVBE4GKKHhhHSlK0t9D6zcfPILq4GKgxP9xt73xuG/4/q4bmDv7JqceQJ
         SmBEOd+Dag9F/ihUqLPHXgS1xSndvTtYNH4A7JRoO6myziPI+yw6Jcx3SZcxn+jJyUeS
         tcBQ==
X-Gm-Message-State: AOAM5301EfGTPbYCdvNrnpJOpvuy5zVdGTRgl1WK9DPgae2XqxKKbses
        nf/+JdX89lOQNP8wB/FKsGQ=
X-Google-Smtp-Source: ABdhPJzb2QcoBWs+YPaug81YlGbLCnvHC+1aQngHoxi68YJ1C7dZrfC6XcD2h36AG4aG6tAvSpBKEA==
X-Received: by 2002:aca:7210:: with SMTP id p16mr1934022oic.77.1604069222095;
        Fri, 30 Oct 2020 07:47:02 -0700 (PDT)
Received: from localhost.localdomain (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id s20sm1462856oof.39.2020.10.30.07.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 07:47:01 -0700 (PDT)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v10 02/15] ASoC: sun4i-i2s: Change set_chan_cfg() params
Date:   Fri, 30 Oct 2020 15:46:35 +0100
Message-Id: <20201030144648.397824-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201030144648.397824-1-peron.clem@gmail.com>
References: <20201030144648.397824-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As slots and slot_width can be set manually using set_tdm().
These values are then kept in sun4i_i2s struct.
So we need to check if these values are set or not.

This is not done actually and will trigger a bug.
For example, if we set to the simple soundcard in the device-tree
dai-tdm-slot-width = <32> and then start a stream using S16_LE,
currently we would calculate BCLK for 32-bit slots, but program
lrck_period for 16-bit slots, making the sample rate double what we
expected.

To fix this, we need to check if these values are set or not but as
this logic is already done by the caller. Avoid duplicating this
logic and just pass the required values as params to set_chan_cfg().

Suggested-by: Samuel Holland <samuel@sholland.org>
Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index a994b5cf87b3..4ff2068779fd 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -162,8 +162,15 @@ struct sun4i_i2s_quirks {
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
-	int	(*set_chan_cfg)(const struct sun4i_i2s *,
-				const struct snd_pcm_hw_params *);
+
+	/*
+	 * In the set_chan_cfg() function pointer:
+	 * @slots: channels per frame + padding slots, regardless of format
+	 * @slot_width: bits per sample + padding bits, regardless of format
+	 */
+	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
+				unsigned int channels,	unsigned int slots,
+				unsigned int slot_width);
 	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
 };
 
@@ -399,10 +406,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
 }
 
 static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
-				  const struct snd_pcm_hw_params *params)
+				  unsigned int channels, unsigned int slots,
+				  unsigned int slot_width)
 {
-	unsigned int channels = params_channels(params);
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN4I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN4I_I2S_RX_CHAN_MAP_REG, 0x00003210);
@@ -419,15 +425,11 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 }
 
 static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
-				  const struct snd_pcm_hw_params *params)
+				  unsigned int channels, unsigned int slots,
+				  unsigned int slot_width)
 {
-	unsigned int channels = params_channels(params);
-	unsigned int slots = channels;
 	unsigned int lrck_period;
 
-	if (i2s->slots)
-		slots = i2s->slots;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN8I_I2S_TX_CHAN_MAP_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN8I_I2S_RX_CHAN_MAP_REG, 0x76543210);
@@ -450,13 +452,13 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
 	case SND_SOC_DAIFMT_DSP_B:
-		lrck_period = params_physical_width(params) * slots;
+		lrck_period = slot_width * slots;
 		break;
 
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
 	case SND_SOC_DAIFMT_I2S:
-		lrck_period = params_physical_width(params);
+		lrck_period = slot_width;
 		break;
 
 	default:
@@ -482,7 +484,9 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	unsigned int word_size = params_width(params);
 	unsigned int slot_width = params_physical_width(params);
 	unsigned int channels = params_channels(params);
+
 	unsigned int slots = channels;
+
 	int ret, sr, wss;
 	u32 width;
 
@@ -492,7 +496,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (i2s->slot_width)
 		slot_width = i2s->slot_width;
 
-	ret = i2s->variant->set_chan_cfg(i2s, params);
+	ret = i2s->variant->set_chan_cfg(i2s, channels, slots, slot_width);
 	if (ret < 0) {
 		dev_err(dai->dev, "Invalid channel configuration\n");
 		return ret;
-- 
2.25.1

