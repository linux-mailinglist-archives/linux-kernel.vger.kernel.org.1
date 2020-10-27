Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9486E29C766
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:38:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1828412AbgJ0Sb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:31:59 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55245 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1828392AbgJ0Sb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 14:31:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id w23so2318555wmi.4;
        Tue, 27 Oct 2020 11:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HWW+ZfyCHyBaIjHVek844VU+H74q8wumivr8pDBz3+c=;
        b=Xa3aRlWC9ljsRrq+ZxZgYJULHxsgPA0ckHAQ19+tNrf10j+9QY8DA/WYBZS1fMKzl5
         8GYE10EvUT32mxJHeLCKJ/Mcqp6ZYITrS/Lw6JWjGM0JoUXfwC0OZCPBrbXH4lYllfHL
         7Nsu8vWTkAFdyvMqwm7YbggvoUv+zhP08zPknzg/lVE+UkS5kOPLMSWdsJaaN8rVqPi/
         hJPJyDbwvwA6ZzCHRnjE1TpbnXlFcdUJDy5IsJd0h4KZ5bcDHZ0fZZ97gbUuCkvsIaym
         gI+NtTldqxulAoFlhrBoVALDkSpwyrdNhozI7M8Cq7gEpbZZPrBVwjNcTQDmY1ao8fQS
         +JEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HWW+ZfyCHyBaIjHVek844VU+H74q8wumivr8pDBz3+c=;
        b=EZoaCBBu8c/1CmHbk4h+0I4Ttj0bMlaL5QZn23JiVVylHBmkqmYRKAY2u1qifBSsR8
         gewJMy9CcMEjea0Tsz5Ql+rggEBnIqkCogbJuDyPDmUoYtNbHpPz8pLycixq7/g21LPX
         XFavXgpdGJqPMN5d8Bg6QqU/+tNFbdbtFH4p6wHEpJHDMNYW6+EG1sJzobbWYQ47r16f
         nHWrDbks4KZiQWOA1bigIhCACkhMZMhfm0Mu57TRC6DBgP8DdfMFo6jWI3PTJg6qUqQv
         v0TZHJPu9YRk71IU0+7iRlAXolfhBxiYon+dSX/h4GN4vdr/EAnfQ1nUn1ei9bbUVv6u
         OxzA==
X-Gm-Message-State: AOAM532fhs4l2GrT0A7g7ZekauFuhUAyTO21v+JgrP02NUnbLahcN04S
        +Z2tAAuuf0mVN/CAiuwj17U=
X-Google-Smtp-Source: ABdhPJw5odAjh3G76+qql0JT4kD/cXQYlrTOXEYaGxulwmcWowGzECtkFMHPjpCXF16eHf3suW/ukQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr4002368wmh.94.1603823513610;
        Tue, 27 Oct 2020 11:31:53 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id m9sm2864148wmc.31.2020.10.27.11.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 11:31:52 -0700 (PDT)
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
Subject: [PATCH v9 01/14] ASoC: sun4i-i2s: Change set_chan_cfg() params
Date:   Tue, 27 Oct 2020 19:31:36 +0100
Message-Id: <20201027183149.145165-2-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027183149.145165-1-peron.clem@gmail.com>
References: <20201027183149.145165-1-peron.clem@gmail.com>
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
index f23ff29e7c1d..7c1f57eb2462 100644
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
@@ -452,11 +454,11 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
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

