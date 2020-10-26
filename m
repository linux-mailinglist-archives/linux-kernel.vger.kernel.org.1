Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD8D12995EA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790477AbgJZSyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:54:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46725 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790490AbgJZSws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id n6so13872056wrm.13;
        Mon, 26 Oct 2020 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZOkLUnzWl9ZzJaEpvY0BQeyF9Xi02JdDTj+Ipv+HbgQ=;
        b=WJ0Xq1340TIzloUUZHjNZaU/k2V+gFbVMFABmIc+Xj3BmGU+QZctUBokbHDUcHveRi
         txZMnKkF/pozpG4sGojq16zFGrjSWD1Y9JIwYW3puV+JrtOtl9U1O+t9ftqMx+Yi3d2s
         PFK0wD9AQRnnkMHnLGQAq2GAj6I0hVlIm7ka6pI7k2pRoHzgyekhOZ/Ie5a+Ga2IgjXi
         t5kAtJ7Na0PoC87EbAW/2VljxGCC0hSoyZM72e7A84biDS80xvqk0vm7fGA6YgzQlH1+
         SzbzB9fEEgMEH6M+cwcPE2WuIIzeSHuB4IdVEIvJkzKauK6cFHWmL4IlnKHTROOXl3Wa
         40sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZOkLUnzWl9ZzJaEpvY0BQeyF9Xi02JdDTj+Ipv+HbgQ=;
        b=SOnSp7dLooHfPsBMfACiz8YbjiyED4EZEHJC4GSZ2FIEtjS2H3VLRZiIpqzisC9A4Q
         bn1mmjFrNbJH+EoFU+SH2WUnBOfrZ/6gfFKvoVa7xplVQD1oZoaeZ7nMl8c3Q3G70Bfw
         y+K1DGgf+AtP+XD0GDAlAtvmS8GvO1j0AqLesdNXiRlFUqJetlifPNyexb4PY++Hdkij
         t2k3dq8QLWz+OfwdSBi7Nk4UhcbNxDGXsLB6hcGpQty1kqelOkDOBzjS+uIy0pzcbqYt
         c+bcPo7LuD2uHxbrVzgG8ocUzphFEfrC+l/jdx9M0Cui/0X0VJ5pVub2VzI7iFvEIpqH
         JcyA==
X-Gm-Message-State: AOAM531We44DtBXfjmPX3TF19P01Un/Ko9IOMOXAdPuw/3ZcKGk64rtQ
        hy6nGePACc48sd8WB80Q9mA=
X-Google-Smtp-Source: ABdhPJz3QiBhHJxavCSNhviQE5xuIrFVUUOvGqbGZ8O6tOJdFQ/qG6f90Md4pX8KCTOu3UT9B1SgnA==
X-Received: by 2002:adf:8b15:: with SMTP id n21mr20281915wra.313.1603738364241;
        Mon, 26 Oct 2020 11:52:44 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:43 -0700 (PDT)
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
Subject: [PATCH v8 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
Date:   Mon, 26 Oct 2020 19:52:26 +0100
Message-Id: <20201026185239.379417-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index f23ff29e7c1d..6c10f810b114 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -162,8 +162,9 @@ struct sun4i_i2s_quirks {
 	unsigned long (*get_bclk_parent_rate)(const struct sun4i_i2s *);
 	s8	(*get_sr)(const struct sun4i_i2s *, int);
 	s8	(*get_wss)(const struct sun4i_i2s *, int);
-	int	(*set_chan_cfg)(const struct sun4i_i2s *,
-				const struct snd_pcm_hw_params *);
+	int	(*set_chan_cfg)(const struct sun4i_i2s *i2s,
+				unsigned int channels,	unsigned int slots,
+				unsigned int slot_width);
 	int	(*set_fmt)(const struct sun4i_i2s *, unsigned int);
 };
 
@@ -399,10 +400,9 @@ static s8 sun8i_i2s_get_sr_wss(const struct sun4i_i2s *i2s, int width)
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
@@ -419,15 +419,11 @@ static int sun4i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
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
@@ -452,11 +448,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
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
@@ -480,9 +476,16 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 {
 	struct sun4i_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	unsigned int word_size = params_width(params);
-	unsigned int slot_width = params_physical_width(params);
 	unsigned int channels = params_channels(params);
+
+	/*
+	 * Here and in set_chan_cfg(), "slots" means channels per frame +
+	 * padding slots, regardless of format. "slot_width" means bits
+	 * per sample + padding bits, regardless of format.
+	 */
 	unsigned int slots = channels;
+	unsigned int slot_width = params_physical_width(params);
+
 	int ret, sr, wss;
 	u32 width;
 
@@ -492,7 +495,7 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (i2s->slot_width)
 		slot_width = i2s->slot_width;
 
-	ret = i2s->variant->set_chan_cfg(i2s, params);
+	ret = i2s->variant->set_chan_cfg(i2s, channels, slots, slot_width);
 	if (ret < 0) {
 		dev_err(dai->dev, "Invalid channel configuration\n");
 		return ret;
-- 
2.25.1

