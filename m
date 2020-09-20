Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1972716B5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 20:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgITSIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 14:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgITSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 14:08:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74859C061755;
        Sun, 20 Sep 2020 11:08:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so9952743wmi.3;
        Sun, 20 Sep 2020 11:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vEHV1mvtoxOc6RfnQ/K6KV7HvIkD3k6AspYIp0zU0iE=;
        b=rbQmGy8/gZvujBAO0xznJrDT3RD8mpaq1L7GDarWMKT+SA6E+qlkgjxrN08GBuWFUo
         mCeect7gS/bp+5hf/jkLksCo3BANULXkLwbQJg7fvo+8dX1v8TXVrQEbaBgmnoIMU8st
         WWPBTTcg2g2suUDjJPTqfHSDEAmhxsBkaA6G7sPLll+w94Nx9S0rlvM1OWe54w9+XTTF
         mr4aj/TGjUDZPQQOkcsHlgQxsI/7TLsZD3sEfjbHBtdWQNikggNzUYtHUrqIwiQvmPlt
         TLbpJeqJG/vFKHx9Aq6EmawQghzVv+xoOJ7GFdHOHVAv/OUxGtNFmhbf0fZHwEszfWQN
         3YQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEHV1mvtoxOc6RfnQ/K6KV7HvIkD3k6AspYIp0zU0iE=;
        b=Dg+occ+YhE//hR3ZCmzoht9Atr+um8txWxBQmOOWj5osZeFibVHKJpFaznC3H1Pje+
         R9s4McctH+FefwbJlp4A8BtKfcxTFEIir+DBd2h22HUo0znj8jl9qMkDeWVCKjuidIxG
         XdZxSRR3xd9/xLVuK8rbDBXsky2JIyexERyeLx00mWmG7r/MdIyzA+0bgg7p37kLABdq
         Ma2mCPXJeC886D5oy1m8+/ldPvNWFPFl6akmnrViJWzBaLPSfaE20cavRrjB8b63aYaN
         q0b0BkugubTfFQw16ir4z6s9Cmczn+ql9U8V4J6BxRfPXxKaQFJzfOVXrDJbR15wk8fY
         x6Hw==
X-Gm-Message-State: AOAM533eiVCyxNc7BgTvTzK9/v4MfyodC/RAnNtXwh/lJiyDo+5Leykc
        VOjyGTL2ojoKBJvFOi72Jzs=
X-Google-Smtp-Source: ABdhPJynjCIkH84YYEMQOzwHd2jsYfTmhmUVjTKO1BgzcBTrvHNWezNxxN/Zu7AJ7CS11i7flg0eKQ==
X-Received: by 2002:a05:600c:ce:: with SMTP id u14mr27167924wmm.137.1600625288017;
        Sun, 20 Sep 2020 11:08:08 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id 18sm15142782wmj.28.2020.09.20.11.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2020 11:08:07 -0700 (PDT)
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
Subject: [PATCH v3 02/19] ASoC: sun4i-i2s: Change set_chan_cfg params
Date:   Sun, 20 Sep 2020 20:07:41 +0200
Message-Id: <20200920180758.592217-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200920180758.592217-1-peron.clem@gmail.com>
References: <20200920180758.592217-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As slots and slot_width can be overwritter in case set_tdm() is
called. Avoid to have this logic in set_chan_cfg().

Instead pass the required values as params to set_chan_cfg().

This also fix a bug when i2s->slot_width is set for TDM but not
properly used in set_chan_cfg().

Suggested-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 348057464bed..246d4a45edae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -177,8 +177,8 @@ struct sun4i_i2s_quirks {
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
-	int	(*set_chan_cfg)(const struct sun4i_i2s *,
-				const struct snd_pcm_hw_params *);
+	int	(*set_chan_cfg)(const struct sun4i_i2s *, unsigned int,
+	                        unsigned int, unsigned int);
 	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
 };
 
@@ -414,10 +414,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
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
@@ -434,15 +433,11 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
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
@@ -467,11 +462,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
-		lrck_period = params_physical_width(params) * slots;
+		lrck_period = slot_width * slots;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
-		lrck_period = params_physical_width(params);
+		lrck_period = slot_width;
 		break;
 
 	default:
@@ -490,15 +485,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 }
 
 static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
-				      const struct snd_pcm_hw_params *params)
+				      unsigned int channels, unsigned int slots,
+				      unsigned int slot_width)
 {
-	unsigned int channels = params_channels(params);
-	unsigned int slots = channels;
 	unsigned int lrck_period;
 
-	if (i2s->slots)
-		slots = i2s->slots;
-
 	/* Map the channels for playback and capture */
 	regmap_write(i2s->regmap, SUN50I_H6_I2S_TX_CHAN_MAP1_REG, 0x76543210);
 	regmap_write(i2s->regmap, SUN50I_H6_I2S_RX_CHAN_MAP1_REG, 0x76543210);
@@ -523,11 +514,11 @@ static int sun50i_h6_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
 	case SND_SOC_DAIFMT_DSP_B:
 	case SND_SOC_DAIFMT_LEFT_J:
 	case SND_SOC_DAIFMT_RIGHT_J:
-		lrck_period = params_physical_width(params) * slots;
+		lrck_period = slot_width * slots;
 		break;
 
 	case SND_SOC_DAIFMT_I2S:
-		lrck_period = params_physical_width(params);
+		lrck_period = slot_width;
 		break;
 
 	default:
@@ -563,7 +554,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (i2s->slot_width)
 		slot_width = i2s->slot_width;
 
-	ret = i2s->variant->set_chan_cfg(i2s, params);
+	ret = i2s->variant->set_chan_cfg(i2s, channels, slots, slot_width);
 	if (ret < 0) {
 		dev_err(dai->dev, "Invalid channel configuration\n");
 		return ret;
-- 
2.25.1

