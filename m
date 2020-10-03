Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824212824A9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 16:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbgJCOUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 10:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgJCOUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 10:20:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4F1C0613D0;
        Sat,  3 Oct 2020 07:20:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so4854112wrt.3;
        Sat, 03 Oct 2020 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GG2/Dd/Pfj/stdMqywLnjL8coxrUAoJ9mpk4ojfM8Fo=;
        b=La5vwbHbR1jnuvX12uTDXOVFTg8mLqrERM77iYNSjm1KNsRBosLxvWRu0yvxuJfMEJ
         oTsZwReZD2qO+v6/quG0T2tQZmS6pdJWwBlnypjIAU3upGKteJHeCCCgvo7KKkKVSrqq
         4/IUGA5cCxNkXiZ2ma58E5VilDg+IjTfRom4NzUYx0WVar9xknPKMDaGg4mbkYLsp1PZ
         Q42NrBqaSxt/eGWeeA9ySF8Fk2+xGKCMmgx+L/ba3Du0jkHx4S3apzU3jDydVaKz4wd+
         nJzuo/0DzG+s6gNa2txaGf4x/EJhSyCWAPhOTvEbd/A2L93VThZQQ5P0oki0G8F40xEr
         9ktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GG2/Dd/Pfj/stdMqywLnjL8coxrUAoJ9mpk4ojfM8Fo=;
        b=sUXi4Y0B1MAUUNfIaKIiJvsMfQvDnc8T4bTK8SMx3A9JOpzG/1FYqHDsYK8efdAhp1
         o8mJAVxnbUKRjbbUt2uRrYaDHe0Z60CFV/bCINLP8HYdGuLPj7semS9W0tXjws9yPYGk
         m0UIxE/8J4iw0zXwVQohSwXyYZTWSYb0MZhXXQAXFbyarDbIhQ0y4qTVslrZ65lMLcMB
         B80/URLBa71EcN4PMKsaO8k1IdCoifkkBgftu9lKvenxQDixBQDwO3rgbEmFADLET17+
         Meco9Ka1xOhtDeUL38dmCdWP7TtedBgPCGJ1CncunPwIfbyTC/rSBVtEANHZjmzY9kEp
         XbmQ==
X-Gm-Message-State: AOAM531taIbhHA/xKZQMFunixD8Zxo7JhSLmyBvfM7A+k4YrBQucW+qh
        ZsKMmh0vQQ60TjlmBR5LNhWxU1eWU3CtPg==
X-Google-Smtp-Source: ABdhPJxGRE4IDwwLwXLF61O5XwpP4zJXdg3TDS4HcNO71kQwZRKme1VQ72oK2Ri92ijto3Kb6RNZVg==
X-Received: by 2002:adf:e407:: with SMTP id g7mr2338694wrm.349.1601734807424;
        Sat, 03 Oct 2020 07:20:07 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id d18sm5417473wrm.10.2020.10.03.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2020 07:20:06 -0700 (PDT)
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
Subject: [PATCH v6 06/14] ASoC: sun4i-i2s: Fix sun8i volatile regs
Date:   Sat,  3 Oct 2020 16:19:42 +0200
Message-Id: <20201003141950.455829-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201003141950.455829-1-peron.clem@gmail.com>
References: <20201003141950.455829-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIFO TX reg is volatile and sun8i i2s register
mapping is different from sun4i.

Even if in this case it's doesn't create an issue,
Avoid setting some regs that are undefined in sun8i.

Acked-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index ba7514849b73..92671eb94db9 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1154,12 +1154,19 @@ static bool sun8i_i2s_rd_reg(struct device *dev, unsigned int reg)
 
 static bool sun8i_i2s_volatile_reg(struct device *dev, unsigned int reg)
 {
-	if (reg == SUN8I_I2S_INT_STA_REG)
+	switch (reg) {
+	case SUN4I_I2S_FIFO_CTRL_REG:
+	case SUN4I_I2S_FIFO_RX_REG:
+	case SUN4I_I2S_FIFO_STA_REG:
+	case SUN4I_I2S_RX_CNT_REG:
+	case SUN4I_I2S_TX_CNT_REG:
+	case SUN8I_I2S_FIFO_TX_REG:
+	case SUN8I_I2S_INT_STA_REG:
 		return true;
-	if (reg == SUN8I_I2S_FIFO_TX_REG)
-		return false;
 
-	return sun4i_i2s_volatile_reg(dev, reg);
+	default:
+		return false;
+	}
 }
 
 static const struct reg_default sun4i_i2s_reg_defaults[] = {
-- 
2.25.1

