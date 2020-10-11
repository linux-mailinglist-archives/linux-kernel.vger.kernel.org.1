Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5028AA46
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbgJKUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 16:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729246AbgJKUWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 16:22:53 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E5EC0613CE;
        Sun, 11 Oct 2020 13:22:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q63so16070006qkf.3;
        Sun, 11 Oct 2020 13:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8+oP++IDX+TWr9W8oZTbwkkM6rISpxgkl78X/PIuT+s=;
        b=d59DH9WLcL+dOgLluVb9q429BtG4LALyLEUJQb+dDs/SB3Brrb/Yur83xfyq4UAiTe
         O5TGgXf4cySYKPIO3eo6FvB/jhuVmKM4JKUsTMIbyyTof7lJaCBNJTtqeENQ6la5WvBB
         67WYBAizr3w45CndFLFp9EOuLnOQaFwCcl5DVcwAX4pUA6Ur4Dbc0xSN9WKzLn2DICvQ
         OcYtMs2vp5Dodz5uhIrqbCQQp7I8vPmq8XQkq7e57ZExLaYif4Kaxw6ePhrPsyfPziTy
         +cMggT3vrXmy7C1AhgdWZ1B1GO+PCbxSybWHrLmb9GVUx67hhsmKh87bo7nXpok/qJgv
         NOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+oP++IDX+TWr9W8oZTbwkkM6rISpxgkl78X/PIuT+s=;
        b=Pb0zERzsY+nMM+5qfPWw6TJPLK+F38Id54z912gbaDGATc0K8nQsSFcIZMzdyiqTBd
         ezU2IfPvE5pdIylnz6Z1K0U7KUPTPo/Gk2s8w6v0WBiBfD9MPh/2mLunQ8TI26t2P8lT
         lytx5J5epqZNfAIsciD40VijwJEV7Mowij9hpVS3keTL2EHPkcdabl4xKr8TOC4AHheV
         /Hl25n26s7DsJpjdOTrtuWu94UydieYlcwYVQjvbcRuDt3wN0UYSeEZ1swnMrGTPN2la
         yGTO00URB2RI2oLwhAMn2yy48kwz3y9x/H3GpIn3hAQ661qEkcczLaJf/Xy2CKuRbHU2
         8V5w==
X-Gm-Message-State: AOAM533SSGOLGkGrO4B3QlFFJNz202PmUGg53kSyq2qJq4oT4qUHRg/O
        51au9mgFJ3+gm592q+UeeSs=
X-Google-Smtp-Source: ABdhPJwpkzOPa3fw7jDMn1v4AWa/1gBNcuwFcYb4ee8gA8XqsjEiJRn4mAIBI04Z9pSC2wW7MVi5lg==
X-Received: by 2002:a37:a9c9:: with SMTP id s192mr7124715qke.128.1602447772374;
        Sun, 11 Oct 2020 13:22:52 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id c72sm2987778qkg.56.2020.10.11.13.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 13:22:51 -0700 (PDT)
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
Subject: [PATCH v7 07/14] ASoC: sun4i-i2s: Fix setting of FIFO modes
Date:   Sun, 11 Oct 2020 22:22:17 +0200
Message-Id: <20201011202224.47544-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201011202224.47544-1-peron.clem@gmail.com>
References: <20201011202224.47544-1-peron.clem@gmail.com>
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
index 3fc0bd818539..e7b9dcbf82db 100644
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

