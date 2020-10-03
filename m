Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2727C28249D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgJCOUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgJCOUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50884C0613E7;
        Sat,  3 Oct 2020 07:20:04 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w2so4363640wmi.1;
        Sat, 03 Oct 2020 07:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tHoXwY3xX0WUoWW6tlHEdcpR0QKtJC6rTb0bCU8aKdk=;
        b=KyaiihczA9bp1LX7qWgkSt46EAF95V23eGPw32uhFY/iinMTcRF/Av22wzxWL0p+9L
         e0OlfkF8hpxyAxyF4n4FQGr9CXJdtTVz7ypzpU5+HzeBqLzrlURAirk3/ZfhJv1ZigpC
         cDuCrUsIkCpqakqiCECklcve9bxPSpwgvlTYr5MNvCvmJIDackzTdPge/rNB3MgPkymL
         4ePtRtVd85gJmRvYW48hEZS+AemsYUD8BFpXjAfc2sAFJPCT30sreR5Npi3AJqejnUTg
         VDVZqKoP33ZQtw4C8EMaJmss0MWei2xNvnJq6/KEdbXZ7cmAljXqgFrdXus+UdH1865+
         Gpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tHoXwY3xX0WUoWW6tlHEdcpR0QKtJC6rTb0bCU8aKdk=;
        b=hJOemvDHltY3nSFtQkmcEjPML2U+h35FBylU+6bJlTbguPcdE3u/JbUzjUhSe7ekQl
         9jZsRU7O+H7eSDgEgldQWCFTFkToUeR7lRKkUSEjWisWp1oY9jETyPHtMSa62B1zktlS
         btI8oCOL5jEbU8+G61Wl8pmh65qAbcjEbi4Danhlt3rOUsS3mI0GTFV3TitmtM8TOqHZ
         6wLCD5+UA4iCJg9yz30RWUvNxGvVMq5ZtK1fjRPFcsCdqgq3iN+VH9B+HfMgshZu9RGE
         8c8ZX3riC43jnPtomFz0Tm0ZdIwuWsaduUXTt5tJ2Xod8YBReU10H4neVtCNPVeS3iD9
         rr6Q==
X-Gm-Message-State: AOAM5336KHfzhTxwuM5rGbpfFa5xSCB5F/I6PFr3uKnNBBE6IVBQg1ze
        B+wq5f8DdzXWRbZhJ1Lhy6E=
X-Google-Smtp-Source: ABdhPJyGv3V6mW6itpDq4Ks0Rmgohv1x8u28ITJfQRFuJkpTdhbP4zQdzEdvyDK2xOwI8QF1cxIN+A==
X-Received: by 2002:a7b:cc88:: with SMTP id p8mr8098841wma.150.1601734802909;
        Sat, 03 Oct 2020 07:20:02 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:01 -0700 (PDT)
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
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v6 04/14] ASoC: sun4i-i2s: Set sign extend sample
Date:   Sat,  3 Oct 2020 16:19:40 +0200
Message-Id: <20201003141950.455829-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

On the newer SoCs such as the H3 and A64 this is set by default
to transfer a 0 after each sample in each slot. However the A10
and A20 SoCs that this driver was developed on had a default
setting where it padded the audio gain with zeros.

This isn't a problem while we have only support for 16bit audio
but with larger sample resolution rates in the pipeline then SEXT
bits should be cleared so that they also pad at the LSB. Without
this the audio gets distorted.

Set sign extend sample for all the sunxi generations even if they
are not affected. This will keep consistency and avoid relying on
default.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index 8e497fb3de09..73103673643a 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -48,6 +48,9 @@
 #define SUN4I_I2S_FMT0_FMT_I2S				(0 << 0)
 
 #define SUN4I_I2S_FMT1_REG		0x08
+#define SUN4I_I2S_FMT1_REG_SEXT_MASK		BIT(8)
+#define SUN4I_I2S_FMT1_REG_SEXT(sext)			((sext) << 8)
+
 #define SUN4I_I2S_FIFO_TX_REG		0x0c
 #define SUN4I_I2S_FIFO_RX_REG		0x10
 
@@ -105,6 +108,9 @@
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_INVERTED		(1 << 7)
 #define SUN8I_I2S_FMT0_BCLK_POLARITY_NORMAL		(0 << 7)
 
+#define SUN8I_I2S_FMT1_REG_SEXT_MASK		GENMASK(5, 4)
+#define SUN8I_I2S_FMT1_REG_SEXT(sext)			((sext) << 4)
+
 #define SUN8I_I2S_INT_STA_REG		0x0c
 #define SUN8I_I2S_FIFO_TX_REG		0x20
 
@@ -678,6 +684,7 @@ static int sun4i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 	}
 	regmap_update_bits(i2s->regmap, SUN4I_I2S_CTRL_REG,
 			   SUN4I_I2S_CTRL_MODE_MASK, val);
+
 	return 0;
 }
 
@@ -780,6 +787,11 @@ static int sun8i_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
 			   val);
 
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
+			   SUN8I_I2S_FMT1_REG_SEXT_MASK,
+			   SUN8I_I2S_FMT1_REG_SEXT(0));
+
 	return 0;
 }
 
@@ -882,6 +894,11 @@ static int sun50i_h6_i2s_set_soc_fmt(const struct sun4i_i2s *i2s,
 			   SUN8I_I2S_CTRL_BCLK_OUT | SUN8I_I2S_CTRL_LRCK_OUT,
 			   val);
 
+	/* Set sign extension to pad out LSB with 0 */
+	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT1_REG,
+			   SUN8I_I2S_FMT1_REG_SEXT_MASK,
+			   SUN8I_I2S_FMT1_REG_SEXT(0));
+
 	return 0;
 }
 
-- 
2.25.1

