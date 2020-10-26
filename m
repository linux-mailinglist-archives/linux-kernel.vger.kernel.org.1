Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1076A2995E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1790963AbgJZSx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:53:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1790513AbgJZSwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:52:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id x7so13935401wrl.3;
        Mon, 26 Oct 2020 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MV0Vedow4etdUV5MYJB38BsVPsxN1obeyBLGuXltraA=;
        b=eZ49tzP1pyDtQrusuKWVvPynjdDSUYbYk/Pf7IjVXifYBHVV2xSmh1Y3Lw38u/5kY4
         gYHSqwME7tvdlVU7ahKClZ6QaaHoGFxb1FC6NmU2vnl9SKgxQwDcuWfZltwFcXS0UsYY
         u8Zk0YYeyU+rrAfXzwuUPsgjJb/zaQVG8cSIkgws1xRnUTqXMVGybHVTCOnFBWKtOeoT
         yC0VHJguAIEAvXa+rR+DxlKlz/IYq/FNw9Cy6CB8/VPFfR1OtQeg5eR+7bqQt54Dq3EO
         /05v9D7ugOd4S8YI5SIglhv/UhlRyRR4g8e43fyMVGjxmxi2fDMfAh9MZgPsbccMKRlG
         UZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MV0Vedow4etdUV5MYJB38BsVPsxN1obeyBLGuXltraA=;
        b=X/e+4h3geKi4PThgCu1Zvx4LHwUP3N+7E3dWVVKsZBVWJ2VwbwZCd1q1B6IwVEyRSR
         nXnsWznDi3QnwAOF7fREmUB21JbHb+WElBkUTa7diNfMdp3dMJFLRwwLPNM0DmChSZzc
         GtBzgXYOUjN7zMFrxGG7bodIuKIAGn5Q7od94bm68fe7ym/fAlYgd/GM8VhAcTzScHVs
         wYx9/Lj7P1gj9j7ezc97jqLQqb6xNaUvhnB+Ax6E+ZxLpcDemlCSpGwOgVxmNFgVwgX7
         PTNR1v4z8ff1f2EXtbSJSZWG14LXanc7XP/dJ3x3Wcf47XWkcqCeer54LaHgJOajYmLe
         sQBA==
X-Gm-Message-State: AOAM531nHwwFZ+ex+aQlstn3kHBfz0UERUvppm2kjfTc0R9r+xcF9RxI
        HuE5UE0kp7X3Q51u9Ehf318=
X-Google-Smtp-Source: ABdhPJyu8GqRa4KgXOETmGaGeq0afG8g9xoC8IeUU96J0XE4Pcleg0KxfIR8tThfFcir0kcQYxdxYg==
X-Received: by 2002:adf:fc8b:: with SMTP id g11mr19587553wrr.300.1603738371204;
        Mon, 26 Oct 2020 11:52:51 -0700 (PDT)
Received: from localhost.localdomain (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f7sm24885193wrx.64.2020.10.26.11.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 11:52:50 -0700 (PDT)
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
Subject: [PATCH v8 07/14] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Mon, 26 Oct 2020 19:52:32 +0100
Message-Id: <20201026185239.379417-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201026185239.379417-1-peron.clem@gmail.com>
References: <20201026185239.379417-1-peron.clem@gmail.com>
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
index dee8688f0d37..703327dc8606 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -595,6 +595,13 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -923,13 +930,6 @@ static int sun4i_i2s_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
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

